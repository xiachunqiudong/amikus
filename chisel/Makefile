RTL_DIR = $(shell pwd)/rtl_code

verilog:
	mkdir -p $(RTL_DIR)
	mill amikus.runMain Elaborate --target-dir $(RTL_DIR)
	rm -rf $(RTL_DIR)/verification
	find $(RTL_DIR)  -type f \( -name "*.sv" \) > $(RTL_DIR)/filelist.f
