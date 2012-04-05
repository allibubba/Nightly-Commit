#!/bin/bash
####################################
#
# Nightly project commit
# Recursively loop through directory and commit any project changes
# To enable desktop notifications, not really needed, but they're fucking cool
# $ sudo apt-get install libnotify-bin
# TODO: Add ability to pass in project directory in via cron task
####################################

SCRIPT=`readlink -f $0`
SCRIPTPATH=`dirname $SCRIPT`

PROJECTPATH=$HOME/Projects
PROJECTS=( $(find $PROJECTPATH -maxdepth 1 -type d -printf '%P\n') )

runCommit () {
  git add .
  git commit -m"nightly commit: "$1
  git push
  notify-send $1
}

for proj in ${PROJECTS[@]}
do
  dir = $HOME/Projects/$proj
  cd $HOME/Projects/$proj
  if [ -d $HOME/Projects/$proj/.git ] && [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]
    then
      runCommit $proj
    else
      echo "!! NOPE"
  fi
done

echo "Finished running projectPush at `date`" >> $SCRIPTPATH/task.log


