@echo off
cd /d %0\..
git reset
git checkout .
git pull origin
scms --publish > .\last-deploy.log
