#!/usr/bin/env bash

#Stop when error
set -e 

SRC_PATH="$1"
BUILD_PATH="$2"
MESA_CLC_PATH="$3"
NDK_PATH="$4"

SCRIPT_DIR="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
MESON_LOCAL_PATH="${HOME}/.local/share/meson/cross"
ANDROID_AARCH64="android-aarch64"
ANDROID_PLATFORM="35"
mkdir -p "${MESON_LOCAL_PATH}"
ANDROID_PLATFORM="${ANDROID_PLATFORM}" NDK_PATH="${NDK_PATH}" \
envsubst < "${SCRIPT_DIR}/${ANDROID_AARCH64}.template" > "${MESON_LOCAL_PATH}/${ANDROID_AARCH64}"

PKG_CONFIG_PATH="${PKG_CONFIG_PATH}:${SCRIPT_DIR}" \
PATH="${MESA_CLC_PATH}:${PATH}" \
meson setup \
	--cross-file "${ANDROID_AARCH64}" \
	-Dbuildtype=release \
	-Dplatforms=android \
	-Dplatform-sdk-version=${ANDROID_PLATFORM} \
	-Dandroid-stub=true \
	-Dgallium-drivers=panfrost \
	-Dgbm=enabled \
	-Dgbm-backends-path=/apex/com.android.hardware.graphics.allocator.minigbm_dmabuf/lib64 \
	-Degl=enabled \
    -Dllvm=disabled \
	-Dcpp_rtti=false \
	-Dmesa-clc=system \
	-Dallow-fallback-for=libdrm \
	-Dvulkan-drivers= \
	-Degl-lib-suffix=_mesa \
	-Dgles-lib-suffix=_mesa \
	--reconfigure \
	--wipe \
    "${BUILD_PATH}" \
	"${SRC_PATH}"
meson compile -C "${BUILD_PATH}"
