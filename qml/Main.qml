import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow



    activeScene: gamesScene

    screenWidth: 960
    screenHeight: 640

    Scene {
        id: gameScene


        width: 480
        height: 320
        property int score: 0
        property int miss: 0

        Rectangle {
            id: background
            anchors.fill: parent.gameWindowAnchorItem
            color: "grey"
        }

        Rectangle {
            id: line
            width: parent.gameWindowAnchorItem.width
            height: 10
            anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
            y: parent.gameWindowAnchorItem.height-parent.gameWindowAnchorItem.height*0.1
            color: "white"

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

        EntityManager {
            id: entityManager
            entityContainer: gameScene
        }

        PhysicsWorld { gravity.y: 5; z: 1 }

        Timer {
            id: spawnBubble
            interval: 1000
            running: true
            repeat: true
            onTriggered: {
                entityManager.createEntityFromUrl(Qt.resolvedUrl("CodeBubble.qml"))


            }
        }

        Rectangle {
            id: deathZone
            width: parent.gameWindowAnchorItem.width
            height: 10
            color: "red"
            anchors.top: parent.gameWindowAnchorItem.bottom

            BoxCollider {
                collisionTestingOnlyMode: true
                anchors.fill: parent
            }
        }







    }
}
