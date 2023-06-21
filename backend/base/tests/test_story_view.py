from django.test import TestCase
from django.contrib.auth.hashers import make_password
from rest_framework.response import Response
from base.serializers import StoryBriefSerializer, StorySerializer
from rest_framework.test import APIRequestFactory, force_authenticate
# Create your tests here.
from ..models import *
from ..views.story_view import postStory


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

        self._data = {
            "heading": "TEST",
            'sub_heading': "test",
            'country': "hk",
            'summary': "loris ipsum corpus callosum",
            'full_detail': "loris ipsum corpus callosum sefja elfijseilsj",
            'is_verified': True,
            'category': ['test', 'test1'],
            'schema': 'monthly',
            'month_cnt': 1,
            'monthly_stipend': 2332.43
        }

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
        # Create post request using factory
        request = self._factory.post(
            '/api/story/post-story/', self._data, format='json')
        # Force authentication of the user
        force_authenticate(request, user=self._user)
        # get response from the view
        response = postStory(request)
        # Check Status Code
        self.assertEqual(response.status_code, 200, msg=f'{response.data}')
        # Check data
        for k, v in self._data.items():
            if (k == 'category'):
                count_keyword = {}
                categories = response.data[k]
                for i in range(len(categories)):
                    if categories[i]['keyword'] not in count_keyword:
                        count_keyword[categories[i]['keyword']] = 0
                    count_keyword[categories[i]['keyword']] += 1
                for i in range(len(v)):
                    count_keyword[v[i]] -= 1
                for k in count_keyword:
                    self.assertEqual(count_keyword[k], 0)

            elif (k == 'schema'):
                self.assertEqual(
                    v, response.data['schema']['schema_name'], msg=f'{response.data} {v}')

            elif (k == 'month_cnt'):
                self.assertEqual(
                    v, response.data['schema']['schema'][k], msg=f'{response.data} {v}')

            elif (k == 'monthly_stipend'):
                self.assertEqual(
                    str(v), response.data['schema']['schema'][k], msg=f'{response.data} {v}')

            else:
                self.assertEqual(
                    response.data[k], v, msg=f'{response.data} {v}')

    def test_existing_story(self):
        # Create post request using factory
        request = self._factory.post(
            '/api/story/post-story/', self._data, format='json')
        # Force authentication of the user
        force_authenticate(request, user=self._user)
        # get response from the view
        response = postStory(request)
        response = self.client.get('/api/story/all/')
        self.assertEqual(response.status_code, 200)
