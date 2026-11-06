#!/bin/sh
set -eu
cd "$(dirname "$0")"
if ! command -v java >/dev/null 2>&1; then
  echo 'Khong tim thay Java trong PATH.' >&2
  exit 1
fi
if [ ! -f microemulator.jar ] || [ ! -f 251_Love_Atun_TRACE.jar ]; then
  echo 'Can microemulator.jar, thu muc lib cua gia lap va 251_Love_Atun_TRACE.jar o cung day.' >&2
  exit 1
fi
echo 'Log: dang-ky.log (ghi de neu da ton tai). Dong gia lap de ket thuc.'
exec java -Dfile.encoding=UTF-8 -jar microemulator.jar 251_Love_Atun_TRACE.jar > dang-ky.log 2>&1
