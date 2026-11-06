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
if [ ! -f 251_Love_Atun_PC_LOG_v2.jar ]; then
  echo 'Can 251_Love_Atun_PC_LOG_v2.jar. Hay giai nen du bo ZIP v2.' >&2
  exit 1
fi
NSO_TRACE_PATH="$(pwd)/dang-ky.log"
echo "Gia lap: $NSO_EMULATOR_JAR"
echo 'Game phai co ten 251 PC LOG v2; neu khong, vao File va mo dung JAR v2.'
echo 'Hai tep dang-ky.log va gia-lap-console.log se bi ghi de.'
printf 'NSO_TRACE_RUNNER build=pc-file-v2 emulator=%s\nWAITING_FOR_TRACE_STARTED\n' "$NSO_EMULATOR_JAR" > "$NSO_TRACE_PATH"
printf 'NSO_EMULATOR_CONSOLE build=pc-file-v2\n' > gia-lap-console.log
java -version >> gia-lap-console.log 2>&1
set +e
java -Dfile.encoding=UTF-8 "-Dnso.trace.file=$NSO_TRACE_PATH" -jar "$NSO_EMULATOR_JAR" 251_Love_Atun_PC_LOG_v2.jar >> gia-lap-console.log 2>&1
NSO_EXIT_CODE=$?
set -e
if grep -Fq 'TRACE_STARTED build=pc-file-v2' "$NSO_TRACE_PATH"; then
  echo 'DA NHAN TRACE_STARTED: ban game co log da khoi dong.'
else
  echo 'CHUA XAC NHAN ban game co log. Vao File va mo dung JAR v2.'
fi
exit "$NSO_EXIT_CODE"
