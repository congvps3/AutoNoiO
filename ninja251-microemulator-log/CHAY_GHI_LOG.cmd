@echo off
setlocal
cd /d "%~dp0"
where java >nul 2>&1
if errorlevel 1 (
  echo Khong tim thay Java. Hay cai Java va them vao PATH.
  pause
  exit /b 1
)
if not exist microemulator.jar (
  echo Hay chep microemulator.jar va thu muc lib cua MicroEmulator vao day.
  pause
  exit /b 1
)
if not exist 251_Love_Atun_TRACE.jar (
  echo Khong tim thay 251_Love_Atun_TRACE.jar trong thu muc nay.
  pause
  exit /b 1
)
echo Log se duoc luu vao dang-ky.log trong thu muc nay.
echo Neu tep da co, lan chay nay se ghi de tep do.
java -Dfile.encoding=UTF-8 -jar microemulator.jar 251_Love_Atun_TRACE.jar > dang-ky.log 2>&1
set "NSO_EXIT_CODE=%ERRORLEVEL%"
echo Da ket thuc. Ma thoat Java: %NSO_EXIT_CODE%
echo Hay gui dang-ky.log kem cac buoc dang ky va thong bao ket qua.
echo Doc va che thong tin rieng tu trong log truoc khi gui.
pause
exit /b %NSO_EXIT_CODE%
