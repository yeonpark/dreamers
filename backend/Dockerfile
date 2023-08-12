FROM python:3.8-buster

ENV PYTHONBUFFERED=1

WORKDIR /django

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

RUN python manage.py makemigrations
RUN python manage.py migrate
CMD python manage.py runserver 127.0.0.1:8000