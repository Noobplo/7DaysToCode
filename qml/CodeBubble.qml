import QtQuick 2.0
import VPlay 2.0

EntityBase {
    entityType: "codeBubble"

    width: gameScene.bubbleSize
    height: gameScene.bubbleSize

    signal clicked

    property bool mouseEnable: false


    MultiResolutionImage {
        id: sprite

        width: parent.width
        height: parent.height
        source: "../assets/codeBubble.png"
    }

    CircleCollider {
        radius: sprite.width/2

        categories: Circle.Category3

        collidesWith: Box.Category1 | Box.Category2

        fixture.onBeginContact: {
            //if it collides with the clickable zone the mousearea will be enabled
            if(other.categories===Box.Category2) {
                parent.mouseEnable=true
            }


        }

        fixture.onEndContact: {
            //mousearea disabled as soon as it leaves the clickable zone
            if(other.categories===Box.Category2) {
                parent.mouseEnable=false
            }
            else
            {
                //if this entity ends colliding with the death zone it would be destroyed
                missBubbleSound.play()
                removeEntity();
                gameScene.miss++;
                gameScene.motivation-=motivationPenalityPerMiss
            }
        }




    }

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            clickBubbleSound.play()
            removeEntity();
            gameScene.score++;
            gameWindow.progress+=0.1
            gameScene.energy-=gameScene.energyConPerClick

        }

        enabled: parent.mouseEnable
    }

    //where this entity should be created
    Component.onCompleted: {
         x = utils.generateRandomValueBetween(0,gameScene.width-sprite.width)
         y = -gameScene.bubbleSize
    }

}
