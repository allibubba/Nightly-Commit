#!/bin/bash
####################################
#
# ForcePush.sh
# run this script to loop through all your project directories, if a project has uncommitted changes you will be prompted for a commit message for each project, project will then commit and push with message.
# TODO: remove all hard coded paths
####################################
echo -e "ForcePush Initiated\n"

SCRIPT=`readlink -f $0`
SCRIPTPATH=`dirname $SCRIPT`

PROJECTPATH=/home/allibubba/Tasks
PROJECTS=( $(find $PROJECTPATH -maxdepth 1 -type d -printf '%P\n') )

runCommit () {
  git add -A
  # not sure why, but could not use $2 here, kept endign string at first space
  git commit -m"$answer"
  git push
  notify-send $1
}




for proj in ${PROJECTS[@]}
do
  DIR=/home/allibubba/Tasks/$proj
  cd /home/allibubba/Tasks/$proj
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