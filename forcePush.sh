#!/bin/bash
####################################
#
# Nightly project commit
# Recursively loop through directory and commit any project changes
# To enable desktop notifications, not really needed, but they're fucking cool
# $ sudo apt-get install libnotify-bin
# TODO: Add ability to pass in project directory in via cron task
####################################
echo -e "ForcePush Initiated\n"

SCRIPT=`readlink -f $0`
SCRIPTPATH=`dirname $SCRIPT`

#PROJECTPATH=/home/allibubba/Projects
PROJECTPATH=/home/allibubba/Tasks
PROJECTS=( $(find $PROJECTPATH -maxdepth 1 -type d -printf '%P\n') )

runCommit () {
  git add -A
  git commit -m echo "$2"
  echo "2"
  echo $answer
  echo "2"  
  git push
  notify-send $1
}




for proj in ${PROJECTS[@]}
do
  #DIR=/home/allibubba/Projects/$proj
  DIR=/home/allibubba/Tasks/$proj
  #cd /home/allibubba/Projects/$proj
  cd /home/allibubba/Tasks/$proj
  #if [ -d /home/allibubba/Projects/$proj/.git ] && [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]
  if [ -d /home/allibubba/Tasks/$proj/.git ] && [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]
    then
      echo "enter your commit message for project: "$proj
      read answer
      runCommit $proj $answer
    else
      echo "!! NOPE "$DIR
  fi
done

echo "Finished running projectPush at `date`" > $SCRIPTPATH/task.log