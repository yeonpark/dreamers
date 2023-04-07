from django.test import TestCase
from django.contrib.auth.hashers import make_password
from rest_framework.response import Response
from base.serializers import StoryBriefSerializer, StorySerializer
from rest_framework.test import APIRequestFactory, force_authenticate
# Create your tests here.
from ..models import *
from ..views.story_view import postStory


def create_story():
  try:
    user = User.objects.get(username='johndoe@gmail.com')
  except:
    user = User.objects.create(
      username='johndoe@gmail.com',
      email='johndoe@gmail.com',
      password=make_password('janedoe')
    )

  newStory = Story.objects.create(
    user=user,
    heading="TEST",
    sub_heading="test",
    country="hk",
    summary="loris ipsum corpus callosum",
    full_detail="loris ipsum corpus callosum sefja elfijseilsj",
    isVerified="True"
  )

  return StoryBriefSerializer(newStory).data

class StoryViewTest(TestCase):
  def setUp(self):
    # API request factory
    self._factory = APIRequestFactory()
    # Creates User to force authenticate later
    self._user = User.objects.create(
      first_name='testuser',
      username='test@gmail.com',
      email="test@gmail.com", 
      password=make_password('12345'))
    
  def test_no_story(self):
    """
      If no questions exist, an appropriate message is displayed
    """
    response = self.client.get('/api/story/all/')
    self.assertEqual(response.status_code, 200)
    self.assertEqual(response.data, [])
  
  def test_add_story(self):
    """
      Test Posting Story
    """
    data = {
      "heading":"TEST",
      'sub_heading':"test",
      'country':"hk",
      'summary':"loris ipsum corpus callosum",
      'full_detail':"loris ipsum corpus callosum sefja elfijseilsj",
      'isVerified':True
    }
    # Create post request using factory
    request = self._factory.post('/api/story/post-story/', data, format='json')
    # Force authentication of the user
    force_authenticate(request, user=self._user)
    # get response from the view
    response = postStory(request)
    # Check Status Code
    self.assertEqual(response.status_code, 200, msg=f'{response.data}')
    # Check data
    for k,v in data.items():
      self.assertEqual(response.data[k], v, msg=f'{response.data} {v}')
  
  def test_existing_story(self):
    created = create_story()
    response = self.client.get('/api/story/all/')
    self.assertEqual(response.status_code, 200)
    self.assertEqual(
      response.data, [created]
    ) 