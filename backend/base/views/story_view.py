from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework import status, serializers
from rest_framework.views import APIView
from base.serializers import *
from base.models import *
from datetime import datetime, timedelta

from django.views import generic, View
from django.core.exceptions import ValidationError, ObjectDoesNotExist


@api_view(['GET'])
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
      queryset = Story.objects.all().order_by('-createdAt')

      user = self.request.query_params.get('user', None)
      category = self.request.query_params.get('category', None)
      from_date = self.request.query_params.get('from_date', None)
      to_date = self.request.query_params.get('to_date', None)
      search_words = self.request.query_params.get('search_words', None)

      if user:
        queryset = queryset.filter(user=user)
      if category:
        queryset = queryset.filter(category__keyword=category)    
      if from_date and to_date:
        date_format = '%Y-%m-%d'
        from_date = datetime.strptime(from_date, date_format)
        to_date = datetime.strptime(to_date, date_format)
        to_date = to_date + timedelta(days=1)
        queryset = queryset.filter(createdAt__range=[from_date,to_date])     
      if search_words:
        queryset = queryset.filter(full_detail__contains=search_words)

    except ObjectDoesNotExist:
      raise serializers.ValidationError("Item does not exist.", 404)
    
    serializer = StorySerializer(queryset, many=True)
    return Response(serializer.data) 
  

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def postStory(request):
  data = request.data
  story = Story.objects.create(
    user=request.user,
    heading=data['heading'],
    sub_heading=data['sub_heading'],
    country=data['country'],
    summary=data['summary'],
    full_detail=data['full_detail'],
    isVerified=True,
  )
  for cat in data['category'].split(', '):
    story.category.add(ApplicationSchema.objects.create(keyword=cat))
  serializer = StorySerializer(story)
  return Response(serializer.data)
  