from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from django.core.exceptions import ObjectDoesNotExist, PermissionDenied, ValidationError
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import status, serializers
from rest_framework.views import APIView
from base.serializers import *
from base.models import *
from datetime import datetime, timedelta

from django.views import generic, View
from django.core.exceptions import ValidationError, ObjectDoesNotExist
from django.views.decorators.csrf import csrf_exempt, csrf_protect


@api_view(["GET"])
def getStory(request, pk):
    try:
        item = Story.objects.get(pk=pk)
    except ObjectDoesNotExist:
        raise serializers.ValidationError("Item does not exist.", 404)
    serializer = StorySerializer(item)
    return Response(serializer.data)


class StoriesList(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request, *args, **kwargs):
        try:
            queryset = Story.objects.all().order_by("-created_at")

            count = int(self.request.query_params.get("count", 0))
            user = self.request.query_params.get("user", None)
            category = self.request.query_params.get("category", None)
            from_date = self.request.query_params.get("from_date", None)
            to_date = self.request.query_params.get("to_date", None)
            search_words = self.request.query_params.get("search_words", None)

            if user:
                queryset = queryset.filter(user=user)
            if category:
                queryset = queryset.filter(category__keyword=category)
            if from_date and to_date:
                date_format = "%Y-%m-%d"
                from_date = datetime.strptime(from_date, date_format)
                to_date = datetime.strptime(to_date, date_format)
                to_date = to_date + timedelta(days=1)
                queryset = queryset.filter(created_at__range=[from_date, to_date])
            if search_words:
                queryset = queryset.filter(full_detail__contains=search_words)
            if count:
                queryset = queryset[:count]

        except ObjectDoesNotExist:
            raise serializers.ValidationError("Item does not exist.", 404)

        serializer = StorySerializer(queryset, many=True)
        return Response(serializer.data)


@api_view(["POST"])
@csrf_exempt
@permission_classes([IsAuthenticated])
def postStory(request):
    data = request.data
    story_finance = StoryFinance.objects.create(
        total_fund_request_size=float(data["fund_request_size"]), current_donated_size=0
    )
    story_finance.save()
    profile = UserProfile.objects.get(user=request.user)
    story = Story.objects.create(
        user=profile,
        heading=data["heading"],
        sub_heading=data["sub_heading"],
        country=data["country"],
        summary=data["summary"],
        is_verified=True,
        full_detail=data["full_detail"],
        finance=story_finance,
    )
    for tag in data["category"].split(", "):
        story_tag = StoryTag.objects.get_or_create(
            keyword=tag
        )
        story.tags.add(story_tag[0])
    story.save()
    serializer = StorySerializer(story)
    return Response(serializer.data)


@api_view(["POST"])
@permission_classes([IsAuthenticated])
def likeStory(request, pk):
    item = Story.objects.get(pk=pk)
    profile = UserProfile.objects.get(user=request.user)
    like = Like.objects.create(user=profile, story=item)
    like.save()
    return Response(True)


@api_view(["PUT"])
@permission_classes([IsAuthenticated])
def unlikeStory(request, pk):
    user = request.user
    try:
        pf = UserProfile.objects.prefetch_related("like_user").get(user=user)
        like = pf.like_user.filter(story_id=pk)
        like.delete()
        return Response(True)
    except PermissionDenied or ObjectDoesNotExist as e:
        if type(e) is PermissionDenied:
            raise serializers.ValidationError("Login First")
        elif type(e) is ObjectDoesNotExist:
            raise serializers.ValidationError("Object Does Not Exist.")
