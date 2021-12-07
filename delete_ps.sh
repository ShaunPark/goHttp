#!/bin/bash

API_SERVER=localhost:5000
API_URL=http://$API_SERVER/api/v1/users
JQUERY_STR=.data[].id
PS_DIR=/home/ubuntu/testdir

echo "# Quering Users from API Server"
users=($(curl -sb -H "Accept: application/json" \
  -H "implicit-authenticated-for: bee.admin" \
  -H "Authorization: Bearer implicit-token" \
  $API_URL | jq -c $JQUERY_STR | tr -d '"'))

echo "---------------------------------"
echo " Total '${#users[@]}' users exist."
echo "================================="
echo "# Getting PS directories"

dirs=($(ls -d $PS_DIR/*/  | awk '{n=split($NF,a,"/");print  a[n-1]}')); 

echo "---------------------------------"
echo " Total '${#dirs[@]}' project storage directories exist."
echo "================================="

delDirs=()
for i in "${dirs[@]}"; do
    skip=
    for j in "${users[@]}"; do
        [[ $i == $j ]] && { skip=1; break; }
    done
    [[ -n $skip ]] || delDirs+=("$i")
done
echo "# Compare users and directories"
echo "---------------------------------"
echo " Total '${#delDirs[@]}' project storage directories need to be deleted."
echo "================================="

for i in "${delDirs[@]}"
do
   :
  read -p "Are you sure delete directory '"$PS_DIR"/"$i"'? (Y/n) : " -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      echo "Deleting "$PS_DIR"/"$i
      #eval "rm -rf " $PS_DIR"/"$i
      echo $PS_DIR"/"$i "is deleted"
  else 
      echo $PS_DIR"/"$i "is not deleted"
  fi
  echo "---------------------------------"
done
