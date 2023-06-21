from django.urls import path
from base.views import story_view as views

app_name = 'base/story'

urlpatterns = [
    path('all/', views.StoriesList.as_view(), name='get-stories'),
    # path('category', views.get),
    path('post-story/', views.postStory, name='post-story'),
    path('<str:pk>/', views.getStory, name='get-story'),
]
