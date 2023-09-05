@echo off
setlocal

set /p speedtest_count=请输入下载测速协程数量 (默认为 5):
set /p test_option=请选择测试选项 (1 - 测TLS, 2 - 测非TLS, 3 - 同时测两者, 默认为 1):

rem 设置默认值
if "%speedtest_count%"=="" set "speedtest_count=5"
if "%test_option%"=="" set "test_option=1"

set "speedtest_url=speed.bestip.one/__down?bytes=50000000"
set "tcptest_url=www.bing.com" 

if "%test_option%"=="1" (
    set "test_tls=true"
    set "test_non_tls=false"
) else if "%test_option%"=="2" (
    set "test_tls=false"
    set "test_non_tls=true"
) else if "%test_option%"=="3" (
    set "test_tls=true"
    set "test_non_tls=true"
) else (
    echo 无效的选项
    goto :error
)

:: 定义测试命令
if "%test_tls%"=="true" (
    set "tls_command=iptest.exe -speedtest=%speedtest_count% -tls=true  -url=%speedtest_url% -outfile=temp_tls_result.csv -tcpurl=%tcptest_url%"
)

if "%test_non_tls%"=="true" (
    set "non_tls_command=iptest.exe -speedtest=%speedtest_count% -tls=false  -url=%speedtest_url% -outfile=temp_non_tls_result.csv -tcpurl=%tcptest_url%"
)

:: 执行测试命令
if "%test_tls%"=="true" (
    call :RunTest "TLS" "%tls_command%"
)

if "%test_non_tls%"=="true" (
    call :RunTest "Non-TLS" "%non_tls_command%"
)

:: 合并结果（这里保持不变）
set "merge_command=type temp_tls_result.csv > merged_result.csv"
if "%test_non_tls%"=="true" (
    if exist temp_non_tls_result.csv (
        set "merge_command=%merge_command% & (for /f "usebackq skip=1 tokens=* delims=" %%a in (temp_non_tls_result.csv) do echo %%a) >> merged_result.csv"
    )
)
call %merge_command%

rem 删除临时文件（这里保持不变）
if "%test_non_tls%"=="true" (
    if exist temp_non_tls_result.csv (
        del temp_non_tls_result.csv
    )
)

if "%test_tls%"=="true" (
    del temp_tls_result.csv
)

endlocal
goto :eof

:: 子过程用于执行测试命令
:RunTest
setlocal
echo 正在执行 %~1 测试: %~2
%~2 2>nul || (
    echo %~1 测试时出现错误，请查看错误信息。
    goto :error
)
endlocal
goto :eof

:error
echo 脚本运行出现错误，请查看错误信息。
pause


