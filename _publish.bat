@echo off
cd /d %0\.. 

scms --publish
start http://www.nant-y-cwm.co.uk/
pause