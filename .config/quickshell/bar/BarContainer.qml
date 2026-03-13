import QtQuick
import qs.common

Rectangle {
    id: barContainer

    property double vert_padding: 8
    property double hor_padding: 12

    implicitWidth: content.implicitWidth + 2 * hor_padding
    implicitHeight: 36
    color: Colors.backgroundColor
    border.color: Colors.borderColor
    border.width: 3
    radius: 15

    required property Item content

    Component.onCompleted: {
        content.parent = barContainer
        content.anchors.centerIn = barContainer
    }
}
