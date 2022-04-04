#!/bin/bash

rm ~/bash-repo/bashrc
cp ~/.bashrc ~/bash-repo/bashrc

echo Write commit message:
read commitMSG

git add .
git commit -m "$commitMSG"
git push