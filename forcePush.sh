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
  DIR=$PROJECTPATH/$proj
  cd $PROJECTPATH/$proj
  
  VN=$(git describe --abbrev=7 HEAD 2>/dev/null)  

  git update-index -q --refresh  
  CHANGED=$(git diff-index --name-only HEAD --)  
  if [ ! -z "$CHANGED" ];  
    #then VN="$VN-mod"   
    then
      echo "changes found: $proj"
      answer=$(zenity --entry --title="Commit Message" --text="Enter a commit message for $proj")
      runCommit $proj $answer      
    else      
      echo "NO changes found"
  fi

#  if [ -d $PROJECTPATH/$proj/.git ] && [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]
#    then
#      # echo "enter your commit message for project: "$proj
#      # read answer
#      answer=$(zenity --entry --title="Commit Message" --text="Enter a commit message for $proj")
#      runCommit $proj $answer
#    else
#      echo "!! NOPE "$DIR
#  fi
done

echo "Finished running projectPush at `date`" > $SCRIPTPATH/task.log