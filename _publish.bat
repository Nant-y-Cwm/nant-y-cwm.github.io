@echo off
cd /d %0\..

echo Resetting
@call git reset

echo Checkout
@call git checkout .

echo Getting latest code
@call git pull origin

echo Deploying
@call scms --publish --config ../config/ > .\last-deploy.log
@call type .\last-deploy.log

::echo Cleaning up
::git clean -fdx