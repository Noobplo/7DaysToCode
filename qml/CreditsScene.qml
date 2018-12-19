import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

Scene {

    id: creditsScene
    visible: false
    enabled: visible

    signal menuPressed()

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
            text: creditsScene.generateResultText()
            color: "white"
        }

        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Back to Menu"
            textColor: "black"
            color: "white"

            onClicked: menuPressed()
        }
    }

    function generateResultText() {
        var text=""
        if(gameWindow.gameEnding) {

            if(gameWindow.progress>=100) {
                text="You have made it! Thx for playing "
            }
            else {
                text="Ouch....Wanna try again? "
            }
            text+="\n Code Pieces clicked: "+gameWindow.score
            text+="\n Code Pieces missed: "+gameWindow.miss
            text+="\n Combos made: "+gameWindow.comboCount
            gameWindow.resetGame()
        }

        return text
    }




}
