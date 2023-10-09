#!/bin/bash

git checkout -b 'newBranch'
# /Users/hassan/sites/bashfiles/updateJSONFile.js 
echo -n "18.13.0" > .nvmrc
sed -i "" "s/Node 14.x/Node 16.x/g" Jenkinsfile
sed -i "" 's/"nodeVersion": "\/>=^[0-9]+.[0-9]+.[0-9]+"/"nodeVersion": "^18.13.0",/g' package.json

cat << EOF > repo/node.repo
[repository]
name=nodesource-18
baseurl=https://rpm.nodesource.com/pub_18.x/el/8/x86_64/
gpgkey=https://rpm.nodesource.com/pub/el/NODESOURCE-GPG-SIGNING-KEY-EL
enabled=1
gpgcheck=1  
EOF
