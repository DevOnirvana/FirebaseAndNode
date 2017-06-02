FROM python:2.7-alpine

RUN apk add --no-cache curl curl-dev gcc g++

RUN apk update && \
    apk upgrade && \
    apk add git

RUN pip install pymongo

ENV LOG_LEVEL INFO

WORKDIR /app

COPY . .

RUN git config --global user.email "reachanirban95@gmail.com"

RUN which python

CMD [ "python", "" ]