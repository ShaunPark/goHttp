#!/bin/bash

API_SERVER=localhost:5000
API_URL=http://$API_SERVER/api/v1/users

curl -isb -H "Accept: application/json" $API_URL | jq -c '.[]' | while read object; do
  echo $object
done

