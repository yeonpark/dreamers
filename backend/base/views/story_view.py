from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework import status, serializers
from base.serializers import *
from base.models import *

from django.views import generic
from django.core.exceptions import ValidationError, ObjectDoesNotExist


@api_view(['GET'])
def getStory(request, pk):
  try:
    item = Story.objects.get(pk=pk)
  except ObjectDoesNotExist:
    raise serializers.ValidationError("Item does not exist.", 404) 
  serializer = StorySerializer(item)
  return Response(serializer.data)

@api_view(['GET'])
def getStories(request):
  try:
    item = Story.objects.all().order_by('-createdAt')[:5]
  except ObjectDoesNotExist:
    raise serializers.ValidationError("Item does not exist.", 404) 
  serializer = StoryBriefSerializer(item, many=True)
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
  for cat in data['category']:
    story.category.add(ApplicationSchema.objects.create(keyword=cat))
  serializer = StorySerializer(story)
  return Response(serializer.data)
  