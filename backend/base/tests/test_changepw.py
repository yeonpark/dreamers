from django.test import TestCase
from django.contrib.auth.hashers import make_password
from rest_framework.response import Response
from base.serializers import StoryBriefSerializer, StorySerializer
from rest_framework.test import APIRequestFactory, force_authenticate

from ..models import *
from ..views.user_view import changePassword

class ChangePassWordTest(TestCase):
    def setUp(self):
        self._factory = APIRequestFactory()
        self._user = User.objects.create(
            first_name='testuser',
            username='test@gmail.com',
            email="test@gmail.com", 
            password=make_password('12345'))
    
    def test_current_pw(self):
        """
            If currentPassword is wrong, an appropriate message is displayed
        """
        request = self._factory.put('/api/user/changepw/', {'currentPassword' : '54321', 'newPassword' : '23456'})
        self.assertEqual(request.status_code, 400)
    
    def test_change_pw(self):
        """
            Test changing password
        """
        request = self._factory.put('/api/user/changepw/', {'currentPassword' : '12345', 'newPassword' : '23456'})
        force_authenticate(request, user=self._user)
        response = changePassword(request)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, True)
