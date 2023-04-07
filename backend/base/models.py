import uuid
from django.db import models
from django.contrib.auth.models import User
from imagekit.models import ImageSpecField
from imagekit.processors import ResizeToFill

class Social(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)

class ApplicationSchema(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
  keyword = models.CharField(max_length=30, null=True)

class Story(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
  user = models.ForeignKey(User, on_delete=models.CASCADE, null=False, editable=False, related_name='story_user')
  category = models.ManyToManyField(ApplicationSchema, blank=True,related_name='story_category')
  social = models.OneToOneField(Social, on_delete=models.SET_NULL, null=True, related_name='social_features')
  heading = models.CharField(max_length=50)
  sub_heading = models.CharField(max_length=50)
  country = models.CharField(max_length=30)
  summary = models.TextField()
  full_detail = models.TextField()
  isVerified = models.BooleanField(default=False)
  createdAt = models.DateTimeField(auto_now_add=True)

  def __str__(self):
    return self.heading
  
  class Meta:
    ordering=["createdAt"]


class StoryImage(models.Model):
  item = models.ForeignKey(Story, on_delete=models.CASCADE, related_name='item_image')
  image = models.ImageField(upload_to='item')
  thumbnail_image = ImageSpecField(source='image',
                                  processors=[ResizeToFill(300, 300)],
                                  format='JPEG',
                                  options={'quality': 60})
  thumbnail = models.BooleanField(default=False)

  def __str__(self):
    return self.item.heading