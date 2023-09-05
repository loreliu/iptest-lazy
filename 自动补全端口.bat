@echo off

REM 获取当前目录路径
set "current_directory=%~dp0"

REM 遍历当前目录下的所有txt文件
for %%f in ("%current_directory%\*.txt") do (
    REM 获取文件名和端口号
    set "file_name=%%~nf"
    setlocal enabledelayedexpansion
    for /F "tokens=3 delims=-" %%p in ("!file_name!") do (
        set "port=%%p"

        REM 读取文件内容并逐行添加端口号
        (
            for /F "usebackq delims=" %%l in ("%%~f") do (
                echo %%l !port!
            )
        ) > "ip.txt"

        REM 删除原文件
        del "%%~f"

        echo 文件 "%%~nxf" 添加端口完成，并已删除原文件。
        endlocal
    )
)

echo 完成！
exit /b
