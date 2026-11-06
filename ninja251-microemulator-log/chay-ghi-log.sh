#!/bin/sh
set -eu
cd "$(dirname "$0")"
if ! command -v java >/dev/null 2>&1; then
  echo 'Khong tim thay Java trong PATH.' >&2
  exit 1
fi
if [ -f MICRO_NST.jar ]; then
  NSO_EMULATOR_JAR=MICRO_NST.jar
elif [ -f microemulator.jar ]; then
  NSO_EMULATOR_JAR=microemulator.jar
else
  echo 'Can MICRO_NST.jar hoac microemulator.jar trong thu muc nay.' >&2
  exit 1
fi
if [ ! -f 251_Love_Atun_PC_LOG_v3.jar ]; then
  echo 'Can 251_Love_Atun_PC_LOG_v3.jar. Hay giai nen du bo ZIP v3.' >&2
  exit 1
fi
if [ ! -f NST_TRACE_CHECK.jar ]; then
  echo 'Can NST_TRACE_CHECK.jar. Hay giai nen du bo ZIP danh cho MICRO_NST.' >&2
  exit 1
fi
NSO_TRACE_PATH="$(pwd)/dang-ky.log"
echo "Gia lap: $NSO_EMULATOR_JAR"
echo 'Vao File mo 251_Love_Atun_PC_LOG_v3.jar, chon 251 PC LOG v3 va Start mot lan.'
echo 'Hai tep dang-ky.log va gia-lap-console.log se bi ghi de.'
printf 'NSO_TRACE_RUNNER build=pc-file-v3 emulator=%s\nWAITING_FOR_UI_READY\n' "$NSO_EMULATOR_JAR" > "$NSO_TRACE_PATH"
printf 'NSO_EMULATOR_CONSOLE build=pc-file-v3\n' > gia-lap-console.log
java -version >> gia-lap-console.log 2>&1
echo 'Dang kiem tra bo nap va quyen ghi tep, chua khoi dong game...'
if ! java -jar NST_TRACE_CHECK.jar "$NSO_EMULATOR_JAR" 251_Love_Atun_PC_LOG_v3.jar "$NSO_TRACE_PATH" >> gia-lap-console.log 2>&1; then
  echo 'KIEM TRA CHUA DAT. Gui dang-ky.log va gia-lap-console.log; chua can dang ky thu.'
  exit 1
fi
echo 'KIEM TRA DA DAT: bo nap va quyen ghi tep hoat dong.'
set +e
java -Dfile.encoding=UTF-8 "-Dnso.trace.file=$NSO_TRACE_PATH" -jar "$NSO_EMULATOR_JAR" >> gia-lap-console.log 2>&1
NSO_EXIT_CODE=$?
set -e
if grep -Fq 'TRACE_UI_READY build=pc-file-v3' "$NSO_TRACE_PATH"; then
  echo 'DA NHAN TRACE_UI_READY: man hinh game da ve xong.'
else
  echo 'CHUA XAC NHAN ban game co log. Vao File va mo dung JAR v3.'
fi
exit "$NSO_EXIT_CODE"
