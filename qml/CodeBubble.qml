import QtQuick 2.0
import VPlay 2.0

EntityBase {
    entityType: "codeBubble"

    width: 50
    height: 50

    signal clicked


    MultiResolutionImage {
        id: sprite
        source: "../assets/codeBubble.png"
    }

    CircleCollider {
        radius: sprite.width/2

        fixture.onBeginContact: {
            removeEntity();
            gameScene.miss++;

        }
    }

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            removeEntity();
            gameScene.score++;
        }
    }

    Component.onCompleted: {
         x = utils.generateRandomValueBetween(0,gameScene.width-sprite.width)
         y = 0
    }

}
