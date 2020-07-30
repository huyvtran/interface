#
#  Copyright 2019 High Fidelity, Inc.
#
#  Distributed under the Apache License, Version 2.0.
#  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
#
macro(TARGET_WEBRTC)
    if (ANDROID)
        # I don't yet have working libwebrtc for android
        # include(SelectLibraryConfigurations)
        # set(INSTALL_DIR ${HIFI_ANDROID_PRECOMPILED}/webrtc/webrtc)
        # set(WEBRTC_INCLUDE_DIRS "${INSTALL_DIR}/include/webrtc")
        # set(WEBRTC_LIBRARY_DEBUG ${INSTALL_DIR}/debug/lib/libwebrtc.a)
        # set(WEBRTC_LIBRARY_RELEASE ${INSTALL_DIR}/lib/libwebrtc.a)
        # select_library_configurations(WEBRTC)
    else()
        set(WEBRTC_INCLUDE_DIRS "${VCPKG_INSTALL_ROOT}/include/webrtc")
        message("WEBRTC_INCLUDE_DIRS ${WEBRTC_INCLUDE_DIRS}")
        target_include_directories(${TARGET_NAME} SYSTEM PUBLIC ${WEBRTC_INCLUDE_DIRS})

        # cant easily link a static library to a static library
        get_target_property(target_type ${TARGET_NAME} TYPE)
        if (NOT target_type STREQUAL STATIC_LIBRARY)
            find_library(WEBRTC_LIBRARY_RELEASE webrtc PATHS ${VCPKG_INSTALL_ROOT}/lib NO_DEFAULT_PATH)
            find_library(WEBRTC_LIBRARY_DEBUG webrtc PATHS ${VCPKG_INSTALL_ROOT}/debug/lib NO_DEFAULT_PATH)
            select_library_configurations(WEBRTC)
            target_link_libraries(${TARGET_NAME} ${WEBRTC_LIBRARIES})
        endif()

        target_compile_definitions(${TARGET_NAME} PUBLIC WEBRTC_APM_DEBUG_DUMP=0)
    endif()
endmacro()
