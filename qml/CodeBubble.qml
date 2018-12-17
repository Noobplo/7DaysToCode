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

    MouseArea {
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            removeEntity();
        }
    }

}
