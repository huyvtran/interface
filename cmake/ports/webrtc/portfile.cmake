include(vcpkg_common_functions)
set(WEBRTC_VERSION 85.4183.2.0)
set(MASTER_COPY_SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src)

set(WEBRTC_DOWNLOAD_URL https://github.com/crow-misia/libwebrtc-bin/releases/download/${WEBRTC_VERSION})

if (ANDROID)
   # this is handled by hifi_android.py
elseif (WIN32)
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS ${WEBRTC_DOWNLOAD_URL}/libwebrtc-win-x64.7z
        SHA512 35ba009502041f37d017f5a8cbbe42686072401480817c4f45f5684f1e8f2108ea850579a08c0e347a392e43472c567ba6980773ed77ce8069baf1c1f6ef3842
        FILENAME libwebrtc-win-x64.7z
    )
elseif (APPLE)
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS ${WEBRTC_DOWNLOAD_URL}/libwebrtc-macox-x64.tar.xz
        SHA512 35ba009502041f37d017f5a8cbbe42686072401480817c4f45f5684f1e8f2108ea850579a08c0e347a392e43472c567ba6980773ed77ce8069baf1c1f6ef3842
        FILENAME libwebrtc-macox-x64.tar.xz
    )
else () # Linux
    if (VCPKG_TARGET_ARCHITECTURE STREQUAL "x64")
        vcpkg_download_distfile(
            WEBRTC_SOURCE_ARCHIVE
            URLS ${WEBRTC_DOWNLOAD_URL}/libwebrtc-linux-x64.tar.xz
            SHA512 370ad21f2aa8c810ff81fefb4a8a024500198bfd7ce751b11dbb58b8d066ccc59d4dc0d2ad992a5f3ddbed5f39a1fd4e2e9536d2e4a1acc4d6d704165f4625d5
            FILENAME libwebrtc-linux-x64.tar.xz
        )
    elseif (VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
        vcpkg_download_distfile(
            WEBRTC_SOURCE_ARCHIVE
            URLS ${WEBRTC_DOWNLOAD_URL}/libwebrtc-linux-arm64.tar.xz
            SHA512 370ad21f2aa8c810ff81fefb4a8a024500198bfd7ce751b11dbb58b8d066ccc59d4dc0d2ad992a5f3ddbed5f39a1fd4e2e9536d2e4a1acc4d6d704165f4625d5
            FILENAME libwebrtc-linux-x64.tar.xz
        )
    endif ()
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
