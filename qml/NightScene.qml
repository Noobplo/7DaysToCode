import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

Scene {

    id: nightScene
    visible: false
    enabled: visible

    signal gamePressed()

    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        color: "black"
    }
    Column {
        spacing: 10
        anchors.centerIn: parent

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "It is Night time... \n Your progress so far: "+ Math.round(gameWindow.progress)+"%"
            color: "white"
        }

        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Start next Day"
            textColor: "black"
            color: "white"

            onClicked: gamePressed()
        }
    }



}
