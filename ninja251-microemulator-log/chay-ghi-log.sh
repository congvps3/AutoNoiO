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
if [ ! -f 251_Love_Atun_TRACE.jar ]; then
  echo 'Khong tim thay 251_Love_Atun_TRACE.jar.' >&2
  exit 1
fi
echo "Gia lap: $NSO_EMULATOR_JAR"
echo 'Log: dang-ky.log (ghi de neu da ton tai). Chon 251 va Start, dong gia lap de ket thuc.'
printf 'NSO_TRACE_RUNNER emulator=%s\n' "$NSO_EMULATOR_JAR" > dang-ky.log
java -version >> dang-ky.log 2>&1
exec java -Dfile.encoding=UTF-8 -jar "$NSO_EMULATOR_JAR" 251_Love_Atun_TRACE.jar >> dang-ky.log 2>&1
