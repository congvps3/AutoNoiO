@echo off
setlocal
cd /d "%~dp0"
where java >nul 2>&1
if errorlevel 1 (
  echo Khong tim thay Java. Hay cai Java va them vao PATH.
  pause
  exit /b 1
)
set "NSO_EMULATOR_JAR="
if exist "MICRO_NST.jar" set "NSO_EMULATOR_JAR=MICRO_NST.jar"
if not defined NSO_EMULATOR_JAR if exist "microemulator.jar" set "NSO_EMULATOR_JAR=microemulator.jar"
if not defined NSO_EMULATOR_JAR (
  echo Can MICRO_NST.jar hoac microemulator.jar trong thu muc nay.
  echo Giu cac tep phu tro cua gia lap neu ban dang dung co san.
  pause
  exit /b 1
)
if not exist "251_Love_Atun_TRACE.jar" (
  echo Khong tim thay 251_Love_Atun_TRACE.jar trong thu muc nay.
  pause
  exit /b 1
)
echo Gia lap: %NSO_EMULATOR_JAR%
echo Log se duoc luu vao dang-ky.log trong thu muc nay.
echo Neu tep da co, lan chay nay se ghi de tep do.
echo Khi hien Launcher 251, chon 251 va nhan Start.
echo NSO_TRACE_RUNNER emulator=%NSO_EMULATOR_JAR% > "dang-ky.log"
java -version >> "dang-ky.log" 2>&1
java -Dfile.encoding=UTF-8 -jar "%NSO_EMULATOR_JAR%" "251_Love_Atun_TRACE.jar" >> "dang-ky.log" 2>&1
set "NSO_EXIT_CODE=%ERRORLEVEL%"
echo Da ket thuc. Ma thoat Java: %NSO_EXIT_CODE%
echo Hay gui dang-ky.log kem cac buoc dang ky va thong bao ket qua.
echo Doc va che thong tin rieng tu trong log truoc khi gui.
pause
exit /b %NSO_EXIT_CODE%
