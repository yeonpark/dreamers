import uuid
from django.db import models
from django.contrib.auth.models import User
from imagekit.models import ImageSpecField
from imagekit.processors import ResizeToFill

class ApplicationSchema(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
  schema_name = models.CharField(max_length=30)


class MonthlyApplicationSchema(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
  month_cnt = models.IntegerField(null=False)
  monthly_stipend = models.DecimalField(max_digits=7, decimal_places=2, default=0)
  parent = models.OneToOneField(ApplicationSchema, on_delete=models.CASCADE, related_name='schema_monthly')

class ScholarshipApplicationSchema(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
  institution_name = models.CharField(max_length=30)
  tuition = models.DecimalField(max_digits=7, decimal_places=2, default=0)
  parent = models.OneToOneField(ApplicationSchema, on_delete=models.CASCADE, related_name='schema_scholarship')

class Social(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)

class ApplicationCategory(models.Model):
  keyword = models.CharField(primary_key=True, max_length=30)

class Story(models.Model):
  _id = models.UUIDField(primary_key=True, editable=False, default=uuid.uuid4)
  user = models.ForeignKey(User, on_delete=models.CASCADE, null=False, editable=False, related_name='story_user')
  category = models.ManyToManyField(ApplicationCategory, blank=True, related_name='story_category')
  social = models.OneToOneField(Social, on_delete=models.SET_NULL, null=True, related_name='social_features')
  heading = models.CharField(max_length=50)
  sub_heading = models.CharField(max_length=50)
  country = models.CharField(max_length=30)
  summary = models.TextField()
  full_detail = models.TextField()
  is_verified = models.BooleanField(default=False)
  createdAt = models.DateTimeField(auto_now_add=True)
  schema = models.OneToOneField(ApplicationSchema, blank=False, on_delete=models.CASCADE ,related_name="story_schema")

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