import base64
import requests
from rest_framework.views import APIView
from rest_framework.response import Response
from dotenv import dotenv_values
from django.http import HttpResponseRedirect

# Retreiving API credentials from dotenv
creds = {}
config = dotenv_values(".env")
for key, value in config.items():
    creds[key] = value

clientID = creds['clientID']
clientSecret = creds['clientSecret']


# Function returning Paypal Sandbox access token
def PaypalToken(client_ID, client_Secret):
    url = "https://api.sandbox.paypal.com/v1/oauth2/token"
    data = {
        "client_id": client_ID,
        "client_secret": client_Secret,
        "grant_type": "client_credentials"
    }
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": "Basic {0}".format(base64.b64encode((client_ID + ":" + client_Secret).encode()).decode())
    }
    token = requests.post(url, data, headers=headers)
    return token.json()['access_token']

# Creates an order. If payment is approved, it automatically redirects to "capture order" url.


class CreateOrderView(APIView):
    def get(self, request):
        token = PaypalToken(clientID, clientSecret)
        headers = {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer '+token,
        }
        json_data = {
            "intent": "CAPTURE",
            "application_context": {
                "notify_url": "https://notify.eu",
                # Redirects to "capture order" url if payment is approved
                "return_url": "https://www.google.com",
                # "return_url": "https://www.google.com",
                "cancel_url": "https://www.cancel.com",
                "brand_name": "Dreamers",
                "landing_page": "BILLING",
                "shipping_preference": "NO_SHIPPING",
                "user_action": "CONTINUE"
            },
            "purchase_units": [
                {
                    "reference_id": "294375635",
                    "description": "Arsenal",

                    "custom_id": "Arsenal-Champions",
                    "soft_descriptor": "Arsenal-UCL-Chammpions",
                    "amount": {
                        "currency_code": "HKD",  # Currency
                        "value": "1"  # Price
                    },
                    "payee": {
                        "email_address": "dreamersbiz@business.example.com",
                    }
                }
            ]
        }
        response = requests.post(
            'https://api-m.sandbox.paypal.com/v2/checkout/orders', headers=headers, json=json_data)
        linkForPayment = response.json()['links'][1]['href']
        return HttpResponseRedirect(redirect_to=linkForPayment)
        # return Response(linkForPayment)

# Captures the order. Returns order/payment details.


class CaptureOrderView(APIView):
    def get(self, request):
        auth_token = PaypalToken(clientID, clientSecret)
        transaction_token = request.query_params['token']
        headers = {"Content-Type": "application/json",
                   "Authorization": "Bearer "+auth_token}
        response = requests.post(
            'https://api-m.sandbox.paypal.com/v2/checkout/orders/'+transaction_token+'/capture', headers=headers)
        return Response(response.json())
