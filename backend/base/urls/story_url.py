from django.urls import path
from base.views import story_view as views

app_name='base/story'

urlpatterns = [
  path('all/', views.getStories, name='get-stories'),
  path('<str:pk>/', views.getStory, name='get-story'),
]