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

        Rectangle {
            anchors.fill: parent.gameWindowAnchorItem
            color: "grey"
        }

        CodeBubble {
            anchors.centerIn: parent
        }

        EntityManager {
            id: entityManager
            entityContainer: gameScene
        }




    }
}
