#!/bin/bash
# Отключаем поддержку CAN в конфигурации BusyBox
# Это предотвратит ошибку компиляции, связанную со старыми заголовочными файлами ядра
sed -i 's/^CONFIG_FEATURE_IP_LINK_CAN=y/# CONFIG_FEATURE_IP_LINK_CAN is not set/' padavan-ng/trunk/user/busybox/busybox-1.37.0/.config
