# Nightly Commit
Recursively loop through directory and commit any project changes
to set this script up, unpack Nightly-Commit to your home directory (or wherever, just remember the path)
projectPush.sh assumes your project directories are located in /home/<username>/Projects, or ~/Projects
if you are using a custom location, modify projectPush.sh, line #18
    PROJECTPATH=$HOME/Projects
change to point to your project's directory    
## Test
    $ bash projectPush.sh
## Cron
you will need to update the HOME and SSH_AUTH_SOCK variables, to get these, in a console, capture the output of the following commands
    $ echo $HOME
    $ echo $SSH_AUTH_SOCK

edit your cron file with the command
    crontab -e

your crontab should be similar to the following
    HOME=/home/allibubba
    SSH_AUTH_SOCK=/tmp/keyring-RjESx0/ssh

    # m   h   dom  mon dow   command
      *   19  *    *   *     ~/Nightly-Commit/projectPush.sh > ~/Nightly-Commit/task.log 2>&1

this runs at 7:00 every night, adjust accordingly