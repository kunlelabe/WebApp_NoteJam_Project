FROM python:3.8

RUN mkdir /app

WORKDIR /app

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
    
COPY . /app
 
RUN export PYTHONPATH=/usr/bin/python \
 && python -m pip install flake8
 if [ -f requirements.txt ]; then pip install -r requirements.txt; fi

COPY . ,

EXPOSE 5000

ENV FLASK_APP=runserver:app
CMD ["flask", "run", "--host", "0.0.0.0"]
