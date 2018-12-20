import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

Scene {

    //every scene has a opacity of 0 by default and is not visible
    id: creditsScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    //depends on which result, different background music is played
    property alias bgMusic: bgMusic
    BackgroundMusic {id: bgMusic ; autoPlay: false}

    signal menuPressed

    //Result text will be generated when game ends
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

        //by clicking the active scene will change to menu
        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Back to Menu"
            textColor: "black"
            onClicked: menuPressed()
        }
    }

    //called when game ends, depending on results there are different endings and music
    function generateResultText() {
        if(gameWindow.progress>=100) {
            bgMusic.source="../assets/music/8_Bit_Win_Happy_Victorious_Game_Music_By_HeatleyBros.mp3"
            text="Yessy! You have made it on Time! Thx for playing! \n Days Left: "+(gameWindow.daysLeft-gameWindow.currentDay)
        }
        else {
            bgMusic.source="../assets/music/8_Bit_Chillout_Chill_Dreamy_Game_Music_by_HeatleyBros.mp3"
            text="Ouch! You dun goofed, \n better git gud on burgerflipping at McDonalds \n Progress made: "+Math.round(gameWindow.progress)+"%"
        }
        text+="\n Code Pieces clicked: "+gameWindow.score+"\n Code Pieces missed: "+gameWindow.miss+"\n Combos made: "+gameWindow.comboCount
        bgMusic.play()
    }
}
