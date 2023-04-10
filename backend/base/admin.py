from django.contrib import admin
from .models import *

admin.site.register([Social, ApplicationSchema, Story, StoryImage])
# Register your models here.