from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAdminUser
from rest_framework.response import Response

@api_view(['GET'])
def isServerOn(request):
  return Response("Server On")