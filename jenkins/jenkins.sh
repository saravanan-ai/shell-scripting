#!/bin/bash

JENKINS_URL="http://localhost:8080"
JENKINS_USER="xxx"
JENKINS_TOKEN="xxxx"
#generate api token in jenkins using top right Account > configure > API token
JOB_NAME="test"

JENKINS_AUTH="$JENKINS_USER:$JENKINS_TOKEN"

#CRUMB=$(curl --user "$JENKINS_AUTH" "$JENKINS_URL"'/crumbIsuser/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')

CRUMB=$(curl --user "$JENKINS_AUTH" "$JENKINS_URL/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,\":\",//crumb)")
echo $CRUMB

echo $JENKINS_AUTH
echo $JENKINS_URL
echo $job

RESPONSE_ERROR=$(echo "$CRUMB" | grep "<html>" || true )

if [ -n "$RESPONSE_ERROR" ]
then
  echo "CRUMB ERROR"
  exit 1
else
  curl --user "$JENKINS_AUTH" -H "$CRUMB" -X POST "$JENKINS_URL/job/$JOB_NAME/build"
fi
