#!/usr/bin/env bash
# Удаление Двери Zero должно ломать boot. Если не ломает — система провалила проверку.
set -euo pipefail
mv door-zero/void.txt /tmp/dz_void_backup
if bash tests/test_boot.sh >/dev/null 2>&1; then
  mv /tmp/dz_void_backup door-zero/void.txt
  echo "test_boot_fail: ПРОВАЛ — удаление не сломало boot"
  exit 1
fi
mv /tmp/dz_void_backup door-zero/void.txt
bash tests/test_boot.sh >/dev/null
echo "test_boot_fail: ok — удаление ломает boot"
