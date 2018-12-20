import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

Scene {

    //every scene has a opacity of 0 by default and is not visible
    id: startScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    signal gamePressed
    signal tutorialPressed

    //backgrounnd music
    property alias bgMusic: bgMusic
    BackgroundMusic {id: bgMusic ; source:"../assets/music/8_Bit_Love_Happy_Fun_Game_Music_by_HeatleyBros.mp3"}

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
            font.family: gameWindow.pixelFont.name
        }

        MultiResolutionImage {
            id: logo
            anchors.horizontalCenter: parent.horizontalCenter
            width: 100
            height: 100
            source: "../assets/images/LogoAnniChenFinalOnly2"

        }

        //by clicking the active scene will change to game scene
        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Start Game"
            textColor: "black"
            onClicked: gamePressed()
        }

        //by clicking the active scene will change to tutorial
        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "How To Play"
            textColor: "black"
            onClicked: tutorialPressed()
        }
    }
}
