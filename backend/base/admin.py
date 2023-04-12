from django.contrib import admin
from .models import *

admin.site.register([Social, ApplicationCategory, Story, StoryImage])
# Register your models here.