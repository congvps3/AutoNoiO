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
if not exist "251_Love_Atun_PC_LOG_v2.jar" (
  echo Khong tim thay 251_Love_Atun_PC_LOG_v2.jar.
  echo Hay giai nen du bo ZIP v2, khong chi thay rieng file CMD.
  pause
  exit /b 1
)
echo Gia lap: %NSO_EMULATOR_JAR%
echo Game phai co ten: 251 PC LOG v2
echo Neu van hien 251 cu, vao File va mo 251_Love_Atun_PC_LOG_v2.jar.
echo Luong game ghi truc tiep vao dang-ky.log; console gia lap o gia-lap-console.log.
echo Moi lan chay se ghi de hai tep log cu.
echo NSO_TRACE_RUNNER build=pc-file-v2 emulator=%NSO_EMULATOR_JAR% > "dang-ky.log"
echo WAITING_FOR_TRACE_STARTED - chon 251 PC LOG v2 va nhan Start. >> "dang-ky.log"
echo NSO_EMULATOR_CONSOLE build=pc-file-v2 > "gia-lap-console.log"
java -version >> "gia-lap-console.log" 2>&1
java -Dfile.encoding=UTF-8 "-Dnso.trace.file=%~dp0dang-ky.log" -jar "%NSO_EMULATOR_JAR%" "251_Love_Atun_PC_LOG_v2.jar" >> "gia-lap-console.log" 2>&1
set "NSO_EXIT_CODE=%ERRORLEVEL%"
findstr /L /C:"TRACE_STARTED build=pc-file-v2" "dang-ky.log" >nul 2>&1
if errorlevel 1 (
  echo CHUA XAC NHAN duoc ban game co log da Start.
  echo Lan sau vao File va mo dung 251_Love_Atun_PC_LOG_v2.jar.
) else (
  echo DA NHAN TRACE_STARTED: ban game co log da khoi dong.
)
echo Ma thoat Java: %NSO_EXIT_CODE%
echo Hay gui dang-ky.log va gia-lap-console.log kem thong bao ket qua.
echo Doc va che thong tin rieng tu truoc khi gui.
pause
exit /b %NSO_EXIT_CODE%
