import VPlay 2.0
import QtQuick 2.0


Scene {
    //every scene has a opacity of 0 by default and is not visible
    id: tutorialScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    signal menuPressed

    //a quick introduction to the goal of the game and tutorial
    Column {
        spacing: 5
        anchors.centerIn: parent
        Text {
            text: "In order to get a job as a developer \n you have to complete an app in less than 7 days"
            color: "white"
            font.family: gameWindow.pixelFont.name
        }
        MultiResolutionImage {
            anchors.horizontalCenter: parent.horizontalCenter
            height: 200
            width: 350
            source: "../assets/images/tutorialPage.png"

        }
        //by clicking the active scene will change to menu
        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Back"
            textColor: "black"
            onClicked: menuPressed()
        }
    }



}
