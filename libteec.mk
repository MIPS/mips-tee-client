################################################################################
#
# libteec
#
################################################################################

LIBTEEC_VERSION = 1.0
LIBTEEC_SITE = $(BR2_EXTERNAL_MIPS_REE_PATH)/package/libteec
LIBTEEC_SITE_METHOD = local
LIBTEEC_INSTALL_STAGING = YES
LIBTEEC_INSTALL_TARGET = YES
LIBTEEC_BUILD_DIR = $(BUILD_DIR)/libteec-$(LIBTEEC_VERSION)

# Public variables are stored in config.mk
include $(LIBTEEC_SITE)/config.mk

define LIBTEEC_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" AR="$(TARGET_AR)" -C $(@D) all
endef

define LIBTEEC_INSTALL_STAGING_CMDS
	cp $(LIBTEEC_BUILD_DIR)/out/libteec/libteec.so* $(STAGING_DIR)/lib
	cp $(LIBTEEC_BUILD_DIR)/public/*.h $(STAGING_DIR)/usr/include
endef

define LIBTEEC_INSTALL_TARGET_CMDS
	cp $(LIBTEEC_BUILD_DIR)/out/libteec/libteec.so* $(TARGET_DIR)/lib
	cp $(LIBTEEC_BUILD_DIR)/out/tee-supplicant/tee-supplicant $(TARGET_DIR)/bin
endef

$(eval $(generic-package))
