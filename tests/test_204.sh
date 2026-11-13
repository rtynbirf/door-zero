#!/usr/bin/env bash
# Дверь Zero ничего не отдаёт: 204, пустое тело, без кук и трекинга.
set -euo pipefail
PORT=${PORT_TEST_204:-8901}
python3 door-zero/server.py "$PORT" & SRV=$!
trap 'kill $SRV 2>/dev/null || true' EXIT
for i in $(seq 1 50); do
  if curl -s -o /dev/null "http://127.0.0.1:$PORT/"; then break; fi
  sleep 0.1
done
curl -s -D /tmp/dz_head_204 -o /tmp/dz_body_204 "http://127.0.0.1:$PORT/door-zero"
head -n1 /tmp/dz_head_204 | grep -q "204"
if [ -s /tmp/dz_body_204 ]; then echo "test_204: тело не пустое — провал"; exit 1; fi
if grep -qiE "set-cookie|x-tracking" /tmp/dz_head_204; then
  echo "test_204: найдены кук/трекинг — провал"; exit 1
fi
echo "test_204: ok"
