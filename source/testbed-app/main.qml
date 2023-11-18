import QtQuick
import QtQuick.Controls

import com.dsazonoff.wheel


ApplicationWindow {
    id: root

    title: Application.displayName
    visible: true

    width: Screen.width / 2
    height: Screen.height / 2
    x: Screen.width / 2
    y: 0

    Wheel {
        id: wheel
    }

    Component.onCompleted: {
    }

}
