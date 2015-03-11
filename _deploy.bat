@echo off
cd /d %0\..

echo Deploying
@call scms --publish --config ../config/ 
