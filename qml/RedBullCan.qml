import VPlay 2.0
import QtQuick 2.0

EntityBase {

    entityType: "redBullCan"

    width: 80
    height: 80

    property int lifespan: 3
    property int energyValue: 30
    property bool spawned: false

    //red bull cans should be placed in front of the code bubbles
    z: 2

    MultiResolutionImage {
        id: sprite

        width: parent.width
        height: parent.height
        source: "../assets/red-bull-png-more-views-600.png"
    }

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            redBullSound.play()
            removeEntity();
            if(gameScene.energy<=(maxEnergy-energyValue))
            {
                gameScene.energy+=energyValue
            }
            else
            {
                gameScene.energy=gameScene.maxEnergy
            }


        }
    }

    Timer {
        running: spawned
        repeat: true
        onTriggered: {
            lifespan--
            console.log("its alive!!")
            if(lifespan<=0)
            {
                removeEntity();
            }
        }
    }

    Component.onCompleted: {
        x = utils.generateRandomValueBetween(0,gameScene.width-sprite.width)
        y = utils.generateRandomValueBetween(50+sprite.height,gameScene.height*0.7-sprite.height)
        spawned=true

    }

}
