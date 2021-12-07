#!/bin/bash

API_SERVER=localhost:5000
API_URL=http://$API_SERVER/api/v1/users
JQUERY_STR=.data[].id
PS_DIR

users=()
curl -sb -H "Accept: application/json" $API_URL | jq -c $JQUERY_STR | while read object; do
  echo $object
  users+=("$object")
done

dirs=()
ls -d ~/*/ | while read dir; do 
  dirs+=($(echo $dir | awk '{n=split($NF,a,"/");print  a[n-1]}')); 
done

echo "${users[*]}"
echo "-----------"
echo "${dirs[*]}"
