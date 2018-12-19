import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

Scene {

    id: startScene
    visible: false
    enabled: visible

    signal gamePressed

    //background
    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        color: "black"
    }

    Column {
        spacing: 10
        anchors.centerIn: parent
        Text {
            id: title
            text: "7 Days To Code"
            font.pixelSize: 30
            color: "white"
        }

        MultiResolutionImage {
            id: logo
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100
            height: 100
            source: "../assets/images/LogoAnniChenFinalOnly2"

        }

        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Start Game"
            textColor: "black"
            color: "white"

            onClicked: gamePressed()
        }


    }



}
