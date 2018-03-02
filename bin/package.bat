@echo off
rem /**
rem  * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
rem  *
rem  * Author: fanhua@163.com
rem  */
echo.
echo [��Ϣ] ������̣�����war���ļ���
echo.
pause
echo.

cd %~dp0
cd..

call mvn clean package -Dmaven.test.skip=true

cd bin
pause