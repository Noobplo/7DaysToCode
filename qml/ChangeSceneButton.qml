import QtQuick 2.0
import VPlay 2.0

Item {
    id: button

    // public events
    signal clicked

    property alias text: buttonText.text
    property alias color: background.color
    property alias textColor: buttonText.color

    property alias clickSound: clickSound
    SoundEffectVPlay {id:clickSound; source:"../assets/sounds/403018__inspectorj__ui-confirmation-alert-c5.wav"}

    width: buttonText.width+10
    height: buttonText.height+10

    // button background
    Rectangle {
        id: background
        anchors.fill: parent
    }

    // button text
    Text {
        id: buttonText
        anchors.centerIn: background
    }

    // mouse area to handle click events
    MouseArea {
        id: mouseArea
        anchors.fill: background
        hoverEnabled: true
        onClicked: {
            parent.clickSound.play()
            button.clicked()
        }
    }

}
