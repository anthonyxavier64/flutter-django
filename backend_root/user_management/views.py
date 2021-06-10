from django.shortcuts import render
from user_management.models import User
from django.http.response import JsonResponse

from rest_framework.parsers import JSONParser
from rest_framework import status
from django.views.decorators.csrf import csrf_exempt
from django.core import serializers

import pyrebase
import uuid

from .serializers import UserSerializer
from .models import User

firebaseConfig = {
    "apiKey": "AIzaSyCgNwuxiqmcXHYFrt9Dd5QFakhC4VNX7NA",
    "authDomain": "flutter-django-twilio.firebaseapp.com",
    "projectId": "flutter-django-twilio",
    "storageBucket": "flutter-django-twilio.appspot.com",
    "messagingSenderId": "1055923269409",
    "appId": "1:1055923269409:web:c3bcbe44811f8f4aa39860",
    "databaseURL": "asdf"
  }

firebase = pyrebase.initialize_app(firebaseConfig)
storage = firebase.storage()

# Create your views here.
@csrf_exempt
def register(request):
    user_data = JSONParser().parse(request)
    print(user_data)
    user_serializer = UserSerializer(data=user_data)
    if user_serializer.is_valid():
        print('register data is valid')
        
        print(user_serializer)

        #create an instance
        user = user_serializer.save()

        #Serialize MODEL to JSON
        newUser = UserSerializer(user).data

        return JsonResponse(newUser, status=status.HTTP_201_CREATED)
    return JsonResponse(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
@csrf_exempt
def login(request):
    user_data = JSONParser().parse(request)
    print(user_data)
    user_serializer = UserSerializer(data=user_data)
    print(user_serializer)
    if user_serializer.is_valid():
        print('login data is valid')

        validated_data = user_serializer.validated_data
        user = User.objects.get(email=validated_data['email'])
        
        if user.password == validated_data['password']:

            #Serialize MODEL to JSON
            user = UserSerializer(user).data
            print(user)

            return JsonResponse(user, status=status.HTTP_200_OK)
        else:
            return JsonResponse({'data': None}, status=status.HTTP_404_NOT_FOUND)

    return JsonResponse(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@csrf_exempt
def uploadProfilePicture(request):

    pic = request.FILES['pic']
    pic.name = str(uuid.uuid4())
    userId = request.POST.get('id')
    user = User.objects.get(id=userId)
    print(user)
    print(pic.name)
    user.profilePicId = pic.name
    user.save()
    try:
        bucketPath = 'profile/images/'
        storage.child(bucketPath + pic.name).put(pic)
    except:
        return JsonResponse({}, status=status.HTTP_400_BAD_REQUEST)

    return JsonResponse({'profilePicId': pic.name}, status=status.HTTP_200_OK)
