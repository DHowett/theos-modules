ifeq ($(THEOS_DEVICE_IPS),)
installs:
	@echo "make installs requires that you set THEOS_DEVICE_IPS to a space-delimited list of devices to install to."; exit 1
else
installs:
	@$(MAKE) -j$(words $(THEOS_DEVICE_IPS)) --no-print-directory --no-keep-going mod-internal-installs _THEOS_MAKE_PARALLEL=yes _THEOS_DEVICE_IPS="$(THEOS_DEVICE_IPS)"
endif

mod-internal-installs: $(foreach i,$(_THEOS_DEVICE_IPS),$(i).install)

%.install:
	@ \
	in="$@"; \
	ip=$${in%.install}; \
	echo Making install for $$ip; \
	$(MAKE) --no-print-directory --no-keep-going install THEOS_DEVICE_IP=$$ip _THEOS_TOP_INVOCATION_DONE=""
