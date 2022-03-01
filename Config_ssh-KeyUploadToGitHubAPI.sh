#!/bin/bash      
#author		    : Simon Legah
#CopyRights     : Landmark Technologies
#Contact        : +1 437 215 2483
#Modified by	: Rodriequez Nwosu

<<mc
This script will create and upload ssh-keys to githubAPI.
It automates the ssh-keygen process for github. Shell scripting is good for automation.
Please make sure you create a token and set public key write permission before executing this script.
Watch the youtube video for clarity: https://www.youtube.com/watch?v=3YgutlExHRo&t=3632s
mc

echo "Enter your GitHub Personal Access Token:"
read -s v_token
echo "Enter a name for the keypair:"
read v_keypair

echo "Checking/setting up ssh config. file."
mkdir "$HOME/.ssh" > "$HOME/_tmpfile" 2>&1
chmod 700 "$HOME/.ssh"
touch "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"
v_gitsetup=`grep -A 5 -i github.com $HOME/.ssh/config | grep -o $v_keypair`
if [ ! $v_gitsetup ]; then
	echo -e "Host github.com\n\tIdentityFile ~/.ssh/key_cicd\n\tIdentitiesOnly yes" >> "$HOME/.ssh/config"
fi

keypath="$HOME/.ssh/$v_keypair"

f_AddKeytoGitHub () {
	sshkey=`cat "$keypath.pub"`
	echo "Copying the key to GitHub account."
	curl -X POST -H "Authorization: token $v_token" -H "Accept: application/vnd.github.v3+json" -d "{\"title\":\"$v_keypair\",\"key\":\"$sshkey\"}" https://api.github.com/user/keys > "$HOME/_tmpfile" 2>&1
	v_success=`grep -o verified $HOME/_tmpfile`
	if [ $v_success ]; then
		echo -n "Successfully copied the key to GitHub."
	else
		echo -n "Failure adding key to GitHub."
	fi
}

if [ ! -f "$keypath" -a ! -f "$keypath.pub" ]; then
	echo "Creating the ssh keypair. The keypair will be saved in $HOME/.ssh/"
	ssh-keygen -t rsa -N "" -f "$keypath" > "$HOME/_tmpfile" 2>&1
	if [ $? -eq 0 ]; then
		echo "Keypair successfully generated."
		chmod 400 "$keypath"
		f_AddKeytoGitHub
	else
		echo -n "Failure generating the keypair."
	fi
	# rm "$HOME/_tmpfile"
elif [ -f "$keypath" -a -f "$keypath.pub" ]; then
	echo "Key already exists."
	f_AddKeytoGitHub
	# rm "$HOME/_tmpfile"
else
	echo -n "One key exists in $HOME/.ssh/. Delete the key and re-run script to generate a new keypair."
fi
