@echo off
cd /d %0\..

echo Resetting
@call git reset

echo Checkout
@call git checkout .

echo Getting latest code
@call git pull origin

echo Deploying
scms --publish > .\last-deploy.log
