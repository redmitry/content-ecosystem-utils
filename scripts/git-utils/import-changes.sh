#!/bin/bash
# Please note, all the changes should be done BEFORE this script
# if the importing PR already exists, the $1 argument has to be true
# PR and Commit name should be specified the 2nd argument
set -e
git config --local user.email "tpe-bot@github.com"
git config --local user.name "Tools Platform Ecosystem bot"
git add .

if [ -z "$3" ] ; then
    lbl="$2"
else
    lbl="$3"
fi

echo $1
echo $2
echo $3
echo $lbl

if git commit -m "$2 on $(date)"; then
  if $1; then
    git push
  else
    BRANCH_NAME=$lbl-$(date +%s%N | cut -b10-19)
    echo $BRANCH_NAME
    git checkout -b $BRANCH_NAME
    git push --set-upstream origin $BRANCH_NAME
    hub pull-request -m "$2 on $(date)" -l $lbl
  fi
else
  echo "nothing new to add, exiting"
fi
