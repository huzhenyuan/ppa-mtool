@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  mtool-client startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and MTOOL_CLIENT_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="-Xms256m"

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\mtool-client-0.7.2.jar;%APP_HOME%\lib\common-0.7.2.jar;%APP_HOME%\lib\logback-classic-1.2.3.jar;%APP_HOME%\lib\async-http-client-2.10.1.jar;%APP_HOME%\lib\core-0.7.2.10.jar;%APP_HOME%\lib\crypto-0.7.2.10.jar;%APP_HOME%\lib\async-http-client-netty-utils-2.10.1.jar;%APP_HOME%\lib\slf4j-api-1.7.26.jar;%APP_HOME%\lib\janino-3.1.0.jar;%APP_HOME%\lib\commons-io-2.6.jar;%APP_HOME%\lib\commons-lang3-3.7.jar;%APP_HOME%\lib\googleauth-1.2.0.jar;%APP_HOME%\lib\httpclient-4.5.3.jar;%APP_HOME%\lib\commons-codec-1.11.jar;%APP_HOME%\lib\fastjson-1.2.59.jar;%APP_HOME%\lib\jcommander-1.72.jar;%APP_HOME%\lib\logback-core-1.2.3.jar;%APP_HOME%\lib\commons-compiler-3.1.0.jar;%APP_HOME%\lib\abi-0.7.2.10.jar;%APP_HOME%\lib\tuples-0.7.2.10.jar;%APP_HOME%\lib\jnr-unixsocket-0.15.jar;%APP_HOME%\lib\logging-interceptor-3.8.1.jar;%APP_HOME%\lib\okhttp-3.8.1.jar;%APP_HOME%\lib\rxjava-1.2.4.jar;%APP_HOME%\lib\Java-WebSocket-1.3.8.jar;%APP_HOME%\lib\hibernate-validator-6.0.17.Final.jar;%APP_HOME%\lib\javax.el-3.0.1-b09.jar;%APP_HOME%\lib\commons-csv-1.7.jar;%APP_HOME%\lib\netty-handler-proxy-4.1.36.Final.jar;%APP_HOME%\lib\netty-codec-http-4.1.36.Final.jar;%APP_HOME%\lib\netty-reactive-streams-2.0.3.jar;%APP_HOME%\lib\netty-handler-4.1.36.Final.jar;%APP_HOME%\lib\netty-codec-socks-4.1.36.Final.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.36.Final-linux-x86_64.jar;%APP_HOME%\lib\netty-resolver-dns-4.1.36.Final.jar;%APP_HOME%\lib\reactive-streams-1.0.2.jar;%APP_HOME%\lib\javax.activation-1.2.0.jar;%APP_HOME%\lib\httpcore-4.4.6.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\rlp-0.7.2.10.jar;%APP_HOME%\lib\utils-0.7.2.10.jar;%APP_HOME%\lib\jackson-databind-2.8.5.jar;%APP_HOME%\lib\jnr-enxio-0.14.jar;%APP_HOME%\lib\jnr-posix-3.0.33.jar;%APP_HOME%\lib\jnr-ffi-2.1.2.jar;%APP_HOME%\lib\jnr-constants-0.9.6.jar;%APP_HOME%\lib\okio-1.13.0.jar;%APP_HOME%\lib\validation-api-2.0.1.Final.jar;%APP_HOME%\lib\jboss-logging-3.3.2.Final.jar;%APP_HOME%\lib\classmate-1.3.4.jar;%APP_HOME%\lib\netty-codec-dns-4.1.36.Final.jar;%APP_HOME%\lib\netty-codec-4.1.36.Final.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.36.Final.jar;%APP_HOME%\lib\netty-transport-4.1.36.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.36.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.36.Final.jar;%APP_HOME%\lib\netty-common-4.1.36.Final.jar;%APP_HOME%\lib\bcprov-jdk15on-1.54.jar;%APP_HOME%\lib\jackson-annotations-2.8.0.jar;%APP_HOME%\lib\jackson-core-2.8.5.jar;%APP_HOME%\lib\jffi-1.2.14.jar;%APP_HOME%\lib\jffi-1.2.14-native.jar;%APP_HOME%\lib\asm-commons-5.0.3.jar;%APP_HOME%\lib\asm-analysis-5.0.3.jar;%APP_HOME%\lib\asm-util-5.0.3.jar;%APP_HOME%\lib\asm-tree-5.0.3.jar;%APP_HOME%\lib\asm-5.0.3.jar;%APP_HOME%\lib\jnr-x86asm-1.0.2.jar

@rem Execute mtool-client
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %MTOOL_CLIENT_OPTS%  -classpath "%CLASSPATH%" com.platon.mtool.client.MtoolClient %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable MTOOL_CLIENT_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%MTOOL_CLIENT_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
