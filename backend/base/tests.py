from django.test import TestCase
from django.contrib.auth.hashers import make_password

from base.serializers import StorySerializer
# Create your tests here.
from .models import *
from django.test import TestCase


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
    isVerified=True
  )

  return StorySerializer(newStory).data

class StoryViewTests(TestCase):
  def test_no_story(self):
    """
      If no questions exist, an appropriate message is displayed
    """
    response = self.client.get('/api/story/all/')
    self.assertEqual(response.status_code, 200)
    self.assertEqual(response.data, [])
  
  def test_existing_story(self):
    created = create_story()
    response = self.client.get('/api/story/all/')
    self.assertEqual(response.status_code, 200)
    self.assertEqual(
      response.data, [created]
    )

