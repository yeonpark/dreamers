from rest_framework.views import exception_handler
from rest_framework.views import Response
from http import HTTPStatus
from typing import Any, Dict

from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/system/', include('base.urls.system_url')),
    path('api/user/', include('base.urls.user_url')),
    path('api/story/', include('base.urls.story_url')),
    path('api/paypal/', include('base.urls.paypal_url'))
]

def api_exception_handler(exc: Exception, context: Dict[str, Any]) -> Response:
    """Custom API Exception Handler"""
    response = exception_handler(exc, context)
    if response is not None:
        http_code_to_message = {v.value: v.description for v in HTTPStatus}
        error_payload = {
            "error": {
                "status_code": 0,
                "message": "",
                "details": [],
            }
        }
        error = error_payload['error']
        status_code = response.status_code

        error["status_code"] = status_code
        error["message"] = http_code_to_message[status_code]
        error["details"] = response.data
        response.data = error_payload
    return response