import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4
import QtQml.Models 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3
import QtQuick.Window 2.1

ApplicationWindow {

    id: applicationWindow
    visible: true
    width: 640
    height: 480
    function mm_to_px(n) {
        if (Screen.pixelDensity > 7) {
            return Screen.pixelDensity * 0.8 * n
        } else {
            return Screen.pixelDensity * n
        }
    }
    Button {
        height: mm_to_px(10)
        text: "Open Dialog"
        id: button
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        onClicked: dialog.open()
    }
    MouseArea {
        id: mouseArea
        anchors.fill: applicationWindow
        propagateComposedEvents: true
    }

    Popup {
        id: dialog
        width: mm_to_px(80)
        height: mm_to_px(60)
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true
        background: Rectangle {
            color: "#1e374f"
        }
        leftMargin: 0
        padding: 2
        ScrollView {
            id: scroll
            width: mm_to_px(80)
            height: mm_to_px(60)
            anchors.fill: parent
            clip: true
            Column {

                Row {
                    Button {
                        height: mm_to_px(12)
                        width: mm_to_px(15)
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: qsTr("Back")
                            color: "#ffffff"
                        }
                        onClicked: dialog.close()
                    }

                    Rectangle {
                        height: mm_to_px(12)
                        width: scroll.width - mm_to_px(15)
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            text: "Test"
                            color: "#ffffff"
                        }
                        color: "#1e374f"
                    }
                }


            }
        }
    }
}
