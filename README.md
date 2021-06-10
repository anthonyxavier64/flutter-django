# flutter-django
Application to experiment with the following technologies:
- Firebase storage
- ElephantSQL
- Postgresql
- Django
- Django Rest Framework
- Flutter

In this application, you will be able to:
- Register
- Login
- Upload photo
<hr>
RUNNING THE APPLICATION
<br/><br/>
In the root folder containing both frontend and backend folders:<br/>
*ENSURE YOU HAVE PYTHON INSTALLED*<br/>
- create a python environment:
  - Windows: python -m venv py_env
  - MacOS: python3 -m venv py_env

- Activate python environment:
  - Windows: py_env\scripts\activate
  - MacOS: source py_env/bin/activate

- Install dependencies:<br/>
  *ENSURE THAT YOU ARE IN BACKEND_ROOT FOLDER*
  - pip install -r requirements.txt

In the frontend folder:
- Install Flutter dependencies:
  - flutter pub get

Run backend server:<br/>
*ENSURE YOU ARE IN BACKEND_ROOT FOLDER*<br/>
*ENSURE PYTHON ENVIRONMENT IS ACTIVATED*
- python manage.py runserver

How to install Android emulator:<br/>
*ENSURE YOU HAVE ANDROID STUDIO INSTALLED*
- https://docs.expo.io/workflow/android-studio-emulator/ (Documentation)
- https://www.youtube.com/watch?v=LgRRmgfrFQM (Video)

Run frontend flutter client:<br/>
*ENSURE THE DEVICE THAT VISUAL STUDIO CODE IS CONNECTED TO IS AN ANDROID EMULATOR*
- flutter run
