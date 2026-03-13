import Quickshell
import QtQuick
import qs.common
import QtQuick.Layouts

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: mainBar
        required property var modelData
        screen: modelData

        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: 40

        property Text short_time_test: Text {
            anchors.centerIn: parent
            text: Time.shortTime
        }
        
        property Text long_time_test: Text {
            anchors.centerIn: parent
            text: Time.secondTime
        }

        property Text date_test: Text {
            anchors.centerIn: parent
            text: Time.date
        }

        RowLayout {
            anchors {
                left: parent.left
                verticalCenter: parent.verticalCenter
                leftMargin: 15
            }
            spacing: 10

            AppDisplay {}
        }

        RowLayout {
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            spacing: 10

            Text {
                text: "Center Group"
            }
        }

        RowLayout {
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 15
            }
            spacing: 10

            TimeDisplay {}
        }
    }
}
