import QtQuick
import qs.common

BarContainer {

    content: Text {
        id: timeText

        color: Colors.textColor
        font.pointSize: 12
        font.weight: Font.Medium
        anchors.centerIn: parent

        property bool showDate: false
        text: getText()

        function getText() {
            if (showDate) {
                return Time.date;
            } else {
                return Time.shortTime;
            }
        }
    }

    TapHandler {
        onTapped: {
            timeText.showDate = !timeText.showDate;
        }
    }
}
