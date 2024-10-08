#!/bin/bash

################
#About: This Script calls the git api with an provided end point and prints the list of repositories
#Input: We need to export 'username' and 'token' and run the script by providing this arguments 'repo owner'.
#Owner: Abhishek Sontakke
#Date : 12 August 2024
#Version: V2

# Calling the Git API url
GIT_API_URL="https://api.github.com"

# I need exporter here
USERNAME=$username
TOKEN=$token

# setting up the arguments
REPO_OWNER=$1


# checking that user correctly passign the args
if [ "$#" -ne 1 ]; then
	echo "Error: Please pass the required $REPO_OWNER"
	exit 1
fi

# Creating a get request using Curl module
# https://api.github.com/orgs/ORG/repos
function github_api_get {
local endpoint="$1"
local url="${GIT_API_URL}/${endpoint}"

#send a get request to the github api with authentication
curl -s -u "${USERNAME}:${TOKEN}" "$url"

}	

# list the user with read access in the repo
function list_repositories {

	local endpoint="orgs/${REPO_OWNER}/repos"

	# fetch the repositories 
        repositories="$(github_api_get "$endpoint")"

#Display the lists of repositories
if [[ -z "$repositories" ]]; then
                 echo " no repositories found for the organisation : $REPO_OWNER"
	 else
	         echo " for the orgnisation $REPO_OWNER below repositories found"
		 echo "$repositories"
fi
}

