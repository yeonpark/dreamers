from rest_framework import serializers
from django.contrib.auth.models import User
from rest_framework_simplejwt.tokens import RefreshToken
from .models import *

# User
class UserSerializer(serializers.ModelSerializer):
  name = serializers.SerializerMethodField(read_only=True)
  _id = serializers.SerializerMethodField(read_only=True)
  is_admin = serializers.SerializerMethodField(read_only=True)

  class Meta:
    model = User
    fields = ('_id', 'is_admin', 'username', 'email', 'name')
  
  def get__id(self,obj):
    return obj.id

  def get_is_admin(self, obj):
    return obj.is_staff

  def get_name(self, obj) :
    name = obj.first_name
    if name == '':
      name = obj.username
    return name
  

class UserSerializerWithToken(UserSerializer):
  token = serializers.SerializerMethodField(read_only=True)
  
  class Meta:
    model = User
    fields = ('_id', 'is_admin', 'username', 'email', 'name', 'token')
  
  def get_token(self, obj):
    token = RefreshToken.for_user(obj)
    return str(token.access_token)
  
# Application Schema
class ApplicationSchemaSerializer(serializers.ModelSerializer):
  class Meta:
    model = ApplicationSchema
    fields = '__all__'



# Story
class StoryBriefImageSerializer(serializers.ModelSerializer):
  thumbnail_image = serializers.ReadOnlyField(source="thumbnail_image.url")
  class Meta:
    model = StoryImage
    fields = ('thumbnail_image', 'thumbnail')

class StoryImageSerializer(serializers.ModelSerializer):
  thumbnail_image = serializers.ReadOnlyField(source="thumbnail_image.url")
  class Meta:
    model = StoryImage
    fields = ('image', 'thumbnail_image','thumbnail')

class StorySerializer(serializers.ModelSerializer):
  images = StoryImageSerializer(source="item_image", many=True)
  creator = UserSerializer(source="user", read_only=True)
  title = serializers.ReadOnlyField(source="heading")
  createDate = serializers.ReadOnlyField(source="createdAt")
  description = serializers.ReadOnlyField(source="full_detail")

  class Meta:
    model = Story
    fields = ('creator', 'createDate', 'title', 'description', 'category', 'images')


class StoryBriefSerializer(serializers.ModelSerializer):
  story_thumbnail = StoryBriefImageSerializer(source="item_image", many=True)
  title = serializers.ReadOnlyField(source="heading")
  createDate = serializers.ReadOnlyField(source="createdAt")

  class Meta:
    model = Story
    fields = ('createDate', 'title', 'summary', 'category', 'story_thumbnail')