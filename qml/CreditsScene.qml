import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

Scene {

    id: creditsScene
    visible: false
    enabled: visible

    signal menuPressed()

    property string text: ""


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
            text: creditsScene.text
            color: "white"
            font.family: gameWindow.pixelFont.name
        }

        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Back to Menu"
            textColor: "black"
            onClicked: menuPressed()
        }
    }

    function generateResultText() {
        if(gameWindow.progress>=100) {
            text="You have made it! Thx for playing \n Code Pieces clicked: "+gameWindow.score+"\n Code Pieces missed: "+gameWindow.miss+"\n Combos made: "+gameWindow.comboCount

        }
        else {
            text="Ouch....Wanna try again? \n Code Pieces clicked: "+gameWindow.score+"\n Code Pieces missed: "+gameWindow.miss+"\n Combos made: "+gameWindow.comboCount

        }

    }




}
