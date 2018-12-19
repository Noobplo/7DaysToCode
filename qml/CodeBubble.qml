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



        //if this entity collides with the death zone it would be destroyed and else if it collides with the clickable zone the mousearea will be enabled
        fixture.onBeginContact: {
            if(other.categories===Box.Category1) {
                missBubbleSound.play()
                removeEntity();
                gameScene.miss++;
            }
            else {
                parent.mouseEnable=true
            }

        }

        //mousearea disabled as soon as it leaves the clickable zone
        fixture.onEndContact: {
            if(other.categories===Box.Category2) {
                parent.mouseEnable=false
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
        }

        enabled: parent.mouseEnable
    }

    //where this entity should be created
    Component.onCompleted: {
         x = utils.generateRandomValueBetween(0,gameScene.width-sprite.width)
         y = -gameScene.bubbleSize
    }

}
