import VPlay 2.0
import QtQuick 2.0


Scene {
    id: tutorialScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    signal menuPressed

    MultiResolutionImage {
        anchors.fill: parent
        anchors.top: parent.top
        source: "../assets/images/tutorialPage.png"

    }
    ChangeSceneButton {
        anchors.right: parent.right
        y: 10
        text: "Back"
        textColor: "black"
        onClicked: menuPressed()
    }


}
