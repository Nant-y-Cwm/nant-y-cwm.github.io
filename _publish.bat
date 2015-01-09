@echo off
cd /d %0\..

echo Resetting
@call git reset

echo Checkout
@call git checkout .

echo Getting latest code
@call git pull origin

echo Deploying
@call scms --publish > .\last-deploy.log
type .\last-deploy.log

cheo Cleaning up
git clean -fdx