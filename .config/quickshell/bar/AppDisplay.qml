import QtQuick
import Quickshell.Hyprland

BarContainer {
    id: appDisplay

    content: Row {
        spacing: 10

        Repeater {
            id: appRepeater
            model: {
                Hyprland.refreshMonitors();
                Hyprland.refreshToplevels();
                Hyprland.toplevels.values.filter(function (client) {
                    return client.monitor.lastIpcObject.name == appDisplay.Screen.name;
                });
            }

            delegate: Item {
                implicitWidth: 25
                implicitHeight: 25

                AppIcon {
                    toplevel: modelData
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: Hyprland.dispatch("focuswindow address:" + modelData.lastIpcObject.address)
                }
            }
        }
    }
}
