#!/bin/bash

rm ~/.my-bashrc/bashrc
cp ~/.bashrc ~/.my-bashrc/bashrc

echo Write commit message:
read commitMSG

git add .
git commit -m "$commitMSG"
git push