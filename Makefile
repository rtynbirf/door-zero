check: check_door_zero

check_door_zero:
	bash tests/test_boot.sh

test: check_door_zero
	bash tests/test_204.sh
	bash tests/test_403.sh
	bash tests/test_boot_fail.sh
	@echo "все проверки зелёные: пустота на месте"

serve:
	python3 door-zero/server.py $${PORT:-8907}

.PHONY: check check_door_zero test serve
