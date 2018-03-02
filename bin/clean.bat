@echo off
rem /**
rem  * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
rem  *
rem  * Author: fanhua@163.com
rem  */
echo.
echo [��Ϣ] ��������·����
echo.
pause
echo.

cd %~dp0
cd..

call mvn clean -X

cd bin
pause