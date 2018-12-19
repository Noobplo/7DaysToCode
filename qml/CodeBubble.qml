import QtQuick 2.0
import VPlay 2.0

EntityBase {
    entityType: "codeBubble"

    width: gameScene.bubbleSize
    height: gameScene.bubbleSize


    signal clicked

    property bool mouseEnable: false


    MultiResolutionImage {
        id: spriteCodeBubble

        width: parent.width
        height: parent.height
        source: "../assets/images/pixelCode.png"
    }

    CircleCollider {
        radius: spriteCodeBubble.width/2

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
                gameWindow.miss++;
                gameScene.motivation-=motivationPenalityPerMiss
                gameScene.comboReset(false)
            }
        }




    }

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            clickBubbleSound.play()
            removeEntity();
            gameWindow.score++;
            gameWindow.progress+=0.2
            gameScene.energy-=gameScene.energyConPerClick
            gameScene.hitCount++
            if(gameScene.hitCount>=gameScene.combo)
            {
                gameScene.comboReset(true)
            }

        }

        enabled: parent.mouseEnable
    }

    //where this entity should be created
    Component.onCompleted: {
         x = utils.generateRandomValueBetween(0,gameScene.width-spriteCodeBubble.width)
         y = -gameScene.bubbleSize
    }

}
