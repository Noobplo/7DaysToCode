import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow



    activeScene: gameScene

    screenWidth: 960
    screenHeight: 640

    Scene {
        id: gameScene

        width: 480
        height: 320

        property bool gameRunning: false
        property alias startButton: startButton

        property alias clickBubbleSound: clickBubbleSound
        property alias missBubbleSound: missBubbleSound

        property int bubbleSize: 50
        property int fallSpeed: 2
        property int spawnfq: 500
        property int clickAreaSize: 50

        property int score: 0
        property int miss: 0

        SoundEffectVPlay {id:clickBubbleSound; source:"../assets/320655__rhodesmas__level-up-01.wav"}
        SoundEffectVPlay {id:missBubbleSound; source:"../assets/WINDOWS_XP_ERROR_SOUND.wav"}


        Rectangle {
            id: background
            anchors.fill: parent.gameWindowAnchorItem
            color: "grey"
        }

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

        Text {
            text: "Score: "+parent.score
            color: "white"
            anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
            anchors.top: parent.gameWindowAnchorItem.top
        }

        Text {
            text: "Missed: "+parent.miss
            color: "red"
            anchors.left: parent.gameWindowAnchorItem.left
            anchors.top: parent.gameWindowAnchorItem.top
        }

        Rectangle {
            id: startButton
            width: 80
            height: 50
            anchors.centerIn: parent
            color: "white"

            Text {
                text: "Start"
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

        PhysicsWorld { gravity.y: gameScene.fallSpeed; z: 1 }

        Timer {
            id: spawnBubble
            interval: gameScene.spawnfq
            running: parent.gameRunning
            repeat: true
            onTriggered: {
                entityManager.createEntityFromUrl(Qt.resolvedUrl("CodeBubble.qml"))
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
            if(gameScene.miss>=20) {
                entityManager.removeAllEntities()
                gameScene.miss=0
                gameScene.score=0
                gameScene.gameRunning=false
                gameScene.startButton.visible=true
            }
        }







    }
}
