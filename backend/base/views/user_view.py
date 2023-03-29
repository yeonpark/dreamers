from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView
from rest_framework import status, serializers

from django.contrib.auth.hashers import make_password, check_password
from django.contrib.auth.models import User
from django.core.exceptions import ValidationError

from base.serializers import UserSerializerWithToken

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
  def validate(self, attrs):
    data = super().validate(attrs)
    serializer = UserSerializerWithToken(self.user).data
    for k,v in serializer.items():
      data[k] = v
    return data

class MyTokenObtainPairView(TokenObtainPairView):
  serializer_class = MyTokenObtainPairSerializer

@api_view(['POST'])
def registerUser(request):
  data = request.data
  try:
    user = User.objects.create(
      first_name = data['name'],
      username = data['email'],
      email=data['email'],
      password=make_password(data['password'])
    )

    serializer = UserSerializerWithToken(user, many=False)
    return Response(serializer.data)
  except:
    message = {'detail' : 'User with this email already exists'}
    return Response(message, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def changePassword(request):
  user = request.user
  data = request.data
  try:
    if not check_password(data['currentPassword'], user.password):
      raise ValidationError('Current Password is wrong')
    user.password = make_password(data['newPassword'])
    user.save()
    return Response(True)
  except ValidationError as e:
    raise serializers.ValidationError(e.message)
  

  
