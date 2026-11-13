#!/usr/bin/env bash
# Пустота не принимает: POST/PUT/PATCH/DELETE -> 403 Void, тело пустое.
set -euo pipefail
PORT=${PORT_TEST_403:-8902}
python3 door-zero/server.py "$PORT" & SRV=$!
trap 'kill $SRV 2>/dev/null || true' EXIT
for i in $(seq 1 50); do
  if curl -s -o /dev/null "http://127.0.0.1:$PORT/"; then break; fi
  sleep 0.1
done
for M in POST PUT PATCH DELETE; do
  C=$(curl -s -o /tmp/dz_body_403 -w "%{http_code}" -X "$M" "http://127.0.0.1:$PORT/door-zero")
  if [ "$C" != "403" ]; then echo "test_403: $M -> $C, ожидался 403"; exit 1; fi
  if [ -s /tmp/dz_body_403 ]; then echo "test_403: $M вернул тело — пустота потревожена"; exit 1; fi
done
echo "test_403: ok"
