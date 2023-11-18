import QtQuick
import QtQuick.Controls


ApplicationWindow {
    id: root

    title: Application.displayName
    visible: true

    width: Screen.width
    height: Screen.height
    x: 0
    y: 0

    Button {
        id: pushMe
        anchors.centerIn: parent
        text: "Push me!"
        onClicked: Qt.callLater(Qt.quit)
    }

    Component.onCompleted: {
    }

}
