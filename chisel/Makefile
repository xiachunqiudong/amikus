RTL_DIR = $(shell pwd)/rtl_code

verilog:
	mkdir -p $(RTL_DIR)
	mill amikus.runMain Elaborate --target-dir $(RTL_DIR)
	rm -rf $(RTL_DIR)/verification
	awk '{print "$(RTL_DIR)/" $$0}' $(RTL_DIR)/filelist.f > $(RTL_DIR)/filelist_tmp.f && \
	mv -f $(RTL_DIR)/filelist_tmp.f $(RTL_DIR)/filelist.f
