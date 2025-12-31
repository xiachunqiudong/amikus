TOP = tb

BUILD_DIR = ./build

export AMIKUS_HOME=$(shell pwd)/../..

CASE_PATH ?= $(AMIKUS_HOME)/simulation/case/add
CASE_NAME ?= add

FILELIST += -file /home/host/project/amikus/core/filelist.f

build:
	mkdir -p $(BUILD_DIR) && \
	cd $(abspath $(BUILD_DIR)) && \
	vcs -assert svaext -full64 -timescale=1ns/1ns +lint=TFIPC-L -debug_acc+all -debug_access -sverilog \
	-kdb -lca -DVCS \
	+vcs+loopreport+10000 \
	$(FILELIST) \
	-top $(TOP) -l build.log

sim:
	$(BUILD_DIR)/simv +ram_init_path=$(CASE_PATH)/$(CASE_NAME).hex \
	+fsdb_path=$(CASE_PATH)/$(CASE_NAME).fsdb

vd:
	verdi -elab $(BUILD_DIR)/simv.daidir/kdb \
	-ssf $(CASE_PATH)/$(CASE_NAME).fsdb &

.PHONY: build vd
