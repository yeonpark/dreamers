from django.contrib import admin
from .models import *

admin.site.register([Social, StoryTag, Story, StoryImage])
# Register your models here.