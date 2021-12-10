#!/bin/bash

#API_SERVER=localhost:5000
#PS_DIR=/home/ubuntu/testdir
#DRYRUN=true

API_URL=http://$API_SERVER/api/v1/users
JQUERY_STR=.data[].id
TEMP_USER_FILE=./users.txt

echo "# Quering Users from API Server"
rescode=$(curl -H "Accept: application/json" \
  -H "implicit-authenticated-for: bee.admin" \
  -H "Authorization: Bearer implicit-token" \
  -o $TEMP_USER_FILE -s -w "%{http_code}" \
  $API_URL) 

if [[ $rescode =~ ^2 ]]
then
else
  echo "Fail to get user list from API Server : "$rescode
  echo "================================="
  exit 1
fi
users=($(cat $TEMP_USER_FILE | jq -c $JQUERY_STR | tr -d '"'))
rm $TEMP_USER_FILE

if [[ ${#users[@]} -eq 0 ]]
then
  echo "Fail to get user list from API Server : user count is 0"
  echo "================================="
  exit 1
fi

echo "---------------------------------"
echo " Total '${#users[@]}' users exist."
echo "================================="
echo "# Getting PS directories"

dirs=($(ls -d $PS_DIR/*/  | awk '{n=split($NF,a,"/");print  a[n-1]}')); 

echo "---------------------------------"
echo " Total '${#dirs[@]}' personal storage directories exist."
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
echo " Total '${#delDirs[@]}' personal storage directories need to be deleted."
echo "================================="

for i in "${delDirs[@]}"
do
   :
    echo "Deleting "$PS_DIR"/"$i
    if [[ $DRYRUN -eq "true" ]]
    then
        echo "DRYRUN is true. skip deleting directory."
    else
        eval "rm -rf " $PS_DIR"/"$i
        echo $PS_DIR"/"$i "is deleted"
    fi
  echo "---------------------------------"
done
exit 0
