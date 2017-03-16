#!/bin/bash

cd ..
gem install warbler
bundle install

echo "building war file"
warble executable war

echo "moving app.was to build folder"
mv app.war build/app.war