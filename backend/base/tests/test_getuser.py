from django.test import TestCase
from django.contrib.auth.hashers import make_password
from rest_framework.permissions import IsAuthenticated, IsAdminUser, has_permission
from base.serializers import UserSerializerWithToken, UserSerializer
from rest_framework.response import Response
from rest_framework.test import APIRequestFactory, force_authenticate

from ..models import *
from django.contrib.auth.models import User
from ..views.user_view import getUser, getUsers

class GetUserTest(TestCase):
    def setup(self):
        self._factory = APIRequestFactory()
        self._user = User.object.create(
            first_name = 'testUser',
            username = 'TestUser',
            email = 'testuser@gmail.com',
            password = make_password('12345678'))

    def test_auth(self):
        """
        If authentication fails, an appropriate message is displayed
        """
        request = self._factory.get('/api/user/getuser')
        response = has_permission(request.user.is_authenticated)
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data, True)

    def test_admin(self):
        """
        If the request isn't from an admin user, an appropriate message is displayed
        """
        request = self._factory.get('/api/user/getuser/')
        response = has_permission(request.user.is_staff)
        self.assertEqual(response.status_code, 401)
        self.assertEqual(response.data, True)

    def test_get_users_info(self):
        """
        Test getUser(s)
        """
        request = self._factory.get('/api/user/getuser/', self._user)
        force_authenticate(request, user = self._user)
        response = getUser(request)
        self.assertEqual(response.status_code, 200, msg = f'{response.data}')

        data = {'first_name':'testUser', 'username':'TestUser',
                'email':'testuser@gmail.com', 'password':'12345',
                'category':['test','test1']}

        for k,v in data.items():
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
            else:
                self.assertEqual(response.data[k], v, msg=f'{response.data} {v}')

