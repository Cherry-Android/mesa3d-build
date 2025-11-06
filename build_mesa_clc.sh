#!/usr/bin/env bash

# stop when error occurs
set -xe

SRC_PATH="$1"
BUILD_PATH="$2"

meson setup \
	-Dbuildtype=release \
	-Dstrip=true \
	-Dplatforms= \
	-Dgallium-drivers= \
    -Dvulkan-drivers= \
	-Dmesa-clc=enabled \
	-Dinstall-mesa-clc=true \
	--reconfigure \
	--wipe \
	"${BUILD_PATH}" \
	"${SRC_PATH}"
meson compile -C "${BUILD_PATH}"

mkdir -p "${BUILD_PATH}/bin"
cp "${BUILD_PATH}/src/compiler/clc/mesa_clc" "${BUILD_PATH}/bin"
cp "${BUILD_PATH}/src/compiler/spirv/vtn_bindgen2" "${BUILD_PATH}/bin"
ls ${BUILD_PATH}/bin/mesa_clc
ls ${BUILD_PATH}/bin/vtn_bindgen2
