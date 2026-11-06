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
if not exist "251_Love_Atun_PC_LOG_v3.jar" (
  echo Khong tim thay 251_Love_Atun_PC_LOG_v3.jar.
  echo Hay giai nen du bo ZIP v3, khong chi thay rieng file CMD.
  pause
  exit /b 1
)
if not exist "NST_TRACE_CHECK.jar" (
  echo Can NST_TRACE_CHECK.jar. Hay giai nen du bo ZIP danh cho MICRO_NST.
  pause
  exit /b 1
)
echo Gia lap: %NSO_EMULATOR_JAR%
echo Trong gia lap, vao File va mo 251_Love_Atun_PC_LOG_v3.jar.
echo Sau do chon 251 PC LOG v3 va nhan Start mot lan.
echo Neu van hien 251 cu, vao File va mo 251_Love_Atun_PC_LOG_v3.jar.
echo Luong game ghi truc tiep vao dang-ky.log; console gia lap o gia-lap-console.log.
echo Moi lan chay se ghi de hai tep log cu.
echo NSO_TRACE_RUNNER build=pc-file-v3 emulator=%NSO_EMULATOR_JAR% > "dang-ky.log"
echo WAITING_FOR_UI_READY - chon 251 PC LOG v3 va nhan Start. >> "dang-ky.log"
echo NSO_EMULATOR_CONSOLE build=pc-file-v3 > "gia-lap-console.log"
java -version >> "gia-lap-console.log" 2>&1
echo Dang kiem tra bo nap va quyen ghi tep, chua khoi dong game...
java -jar "NST_TRACE_CHECK.jar" "%NSO_EMULATOR_JAR%" "251_Love_Atun_PC_LOG_v3.jar" "%~dp0dang-ky.log" >> "gia-lap-console.log" 2>&1
if errorlevel 1 (
  echo KIEM TRA CHUA DAT. Mo gia-lap-console.log de xem ly do.
  echo Gui ca hai tep log de kiem tra, chua can dang ky thu.
  pause
  exit /b 1
)
echo KIEM TRA DA DAT: gia lap nap duoc game va ghi duoc tep.
java -Dfile.encoding=UTF-8 "-Dnso.trace.file=%~dp0dang-ky.log" -jar "%NSO_EMULATOR_JAR%" >> "gia-lap-console.log" 2>&1
set "NSO_EXIT_CODE=%ERRORLEVEL%"
findstr /L /C:"TRACE_UI_READY build=pc-file-v3" "dang-ky.log" >nul 2>&1
if errorlevel 1 (
  echo CHUA XAC NHAN man hinh game da ve xong.
  echo Lan sau vao File va mo dung 251_Love_Atun_PC_LOG_v3.jar.
) else (
  echo DA NHAN TRACE_UI_READY: man hinh game da ve xong.
)
echo Ma thoat Java: %NSO_EXIT_CODE%
echo Hay gui dang-ky.log va gia-lap-console.log kem thong bao ket qua.
echo Doc va che thong tin rieng tu truoc khi gui.
pause
exit /b %NSO_EXIT_CODE%
