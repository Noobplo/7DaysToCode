import VPlay 2.0
import QtQuick 2.0

// EMPTY SCENE

Scene {

    id: nightScene
    opacity: 0
    visible: opacity > 0
    enabled: visible


    signal gamePressed

    property string eventText: ""

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
            text: "It is Night time and you are tired of today´s coding session... \n Your progress so far: "+ Math.round(gameWindow.progress)+"%"
            color: "white"
            font.family: gameWindow.pixelFont.name
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: nightScene.eventText
            color: "white"
            font.family: gameWindow.pixelFont.name
        }

        ChangeSceneButton {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Start next Day"
            textColor: "black"
            onClicked: gamePressed()
        }
    }

    function getRandomEvent()
    {
        gameScene.resetGameSettings()
        var rand=Math.floor(Math.random() * Math.floor(5))
        console.log("random Event"+rand)

        switch (rand) {
        case 0:
            eventText="Tonight was nice and quiet and nothing special happened"
            break;
        case 1:
            gameScene.startEnergy=50
            gameScene.startMotivation=50
            eventText="Your roommate starts showering at 3am, you can´t sleep \n You will start the day with 50 % energy and motivation"
            break;
        case 2:
            gameScene.redBullSpawnInt=gameScene.redBullSpawnInt/2
            eventText="A Red Bull truck has crushed into your flat...i guess nice? \n Red Bull cans spawnrate doubled"
            break;
        case 3:
            gameScene.fallSpeed=gameScene.fallSpeed*2
            eventText="Your asian dad called and asked if you doctor yet. The pressure is on! \n Code Pieces will fall twice as fast"
            break;
        case 4:
            gameScene.bubbleSize=gameScene.bubbleSize/2
            gameScene.clickAreaSize=gameScene.clickAreaSize/2
            eventText="You get a headache from all the red bull consumption \n Bar and Code size are smaller"
            break;
        }
    }
}
