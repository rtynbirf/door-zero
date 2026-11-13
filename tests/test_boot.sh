#!/usr/bin/env bash
# boot-проверка: пустота на месте. Удаление Двери Zero = kernel panic (ненулевой выход).
if [ ! -f door-zero/void.txt ]; then echo "DOOR_ZERO: missing — boot broken"; exit 1; fi
if [ -s door-zero/void.txt ]; then echo "DOOR_ZERO: void.txt заполнен — boot broken"; exit 1; fi
if [ ! -f door-zero/server.py ]; then echo "DOOR_ZERO: server.py отсутствует — boot broken"; exit 1; fi
echo "DOOR_ZERO: present"
