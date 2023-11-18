import QtQuick
import QtQuick.Controls


ApplicationWindow {
    id: root

    title: Application.displayName
    visible: true

    width: Screen.width / 2
    height: Screen.height / 2
    x: Screen.width / 2
    y: 0

    Image {
        id: image
        width: parent.width / 2
        height: parent.height / 2
        anchors.centerIn: parent

        source: "qrc:/assets/logo.svg"
        fillMode: Image.PreserveAspectFit
    }

    Component.onCompleted: {
    }

}
