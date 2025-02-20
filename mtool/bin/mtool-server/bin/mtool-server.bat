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
@rem  mtool-server startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and MTOOL_SERVER_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS="-Xms512m"

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

set CLASSPATH=%APP_HOME%\lib\mtool-server-0.7.2.jar;%APP_HOME%\lib\common-0.7.2.jar;%APP_HOME%\lib\pagehelper-spring-boot-starter-1.2.10.jar;%APP_HOME%\lib\mybatis-spring-boot-starter-2.0.0.jar;%APP_HOME%\lib\mapper-spring-boot-starter-2.1.5.jar;%APP_HOME%\lib\spring-boot-starter-web-2.1.4.RELEASE.jar;%APP_HOME%\lib\spring-boot-starter-webflux-2.1.4.RELEASE.jar;%APP_HOME%\lib\spring-boot-starter-jdbc-2.1.4.RELEASE.jar;%APP_HOME%\lib\spring-boot-starter-json-2.1.4.RELEASE.jar;%APP_HOME%\lib\spring-boot-starter-2.1.4.RELEASE.jar;%APP_HOME%\lib\spring-boot-starter-logging-2.1.4.RELEASE.jar;%APP_HOME%\lib\logback-classic-1.2.3.jar;%APP_HOME%\lib\druid-spring-boot-starter-1.1.20.jar;%APP_HOME%\lib\core-0.7.2.10.jar;%APP_HOME%\lib\crypto-0.7.2.10.jar;%APP_HOME%\lib\nio-multipart-parser-1.1.0.jar;%APP_HOME%\lib\log4j-to-slf4j-2.11.2.jar;%APP_HOME%\lib\jul-to-slf4j-1.7.26.jar;%APP_HOME%\lib\HikariCP-3.2.0.jar;%APP_HOME%\lib\nio-stream-storage-1.1.3.jar;%APP_HOME%\lib\slf4j-api-1.7.25.jar;%APP_HOME%\lib\janino-3.1.0.jar;%APP_HOME%\lib\commons-io-2.6.jar;%APP_HOME%\lib\commons-lang3-3.7.jar;%APP_HOME%\lib\googleauth-1.2.0.jar;%APP_HOME%\lib\httpclient-4.5.8.jar;%APP_HOME%\lib\commons-codec-1.11.jar;%APP_HOME%\lib\fastjson-1.2.59.jar;%APP_HOME%\lib\mapper-4.1.5.jar;%APP_HOME%\lib\pagehelper-5.1.8.jar;%APP_HOME%\lib\mybatis-3.5.0.jar;%APP_HOME%\lib\mybatis-generator-core-1.3.7.jar;%APP_HOME%\lib\mysql-connector-java-8.0.17.jar;%APP_HOME%\lib\javax.mail-1.6.2.jar;%APP_HOME%\lib\freemarker-2.3.28.jar;%APP_HOME%\lib\commons-beanutils-1.9.3.jar;%APP_HOME%\lib\cglib-nodep-3.2.12.jar;%APP_HOME%\lib\guava-28.0-jre.jar;%APP_HOME%\lib\logback-core-1.2.3.jar;%APP_HOME%\lib\commons-compiler-3.1.0.jar;%APP_HOME%\lib\abi-0.7.2.10.jar;%APP_HOME%\lib\tuples-0.7.2.10.jar;%APP_HOME%\lib\jnr-unixsocket-0.15.jar;%APP_HOME%\lib\logging-interceptor-3.8.1.jar;%APP_HOME%\lib\okhttp-3.8.1.jar;%APP_HOME%\lib\rxjava-1.3.8.jar;%APP_HOME%\lib\Java-WebSocket-1.3.8.jar;%APP_HOME%\lib\mapper-core-1.1.5.jar;%APP_HOME%\lib\mapper-base-1.1.5.jar;%APP_HOME%\lib\persistence-api-1.0.jar;%APP_HOME%\lib\jsqlparser-1.2.jar;%APP_HOME%\lib\mybatis-spring-boot-autoconfigure-2.0.0.jar;%APP_HOME%\lib\mybatis-spring-2.0.0.jar;%APP_HOME%\lib\mapper-weekend-1.1.5.jar;%APP_HOME%\lib\mapper-spring-1.1.5.jar;%APP_HOME%\lib\mapper-extra-1.1.5.jar;%APP_HOME%\lib\mapper-spring-boot-autoconfigure-2.1.5.jar;%APP_HOME%\lib\junit-4.12.jar;%APP_HOME%\lib\hsqldb-2.4.1.jar;%APP_HOME%\lib\pagehelper-spring-boot-autoconfigure-1.2.10.jar;%APP_HOME%\lib\druid-1.1.20.jar;%APP_HOME%\lib\spring-boot-autoconfigure-2.1.4.RELEASE.jar;%APP_HOME%\lib\activation-1.1.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\commons-collections-3.2.2.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\checker-qual-2.8.1.jar;%APP_HOME%\lib\error_prone_annotations-2.3.2.jar;%APP_HOME%\lib\j2objc-annotations-1.3.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.17.jar;%APP_HOME%\lib\hibernate-validator-6.0.16.Final.jar;%APP_HOME%\lib\javax.el-3.0.0.jar;%APP_HOME%\lib\commons-csv-1.7.jar;%APP_HOME%\lib\spring-boot-starter-tomcat-2.1.4.RELEASE.jar;%APP_HOME%\lib\spring-webmvc-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-webflux-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-web-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-boot-starter-reactor-netty-2.1.4.RELEASE.jar;%APP_HOME%\lib\httpcore-4.4.11.jar;%APP_HOME%\lib\rlp-0.7.2.10.jar;%APP_HOME%\lib\utils-0.7.2.10.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.9.8.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.9.8.jar;%APP_HOME%\lib\jackson-module-parameter-names-2.9.8.jar;%APP_HOME%\lib\jackson-databind-2.9.8.jar;%APP_HOME%\lib\jnr-enxio-0.14.jar;%APP_HOME%\lib\jnr-posix-3.0.33.jar;%APP_HOME%\lib\jnr-ffi-2.1.2.jar;%APP_HOME%\lib\jnr-constants-0.9.6.jar;%APP_HOME%\lib\okio-1.13.0.jar;%APP_HOME%\lib\spring-boot-2.1.4.RELEASE.jar;%APP_HOME%\lib\javax.annotation-api-1.3.2.jar;%APP_HOME%\lib\spring-jdbc-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-context-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-aop-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-tx-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-beans-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-expression-5.1.6.RELEASE.jar;%APP_HOME%\lib\spring-core-5.1.6.RELEASE.jar;%APP_HOME%\lib\snakeyaml-1.23.jar;%APP_HOME%\lib\hamcrest-core-1.3.jar;%APP_HOME%\lib\validation-api-2.0.1.Final.jar;%APP_HOME%\lib\jboss-logging-3.3.2.Final.jar;%APP_HOME%\lib\classmate-1.4.0.jar;%APP_HOME%\lib\tomcat-embed-websocket-9.0.17.jar;%APP_HOME%\lib\tomcat-embed-core-9.0.17.jar;%APP_HOME%\lib\tomcat-embed-el-9.0.17.jar;%APP_HOME%\lib\reactor-netty-0.8.6.RELEASE.jar;%APP_HOME%\lib\reactor-core-3.2.8.RELEASE.jar;%APP_HOME%\lib\log4j-api-2.11.2.jar;%APP_HOME%\lib\bcprov-jdk15on-1.54.jar;%APP_HOME%\lib\jackson-annotations-2.9.0.jar;%APP_HOME%\lib\jackson-core-2.9.8.jar;%APP_HOME%\lib\jffi-1.2.14.jar;%APP_HOME%\lib\jffi-1.2.14-native.jar;%APP_HOME%\lib\asm-commons-5.0.3.jar;%APP_HOME%\lib\asm-analysis-5.0.3.jar;%APP_HOME%\lib\asm-util-5.0.3.jar;%APP_HOME%\lib\asm-tree-5.0.3.jar;%APP_HOME%\lib\asm-5.0.3.jar;%APP_HOME%\lib\jnr-x86asm-1.0.2.jar;%APP_HOME%\lib\spring-jcl-5.1.6.RELEASE.jar;%APP_HOME%\lib\netty-codec-http2-4.1.34.Final.jar;%APP_HOME%\lib\netty-handler-proxy-4.1.34.Final.jar;%APP_HOME%\lib\netty-codec-http-4.1.34.Final.jar;%APP_HOME%\lib\netty-handler-4.1.34.Final.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.34.Final-linux-x86_64.jar;%APP_HOME%\lib\reactive-streams-1.0.2.jar;%APP_HOME%\lib\netty-codec-socks-4.1.34.Final.jar;%APP_HOME%\lib\netty-codec-4.1.34.Final.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.34.Final.jar;%APP_HOME%\lib\netty-transport-4.1.34.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.34.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.34.Final.jar;%APP_HOME%\lib\netty-common-4.1.34.Final.jar

@rem Execute mtool-server
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %MTOOL_SERVER_OPTS%  -classpath "%CLASSPATH%" com.platon.mtool.server.Application %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable MTOOL_SERVER_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%MTOOL_SERVER_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
