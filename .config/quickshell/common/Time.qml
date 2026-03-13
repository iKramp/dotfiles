// Time.qml
pragma Singleton

import Quickshell
import QtQuick

Singleton {
    id: root

    readonly property string shortTime: {
        Qt.formatDateTime(clock.date, "hh:mm");
    }

    readonly property string secondTime: {
        Qt.formatDateTime(clock.date, "hh:mm:ss");
    }

    readonly property string date: {
        Qt.formatDateTime(clock.date, "dd-MM-yyyy");
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }
}
