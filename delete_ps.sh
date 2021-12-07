#!/bin/bash

API_SERVER=localhost:5000
API_URL=http://$API_SERVER/api/v1/users
JQUERY_STR=.data[].id
curl -isb -H "Accept: application/json" $API_URL | jq -c $JQUERY_STR | while read object; do
  echo $object
done

