import VPlay 2.0
import QtQuick 2.0


Scene {

    id: gameScene

    width: 480
    height: 320

    property bool gameRunning: false
    property alias startButton: startButton

    property alias clickBubbleSound: clickBubbleSound
    property alias missBubbleSound: missBubbleSound
    property alias redBullSound: redBullSound

    property int bubbleSize: 50
    property int fallSpeed: 2
    property int spawnInt: 500
    property int clickAreaSize: 50
    property int redBullSpawnInt: 5000

    property int startEnergy: 100
    property int startMotivation: 100

    property int maxEnergy: 100
    property int maxMotivation: 100

    property int motivationPenalityPerMiss: 20
    property int energyConPerClick: 2

    property int score: 0
    property int miss: 0


    property int energy: startEnergy
    property int motivation: startMotivation

    SoundEffectVPlay {id:clickBubbleSound; source:"../assets/320655__rhodesmas__level-up-01.wav"}
    SoundEffectVPlay {id:missBubbleSound; source:"../assets/WINDOWS_XP_ERROR_SOUND.wav"}
    SoundEffectVPlay {id:redBullSound; source:"../assets/Soda-can-opening-sound-effect.wav"}


    //background
    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        color: "grey"
    }

    //HUD
    Rectangle {
        width: parent.gameWindowAnchorItem.width
        anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
        anchors.top: parent.gameWindowAnchorItem.top
        height: 50
        //HUD is always on the front
        z: 3
        color: "black"

        Row {
            id: hud
            anchors.horizontalCenter: parent.Center
            x: 10
            spacing: 5
            Column {
                y: 3
                Text {
                    text: "Progress: "+Math.round(gameWindow.progress)+"%"
                    color: "green"
                    font.pixelSize: 10
                }
                Text {
                    text: "Energy: "+gameScene.energy
                    color: "yellow"
                    font.pixelSize: 10
                }
                Text {
                    text: "Motivation: "+gameScene.motivation
                    color: "purple"
                    font.pixelSize: 10
                }
            }
            Column {
                y: 3
                spacing: 5
                Rectangle {
                    width: (350*gameWindow.progress)/100
                    height: 10
                    color: "green"
                }
                Rectangle {
                    width: (350*gameScene.energy)/100
                    height: 10
                    color: "yellow"
                }
                Rectangle {
                    width: (350*gameScene.motivation)/100
                    height: 10
                    color: "purple"
                }
            }

        }

    }

    //Area where the code bubbles are clickable
    Rectangle {
        id: clickableArea
        width: parent.gameWindowAnchorItem.width
        height: gameScene.clickAreaSize
        anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
        y: parent.gameWindowAnchorItem.height*0.7
        color: "white"

        BoxCollider {
            categories: Box.Category2
            collisionTestingOnlyMode: true
            anchors.fill: parent


        }

    }

    //Button to start the game
    Rectangle {
        id: startButton
        width: 100
        height: 50
        anchors.centerIn: parent
        color: "white"

        Text {
            text: "Start Day "+gameWindow.currentDay
            color: "grey"
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                gameScene.gameRunning=true
                parent.visible=false

            }
        }
    }

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    //gravity for code bubbles so they can fall down
    PhysicsWorld { gravity.y: gameScene.fallSpeed; z: 1 }

    //code bubbles will spawn at given interval
    Timer {
        id: spawnBubble
        interval: gameScene.spawnInt
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("CodeBubble.qml"))
        }
    }

    Timer {
        id: spawnRedBull
        interval: gameScene.redBullSpawnInt
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            //there is only a 50% chance that a red bull can will spawn
            var rand=utils.generateRandomValueBetween(0,10)
            if(rand>=5)
            {
                entityManager.createEntityFromUrl(Qt.resolvedUrl("RedBullCan.qml"))
            }
        }
    }

    Timer {
        id: gameTimer
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            gameScene.checkGameOver()

        }
    }

    Rectangle {
        id: deathZone
        width: parent.gameWindowAnchorItem.width
        height: 10
        color: "red"
        anchors.top: parent.gameWindowAnchorItem.bottom

        BoxCollider {
            categories: Box.Category1
            collisionTestingOnlyMode: true
            anchors.fill: parent


        }
    }

    function checkGameOver() {
        if(gameScene.energy<=0||gameScene.motivation<=0) {
            entityManager.removeAllEntities()
            gameScene.energy=gameScene.startEnergy
            gameScene.motivation=gameScene.startMotivation
            gameScene.gameRunning=false
            gameScene.startButton.visible=true
        }
    }


}
