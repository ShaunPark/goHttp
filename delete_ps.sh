#!/bin/bash

API_SERVER=localhost:5000
API_URL=http://$API_SERVER/api/v1/users
JQUERY_STR=.data[].id
PS_DIR=/home/ubuntu/testdir

users=($(curl -sb -H "Accept: application/json" $API_URL | jq -c $JQUERY_STR) | tr -d '"')
dirs=($(ls -d $PS_DIR/*/  | awk '{n=split($NF,a,"/");print  a[n-1]}')); 

echo "${users[*]}"
echo "-----------"
echo "${dirs[*]}"
echo "-----------"
for i in "${users[@]}"
do
   :
  echo $i
done
echo "-----------"
for i in "${dirs[@]}"
do
   :
  echo $i
done
