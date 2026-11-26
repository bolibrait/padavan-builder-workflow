#!/bin/bash
set -e

# Отключаем поддержку CAN в конфигурации BusyBox для Padavan-NG
# В этой сборочной системе параметр называется CONFIG_BUSYBOX_DEFAULT_FEATURE_IP_LINK_CAN
sed -i 's/^CONFIG_BUSYBOX_DEFAULT_FEATURE_IP_LINK_CAN=y/# CONFIG_BUSYBOX_DEFAULT_FEATURE_IP_LINK_CAN is not set/' padavan-ng/trunk/user/busybox/busybox-1.37.0/.config

echo "CAN support disabled in BusyBox config."
