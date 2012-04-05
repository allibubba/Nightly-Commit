# Nightly Commit
Recursively loop through directory and commit any project changes.

## Install
To set this script up, unpack Nightly-Commit to your home directory (or wherever, just remember the path).

projectPush.sh assumes your project directories are located in /home/<username>/Projects, or ~/Projects

If you are using a custom location, modify projectPush.sh, line #18:

    PROJECTPATH=$HOME/Projects
    
Change to point to your "Project" directory.

## Test
    $ bash projectPush.sh

## Cron
You will need to update the HOME and SSH_AUTH_SOCK variables:

    $ echo $HOME
    $ echo $SSH_AUTH_SOCK

Edit your cron file with the command:

    crontab -e

Your crontab should be similar to the following:

    HOME=/home/allibubba
    SSH_AUTH_SOCK=/tmp/keyring-RjESx0/ssh

    # m   h   dom  mon dow   command
      *   19  *    *   *     ~/Nightly-Commit/projectPush.sh > ~/Nightly-Commit/task.log 2>&1

This runs at 7:00 every night, adjust accordingly.