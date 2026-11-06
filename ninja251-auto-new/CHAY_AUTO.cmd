@echo off
setlocal
cd /d "%~dp0"
where java >nul 2>&1
if errorlevel 1 (
  echo Khong tim thay Java trong PATH.
  pause
  exit /b 1
)
set "NSO_EMULATOR_JAR="
if exist "MICRO_NST.jar" set "NSO_EMULATOR_JAR=MICRO_NST.jar"
if not defined NSO_EMULATOR_JAR if exist "microemulator.jar" set "NSO_EMULATOR_JAR=microemulator.jar"
if not defined NSO_EMULATOR_JAR (
  echo Can MICRO_NST.jar hoac microemulator.jar trong thu muc nay.
  pause
  exit /b 1
)
if not exist "251_Love_Atun_AUTO_NEW_v2.jar" (
  echo Can 251_Love_Atun_AUTO_NEW_v2.jar. Hay giai nen du bo ZIP auto v2.
  pause
  exit /b 1
)
if not exist "NSO_AUTO_CHECK.jar" (
  echo Can NSO_AUTO_CHECK.jar. Hay giai nen du bo ZIP auto v2.
  pause
  exit /b 1
)
echo NSO_AUTO_RUNNER build=auto-new-v2 emulator=%NSO_EMULATOR_JAR% > "dang-ky.log"
echo NSO_AUTO_CONSOLE build=auto-new-v2 > "gia-lap-console.log"
java -version >> "gia-lap-console.log" 2>&1
echo Dang kiem tra bo nap va quyen ghi tep...
java -jar "NSO_AUTO_CHECK.jar" "%NSO_EMULATOR_JAR%" "251_Love_Atun_AUTO_NEW_v2.jar" "%~dp0dang-ky.log" >> "gia-lap-console.log" 2>&1
if errorlevel 1 (
  echo KIEM TRA CHUA DAT. Xem gia-lap-console.log.
  pause
  exit /b 1
)
echo Vao File mo 251_Love_Atun_AUTO_NEW_v2.jar.
echo Chon 251 AUTO NEW v2 va nhan Start mot lan.
echo Chon may chu; o man hinh Choi moi, dien cua so Auto va bam Bat dau 1 luot.
echo Den buoc ma xac thuc, tu nhap trong GAME va bam Dong y.
java -Dfile.encoding=UTF-8 "-Dnso.trace.file=%~dp0dang-ky.log" -jar "%NSO_EMULATOR_JAR%" >> "gia-lap-console.log" 2>&1
set "NSO_EXIT_CODE=%ERRORLEVEL%"
echo Ma thoat Java: %NSO_EXIT_CODE%
echo Hai tep log nam trong thu muc nay: dang-ky.log va gia-lap-console.log.
pause
exit /b %NSO_EXIT_CODE%
