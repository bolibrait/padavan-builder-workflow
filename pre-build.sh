#!/bin/bash
set -e

# Отключаем поддержку CAN в конфигурации BusyBox для Padavan-NG
# В этой сборочной системе параметр называется CONFIG_BUSYBOX_DEFAULT_FEATURE_IP_LINK_CAN
sed -i 's/^CONFIG_BUSYBOX_DEFAULT_FEATURE_IP_LINK_CAN=y/# CONFIG_BUSYBOX_DEFAULT_FEATURE_IP_LINK_CAN is not set/' padavan-ng/trunk/user/busybox/busybox-1.37.0/.config

# Гарантированный патч для iplink.c: добавляем недостающие определения CAN
IPLINK_C="padavan-ng/trunk/user/busybox/busybox-1.37.0/networking/libiproute/iplink.c"

# Проверяем, не пропатчен ли уже файл, чтобы избежать дублирования
if ! grep -q "CAN_CTRLMODE_FD" "$IPLINK_C"; then
    sed -i '/#ifdef ENABLE_FEATURE_IP_LINK_CAN/i \
#ifndef CAN_CTRLMODE_FD\
#define CAN_CTRLMODE_FD 0x20\
#endif\
#ifndef CAN_CTRLMODE_FD_NON_ISO\
#define CAN_CTRLMODE_FD_NON_ISO 0x80\
#endif\
#ifndef CAN_CTRLMODE_PRESUME_ACK\
#define CAN_CTRLMODE_PRESUME_ACK 0x40\
#endif\
#ifndef IFLA_CAN_TERMINATION\
#define IFLA_CAN_TERMINATION 11\
#endif\n' "$IPLINK_C"
    echo "iplink.c patched with CAN definitions."
else
    echo "iplink.c already patched."
fi

echo "CAN support disabled in BusyBox config."
