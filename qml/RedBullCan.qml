import VPlay 2.0
import QtQuick 2.0

EntityBase {

    entityType: "redBullCan"

    width: 80
    height: 80

    //lifespan of a red bull can
    property int lifespan: 3
    //increase energy
    property int energyValue: 20
    //Timer will be activated as soon as it is spawned
    property bool spawned: false

    //red bull cans should be placed in front of the code bubbles
    z: 2

    MultiResolutionImage {
        id: spriteRedBull

        width: parent.width
        height: parent.height
        source: "../assets/images/pixelRedBull.png"
    }

    //by clicking the energy will increase by energyValue
    MouseArea {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            redBullSound.play()
            removeEntity();
            gameScene.gainEnergy(energyValue)

        }
    }

    //Timer to check the lifespan of a red bull can, if it exists longer than its lifespan it will be removed
    Timer {
        running: spawned
        repeat: true
        onTriggered: {
            lifespan--
            if(lifespan<=0) {
                removeEntity();
            }
        }
    }

    //where this entity should be created
    Component.onCompleted: {
        x = utils.generateRandomValueBetween(0,gameScene.width-spriteRedBull.width)
        y = utils.generateRandomValueBetween(50,gameScene.height*0.7-spriteRedBull.height)
        spawned=true
    }
}
