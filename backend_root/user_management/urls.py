from django.conf.urls import url
from user_management import views

urlpatterns = [
    url('register', views.register),
    url('login', views.login),
    url('uploadPicture', views.uploadProfilePicture)
]