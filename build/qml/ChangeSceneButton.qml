import QtQuick 2.0
import VPlay 2.0

Item {
    id: button

    // public events
    signal clicked

    property alias text: buttonText.text
    property alias textColor: buttonText.color

    //the sound the button will make when clicked
    property alias clickSound: clickSound
    SoundEffectVPlay {id:clickSound; source:"../assets/sounds/403018__inspectorj__ui-confirmation-alert-c5.wav"}

    //button size is defined by the text
    width: buttonText.width+10
    height: buttonText.height+10

    // button image
    MultiResolutionImage {
        id: background
        anchors.fill: parent

        width: parent.width
        height: parent.height
        source: "../assets/images/pixelBorder"
    }

    // button text
    Text {
        id: buttonText
        anchors.centerIn: background
        font.family: gameWindow.pixelFont.name
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
