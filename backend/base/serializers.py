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
  
# Application Category
class ApplicationCategorySerializer(serializers.ModelSerializer):
  class Meta:
    model = ApplicationCategory
    fields = '__all__'

# Application Schema
class MonthlyApplicationSchemaSerializer(serializers.ModelSerializer):
  class Meta:
    model = MonthlyApplicationSchema
    fields = ('_id', 'month_cnt', 'monthly_stipend')

class ScholarshipApplicationSchemaSerializer(serializers.ModelSerializer):
  class Meta:
    model = ScholarshipApplicationSchema
    fields = ('_id', 'institution_name', 'scholarship')

class ApplicationSchemaSerializer(serializers.ModelSerializer):
  schema = serializers.SerializerMethodField()

  class Meta:
    model = ApplicationSchema
    fields = ('_id', 'schema_name', 'schema')

  # Dynamically choose a serializer.
  def get_schema(self, obj):
    if obj.schema_name == 'monthly':
      queryset = MonthlyApplicationSchema.objects.get(parent=obj)
      serializer = MonthlyApplicationSchemaSerializer(queryset)
      return serializer.data
    else:
      queryset = ScholarshipApplicationSchema.objects.get(parent=obj)
      serializer = ScholarshipApplicationSchemaSerializer(queryset)
      return serializer.data
    
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
  user = UserSerializer(read_only=True)
  category = ApplicationCategorySerializer(read_only=True, many=True)
  schema = ApplicationSchemaSerializer()

  class Meta:
    model = Story
    fields = ('_id', 'user', 'createdAt', 'category', 'heading', 'sub_heading', 'full_detail', 'summary', 'images', 'country', 'is_verified', 'schema')


class StoryBriefSerializer(serializers.ModelSerializer):
  story_thumbnail = StoryBriefImageSerializer(source="item_image", many=True)
  title = serializers.ReadOnlyField(source="heading")
  createDate = serializers.ReadOnlyField(source="createdAt")
  category = ApplicationCategorySerializer(read_only=True, many=True)

  class Meta:
    model = Story
    fields = ('_id', 'createDate', 'title', 'summary', 'story_thumbnail', 'category')
