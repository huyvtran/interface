include(vcpkg_common_functions)
set(WEBRTC_VERSION m84.6.0)
set(MASTER_COPY_SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src)

if (ANDROID)
   # this is handled by hifi_android.py
elseif (WIN32)
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS https://cdn.tivolicloud.com/dependencies/webrtc-20190626-windows.zip
        SHA512 c0848eddb1579b3bb0496b8785e24f30470f3c477145035fd729264a326a467b9467ae9f426aa5d72d168ad9e9bf2c279150744832736bdf39064d24b04de1a3
        FILENAME webrtc-20190626-windows.zip
    )
elseif (APPLE)
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS https://cdn.tivolicloud.com/dependencies/webrtc-m78-osx.tar.gz
        SHA512 8b547da921cc96f5c22b4253a1c9e707971bb627898fbdb6b238ef1318c7d2512e878344885c936d4bd6a66005cc5b63dfc3fa5ddd14f17f378dcaa17b5e25df
        FILENAME webrtc-m78-osx.tar.gz
    )
else ()
    # else Linux desktop
    vcpkg_download_distfile(
        WEBRTC_SOURCE_ARCHIVE
        URLS https://github.com/crow-misia/libwebrtc-bin/releases/download/84.6.0/libwebrtc-linux-x64.tar.xz
        SHA512 df71748b8bc78d776494d46e99f06438b9917c8ee39b521f1506b6de609b1af1f3019eba22cfc4f5da14255dc70ec26acbb6a7878899ee8758809a9759af3904
        FILENAME libwebrtc-linux-x64.tar.xz
    )
endif ()

vcpkg_extract_source_archive(${WEBRTC_SOURCE_ARCHIVE})

file(COPY ${MASTER_COPY_SOURCE_PATH}/include/ DESTINATION ${CURRENT_PACKAGES_DIR}/include/webrtc)
file(COPY ${MASTER_COPY_SOURCE_PATH}/lib/libwebrtc.a DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
file(COPY ${MASTER_COPY_SOURCE_PATH}/lib/libwebrtc.a DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
file(COPY ${MASTER_COPY_SOURCE_PATH}/NOTICE DESTINATION ${CURRENT_PACKAGES_DIR}/share/webrtc/copyright)