OBJDUMP = riscv64-unknown-linux-gnu-objdump

TARGET = add
ROM_DATA_WIDTH = 32

gcc:
	clang add.c ../share/start.S -o $(TARGET).elf \
	-T ../share/link.ld \
	-mabi=lp64 -march=rv64i -static -nostdlib -nostartfiles

dis:
	$(OBJDUMP) $(TARGET).elf -d > $(TARGET).dis

hex:
	python3 $(AMIKUS_HOME)/simulation/tools/elf_util.py $(shell pwd)/$(TARGET).elf $(ROM_DATA_WIDTH)
