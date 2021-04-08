FROM python:3.8

RUN mkdir /app

WORKDIR /app

COPY requirements.txt /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        openssh-server \
        vim \
        curl \
        wget \
        tcptraceroute \
    && pip install --upgrade pip \
    && pip install subprocess32 \
    && pip install gunicorn \ 
    && pip install virtualenv \
    && pip install flask
    
RUN export PYTHONPATH=/usr/bin/python \
 && pip install -r requirements.txt

COPY . /app

EXPOSE 8080

CMD ["python", "runserver.py", "db.py", "test.py"]
