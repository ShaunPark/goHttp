#!/bin/bash

API_SERVER=localhost:5000
API_URL=http://$API_SERVER/api/v1/users
JQUERY_STR=.data[].id
PS_DIR=/home/ubuntu/testdir

users=($(curl -sb -H "Accept: application/json" $API_URL | jq -c $JQUERY_STR | tr -d '"'))
dirs=($(ls -d $PS_DIR/*/  | awk '{n=split($NF,a,"/");print  a[n-1]}')); 

delDirs=()
for i in "${dirs[@]}"; do
    skip=
    for j in "${users[@]}"; do
        [[ $i == $j ]] && { skip=1; break; }
    done
    [[ -n $skip ]] || delDirs+=("$i")
done

echo "${delDirs[*]}"
echo "-----------"
for i in "${delDirs[@]}"
do
   :
  echo $i
done
