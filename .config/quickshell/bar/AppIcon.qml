import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io

Item {
    id: appIcon
    implicitHeight: parent.implicitHeight
    implicitWidth: parent.implicitWidth
    required property HyprlandToplevel toplevel

    property var icon: null
    Component.onCompleted: resolveIcon()

    function resolveIcon() {
        let ipc = toplevel.lastIpcObject;
        if (!ipc || !ipc.class) {
            Hyprland.refreshToplevels();
        }

        let entry = DesktopEntries.byId(toplevel.wayland.appId) || DesktopEntries.byId(ipc.class) || DesktopEntries.byId(ipc.initialClass);
        if (entry && entry.icon) {
            console.log("Resolved icon for " + toplevel.wayland.appId + " as " + entry.icon);
            appIcon.icon = entry.icon;
            return;
        }
        appIcon.parentResolver.running = true;
    }

    IconImage {
        anchors.fill: parent
        source: Quickshell.iconPath(appIcon.icon)
    }

    property Process parentResolver: Process {
        id: parentResolver
        command: ["scripts/app_icon_resolve_parents.sh", toplevel.lastIpcObject.pid]

        stdout: StdioCollector {
            onStreamFinished: {
                console.log("Parent resolver output: " + JSON.stringify(this.text))
                appIcon.icon = this.text.trim();
            }
        }
    }
}
