@echo off
cd /d %0\.. 
git pull origin
scms --publish > .\last-deploy.log
::start http://www.nant-y-cwm.co.uk/
::pause