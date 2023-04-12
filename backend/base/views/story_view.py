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

  # Monthly and Scholarhips Inheriting ApplicationSchema allows flexibiliity
  parent = ApplicationSchema.objects.create(
    schema_name=data['schema']
  )
  
  if data['schema'] == 'monthly':
    MonthlyApplicationSchema.objects.create(
      month_cnt = data['month_cnt'],
      monthly_stipend = data['monthly_stipend'],
      parent = parent,
    )
  elif data['schema'] == 'tuition':
    ScholarshipApplicationSchema.objects.create(
      institution_name = data['institution_name'],
      tuition = data['tuition'],
      parent = parent
    )
  
  story = Story.objects.create(
    user=request.user,
    heading=data['heading'],
    sub_heading=data['sub_heading'],
    country=data['country'],
    summary=data['summary'],
    full_detail=data['full_detail'],
    is_verified=True,
    schema=parent
  )
  for cat in data['category']:
    if ApplicationCategory.objects.filter(keyword=cat).exists():
      story.category.add(ApplicationCategory.objects.get(keyword=cat))
    else:
      story.category.add(ApplicationCategory.objects.create(keyword=cat))

  reqImages = request.FILES.getlist('images')
  for i, reqImage in enumerate(reqImages):
    StoryImage.objects.create(
      item= story,
      image = reqImage,
      thumbnail = (i < 2)
    )

  serializer = StorySerializer(story)
  return Response(serializer.data)
  