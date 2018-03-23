#!/bin/sh

# docke容器入口点
apk add --no-cache postgresql-dev
cd /sample_app
bin/bundle install
bin/rails s 
