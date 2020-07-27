//
//  GraphicsSettings.qml
//  qml\hifi\dialogs\graphics
//
//  Created by Zach Fox on 2019-07-10
//  Copyright 2019 High Fidelity, Inc.
//
//  Distributed under the Apache License, Version 2.0.
//  See the accompanying file LICENSE or http://www.apache.org/licenses/LICENSE-2.0.html
//

import Hifi 1.0 as Hifi
import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.12
import stylesUit 1.0 as HifiStylesUit
import controlsUit 1.0 as HifiControlsUit
import "qrc:////qml//controls" as HifiControls
import PerformanceEnums 1.0

Item {
    HifiStylesUit.HifiConstants { id: hifi; }

    id: root;
    anchors.fill: parent

    ColumnLayout {
        id: graphicsSettingsColumnLayout
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.right: parent.right
        anchors.rightMargin: 26
        anchors.top: parent.top
        anchors.topMargin: HMD.active ? 80 : 0
        spacing: 8

        ColumnLayout {
            Layout.preferredWidth: parent.width
            Layout.topMargin: 18
            spacing: 0

            HifiStylesUit.RobotoRegular {
                text: "GRAPHICS SETTINGS"
                Layout.maximumWidth: parent.width
                height: 30
                size: 16
                color: "#FFFFFF"
            }

            ColumnLayout {
                Layout.topMargin: 10
                Layout.preferredWidth: parent.width
                spacing: 0
                
                HifiControlsUit.RadioButton {
                    id: performancePotato
                    colorScheme: hifi.colorSchemes.dark
                    height: 18
                    fontSize: 16
                    leftPadding: 0
                    text: "Potato"
                    checked: Performance.getPerformancePreset() === PerformanceEnums.POTATO
                    onClicked: {
                        Performance.setPerformancePreset(PerformanceEnums.POTATO);
                        root.refreshAllDropdowns();
                    }
                }

                HifiControlsUit.RadioButton {
                    id: performanceLow
                    colorScheme: hifi.colorSchemes.dark
                    height: 18
                    fontSize: 16
                    leftPadding: 0
                    text: "Low"
                    checked: Performance.getPerformancePreset() === PerformanceEnums.LOW
                    onClicked: {
                        Performance.setPerformancePreset(PerformanceEnums.LOW);
                        root.refreshAllDropdowns();
                    }
                }

                HifiControlsUit.RadioButton {
                    id: performanceMedium
                    colorScheme: hifi.colorSchemes.dark
                    height: 18
                    fontSize: 16
                    leftPadding: 0
                    text: "Medium"
                    checked: Performance.getPerformancePreset() === PerformanceEnums.MID
                    onClicked: {
                        Performance.setPerformancePreset(PerformanceEnums.MID);
                        root.refreshAllDropdowns();
                    }
                }

                HifiControlsUit.RadioButton {
                    id: performanceHigh
                    colorScheme: hifi.colorSchemes.dark
                    height: 18
                    fontSize: 16
                    leftPadding: 0
                    text: "High"
                    checked: Performance.getPerformancePreset() === PerformanceEnums.HIGH
                    onClicked: {
                        Performance.setPerformancePreset(PerformanceEnums.HIGH);
                        root.refreshAllDropdowns();
                    }
                }

                HifiControlsUit.RadioButton {
                    id: performanceCustom
                    colorScheme: hifi.colorSchemes.dark
                    height: 18
                    fontSize: 16
                    leftPadding: 0
                    text: "Custom"
                    checked: Performance.getPerformancePreset() === PerformanceEnums.UNKNOWN
                    onClicked: {
                        Performance.setPerformancePreset(PerformanceEnums.UNKNOWN);
                    }
                }
            }

            ColumnLayout {
                Layout.topMargin: 10
                Layout.preferredWidth: parent.width
                spacing: 0

                Item {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 35

                    HifiStylesUit.RobotoRegular {
                        id: worldDetailHeader
                        text: "World Detail"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 130
                        height: parent.height
                        size: 16
                        color: "#FFFFFF"
                    }

                    ListModel {
                        id: worldDetailModel

                        ListElement {
                            text: "Low World Detail"
                        }
                        ListElement {
                            text: "Medium World Detail"
                        }
                        ListElement {
                            text: "Full World Detail"
                        }
                    }
                
                    HifiControlsUit.ComboBox {
                        id: worldDetailDropdown
                        // enabled: performanceCustom.checked
                        anchors.left: worldDetailHeader.right
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        width: 280
                        height: parent.height
                        colorScheme: hifi.colorSchemes.dark
                        model: worldDetailModel
                        currentIndex: -1

                        function refreshWorldDetailDropdown() {
                            worldDetailDropdown.currentIndex = LODManager.worldDetailQuality;
                        }

                        Component.onCompleted: {
                            worldDetailDropdown.refreshWorldDetailDropdown();
                        }
                        
                        onCurrentIndexChanged: {
                            LODManager.worldDetailQuality = currentIndex;
                            worldDetailDropdown.displayText = model.get(currentIndex).text;
                        }
                    }
                }

                Item {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 35
                    Layout.topMargin: 20

                    HifiStylesUit.RobotoRegular {
                        id: renderingEffectsHeader
                        text: "Rendering Effects"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 130
                        height: parent.height
                        size: 16
                        color: "#FFFFFF"
                    }

                    ListModel {
                        id: renderingEffectsModel

                        ListElement {
                            text: "No Rendering Effects"
                            preferredRenderMethod: 1 // "FORWARD"
                            shadowsEnabled: false
                        }
                        ListElement {
                            text: "Local Lights, Fog, Bloom"
                            preferredRenderMethod: 0 // "DEFERRED"
                            shadowsEnabled: false
                        }
                        ListElement {
                            text: "Local Lights, Fog, Bloom, Shadows"
                            preferredRenderMethod: 0 // "DEFERRED"
                            shadowsEnabled: true
                        }
                    }
                
                    HifiControlsUit.ComboBox {
                        id: renderingEffectsDropdown
                        // enabled: performanceCustom.checked
                        anchors.left: renderingEffectsHeader.right
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        width: 280
                        height: parent.height
                        colorScheme: hifi.colorSchemes.dark
                        model: renderingEffectsModel
                        currentIndex: -1

                        function refreshRenderingEffectsDropdownDisplay() {
                            if (Render.shadowsEnabled) {
                                renderingEffectsDropdown.currentIndex = 2;
                            } else if (Render.renderMethod === 0) {
                                renderingEffectsDropdown.currentIndex = 1;
                            } else {
                                renderingEffectsDropdown.currentIndex = 0;
                            }
                        }

                        Component.onCompleted: {
                            renderingEffectsDropdown.refreshRenderingEffectsDropdownDisplay();
                        }
                        
                        onCurrentIndexChanged: {
                            var renderMethodToSet = 1;
                            if (model.get(currentIndex).preferredRenderMethod === 0 &&
                                PlatformInfo.isRenderMethodDeferredCapable()) {
                                renderMethodToSet = 0;
                            }
                            Render.renderMethod = renderMethodToSet;
                            Render.shadowsEnabled = model.get(currentIndex).shadowsEnabled;
                            renderingEffectsDropdown.displayText = model.get(currentIndex).text;
                        }
                    }
                }

                Item {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 35
                    Layout.topMargin: 20

                    HifiStylesUit.RobotoRegular {
                        id: refreshRateHeader
                        text: "Target frame rate"
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 130
                        height: parent.height
                        size: 16
                        color: "#FFFFFF"
                    }

                    ListModel {
                        id: refreshRateModel

                        ListElement {
                            text: "20 FPS"
                            refreshRatePreset: 0 // RefreshRateProfile::ECO
                        }
                        ListElement {
                            text: "30 FPS"
                            refreshRatePreset: 1 // RefreshRateProfile::INTERACTIVE
                        }
                        ListElement {
                            text: "60 FPS"
                            refreshRatePreset: 2 // RefreshRateProfile::REALTIME
                        }
                        ListElement {
                            text: "Unlimited FPS"
                            refreshRatePreset: 3 // RefreshRateProfile::UNLIMITED
                        }
                    }
                
                    HifiControlsUit.ComboBox {
                        id: refreshRateDropdown
                        // enabled: performanceCustom.checked
                        anchors.left: refreshRateHeader.right
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        width: 280
                        height: parent.height
                        colorScheme: hifi.colorSchemes.dark
                        model: refreshRateModel
                        currentIndex: -1

                        function refreshRefreshRateDropdownDisplay() {
                            if (Performance.getRefreshRateProfile() === 0) {
                                refreshRateDropdown.currentIndex = 0;
                            } else if (Performance.getRefreshRateProfile() === 1) {
                                refreshRateDropdown.currentIndex = 1;
                            } else if (Performance.getRefreshRateProfile() === 2) {
                                refreshRateDropdown.currentIndex = 2;
                            } else {
                                refreshRateDropdown.currentIndex = 3;
                            }
                        }

                        Component.onCompleted: {
                            refreshRateDropdown.refreshRefreshRateDropdownDisplay();
                        }
                        
                        onCurrentIndexChanged: {
                            Performance.setRefreshRateProfile(model.get(currentIndex).refreshRatePreset);
                            refreshRateDropdown.displayText = model.get(currentIndex).text;
                        }
                    }
                }

                Item {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: 35
                    Layout.topMargin: 16

                    HifiStylesUit.RobotoRegular {
                        id: resolutionHeader
                        text: "Supersampling " + Number.parseFloat(Render.viewportResolutionScale).toPrecision(2)
                        anchors.left: parent.left
                        anchors.top: parent.top
                        width: 130
                        height: parent.height
                        size: 16
                        color: "#FFFFFF"
                    }
                
                    HifiControlsUit.Slider {
                        id: resolutionScaleSlider
                        // enabled: performanceCustom.checked
                        anchors.left: resolutionHeader.right
                        anchors.leftMargin: 20
                        anchors.top: parent.top
                        width: 280
                        height: parent.height
                        colorScheme: hifi.colorSchemes.dark
                        minimumValue: 0.1
                        maximumValue: 4.0
                        stepSize: 0.1
                        value: Render.viewportResolutionScale
                        live: true

                        function updateResolutionScale(sliderValue) {
                            if (Render.viewportResolutionScale !== sliderValue) {
                                Render.viewportResolutionScale = sliderValue;
                            }
                        }

                        onValueChanged: {
                            if (value > 1) {
                                value = Math.round(value * 2) / 2
                            }
                            updateResolutionScale(value);
                        }
                        onPressedChanged: {
                            if (!pressed) {
                                updateResolutionScale(value);
                            }
                        }
                    }

                    HifiStylesUit.RobotoRegular {
                        text: "\n\n\nWarning - Sampling over 1.0 will lower your frame rate!"
                        Layout.maximumWidth: parent.width
                        anchors.left: parent.left
                        anchors.top: parent.top
                        height: 30
                        size: 16
                        color: "#B33A3A"
                    }
                }
            }
        }
    }

    function refreshAllDropdowns() {
        worldDetailDropdown.refreshWorldDetailDropdown();
        renderingEffectsDropdown.refreshRenderingEffectsDropdownDisplay();
        refreshRateDropdown.refreshRefreshRateDropdownDisplay();
    }
}
