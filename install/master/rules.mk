ifeq ($(FW_DEVICE_IPS),)
installs:
	@echo "make installs requires that you set FW_DEVICE_IPS to a space-delimited list of devices to install to."; exit 1
else
installs:
	@$(MAKE) --no-print-directory --no-keep-going mod-internal-installs _FW_MAKE_PARALLEL=yes _FW_DEVICE_IPS="$(FW_DEVICE_IPS)"
endif

mod-internal-installs: $(foreach i,$(_FW_DEVICE_IPS),$(i).install)

%.install:
	@ \
	in="$@"; \
	ip=$${in%.install}; \
	echo Making install for $$ip; \
	$(MAKE) --no-print-directory --no-keep-going install FW_DEVICE_IP=$$ip _FW_TOP_INVOCATION_DONE=""
