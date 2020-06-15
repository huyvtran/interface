include(vcpkg_common_functions)
set(WEBRTC_VERSION 84.6.0)
set(MASTER_COPY_SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src)

set(WEBRTC_DOWNLOAD_URL https://github.com/crow-misia/libwebrtc-bin/releases/download/${WEBRTC_VERSION})

if (ANDROID)
   # this is handled by hifi_android.py
elseif (WIN32)
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS ${WEBRTC_DOWNLOAD_URL}/libwebrtc-win-x64.7z
        SHA512 938e3eade4e184363c136e02de13e0458732555cbcaab67d7b09a0a8f84256942248289236f059dd065316a7b0d9bce34263ed2f28f1d7fb8f9945b86d4ffee3
        FILENAME libwebrtc-win-x64.7z
    )
elseif (APPLE)
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS ${WEBRTC_DOWNLOAD_URL}/libwebrtc-macox-x64.tar.xz
        SHA512 f66b15d098a2b4401ee65ed9146b5b4fb4906fef085c853bce38cb422b198b90d49e1fbc597e0816cf4436451bd6817e98579f44ca16bc500de78bb1d08ee284
        FILENAME libwebrtc-macox-x64.tar.xz
    )
else ()
    # else Linux desktop
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS ${WEBRTC_DOWNLOAD_URL}/libwebrtc-linux-x64.tar.xz
        SHA512 df71748b8bc78d776494d46e99f06438b9917c8ee39b521f1506b6de609b1af1f3019eba22cfc4f5da14255dc70ec26acbb6a7878899ee8758809a9759af3904
        FILENAME libwebrtc-linux-x64.tar.xz
    )
endif ()

vcpkg_extract_source_archive(${WEBRTC_SOURCE_ARCHIVE})

if (WIN32)
    file(COPY ${MASTER_COPY_SOURCE_PATH}/release/webrtc.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    file(COPY ${MASTER_COPY_SOURCE_PATH}/debug/webrtc.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
else ()
    file(COPY ${MASTER_COPY_SOURCE_PATH}/lib/libwebrtc.a DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
    file(COPY ${MASTER_COPY_SOURCE_PATH}/lib/libwebrtc.a DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
endif ()

file(COPY ${MASTER_COPY_SOURCE_PATH}/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/webrtc)

file(INSTALL ${MASTER_COPY_SOURCE_PATH}/NOTICE DESTINATION ${CURRENT_PACKAGES_DIR}/share/webrtc RENAME copyright)
