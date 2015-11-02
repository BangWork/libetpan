#!/bin/sh
set -e

DEP_TARGET="libetpan ios"
DEP_TARGET_OUTPUT="${PROJECT_NAME}-ios.a"
DEP_TARGET_INCLUDE="include"
UNIVERSAL_OUTPUTFOLDER="${BUILD_DIR}/${CONFIGURATION}-universal"

xcodebuild -project "${PROJECT_NAME}.xcodeproj" -target "${DEP_TARGET}" -configuration ${CONFIGURATION} -sdk iphoneos ONLY_ACTIVE_ARCH=NO BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"
xcodebuild -project "${PROJECT_NAME}.xcodeproj" -target "${DEP_TARGET}" -configuration ${CONFIGURATION} -sdk iphonesimulator ARCHS="i386 x86_64" VALID_ARCHS="arm64 armv7 armv7s i386 x86_64" BUILD_DIR="${BUILD_DIR}" BUILD_ROOT="${BUILD_ROOT}"

mkdir -p "${UNIVERSAL_OUTPUTFOLDER}"

lipo -create -output "${UNIVERSAL_OUTPUTFOLDER}/${DEP_TARGET_OUTPUT}" "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${DEP_TARGET_OUTPUT}" "${BUILD_DIR}/${CONFIGURATION}-iphonesimulator/${DEP_TARGET_OUTPUT}"

cp -R "${BUILD_DIR}/${CONFIGURATION}-iphoneos/${DEP_TARGET_INCLUDE}" "${UNIVERSAL_OUTPUTFOLDER}/"
