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
if [ ! -f 251_Love_Atun_AUTO_NEW_v4.jar ] || [ ! -f NSO_AUTO_CHECK.jar ]; then
  echo 'Hay giai nen du bo ZIP auto v4, gom JAR game va NSO_AUTO_CHECK.jar.' >&2
  exit 1
fi
NSO_TRACE_PATH="$(pwd)/dang-ky.log"
printf 'NSO_AUTO_RUNNER build=auto-new-v4 emulator=%s\n' "$NSO_EMULATOR_JAR" > "$NSO_TRACE_PATH"
printf 'NSO_AUTO_CONSOLE build=auto-new-v4\n' > gia-lap-console.log
java -version >> gia-lap-console.log 2>&1
echo 'Dang kiem tra bo nap va quyen ghi tep...'
if ! java -jar NSO_AUTO_CHECK.jar "$NSO_EMULATOR_JAR" 251_Love_Atun_AUTO_NEW_v4.jar "$NSO_TRACE_PATH" >> gia-lap-console.log 2>&1; then
  echo 'KIEM TRA CHUA DAT. Xem gia-lap-console.log.' >&2
  exit 1
fi
echo 'Vao File mo 251_Love_Atun_AUTO_NEW_v4.jar, chon 251 AUTO NEW v4 va Start mot lan.'
echo 'Chon may chu; o man hinh Choi moi, dien cua so Auto va bam Bat dau 1 luot.'
echo 'Den buoc ma xac thuc, tu nhap trong GAME va bam Dong y.'
set +e
java -Dfile.encoding=UTF-8 "-Dnso.trace.file=$NSO_TRACE_PATH" -jar "$NSO_EMULATOR_JAR" >> gia-lap-console.log 2>&1
NSO_EXIT_CODE=$?
set -e
echo 'Hai tep log nam trong thu muc nay: dang-ky.log va gia-lap-console.log.'
exit "$NSO_EXIT_CODE"
