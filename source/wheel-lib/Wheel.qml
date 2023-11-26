import QtQuick
import QtQuick.Controls

import QtQuick.Dialogs


Image {
    id: image
    width: parent.width / 2
    height: parent.height / 2
    anchors.centerIn: parent

    source: "qrc:/assets/logo.svg"
    fillMode: Image.PreserveAspectFit

    RotationAnimation on rotation {
        id: animation
        loops: Animation.Infinite
        from: 0
        to: 360
        duration: 6000
        running: mouseArea.containsMouse
    }

    MessageDialog {
        id: messagebox
        buttons: MessageDialog.Ok
        text: "Hi there!"
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            animation.start()
        }
        onExited: {
            animation.stop()
            let angle = image.rotation % 360
            animation.from = angle
            animation.to = angle + 360
        }
        onClicked: messagebox.open()
    }
}
