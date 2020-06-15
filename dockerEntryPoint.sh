#!/bin/bash
#cd seleniumsopck/ /
echo "Running gradle tests"

#Run Gradle
./gradlew clean test --info

while true
do
    sleep 1
done