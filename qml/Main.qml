import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    screenWidth: 960
    screenHeight: 640

    property double maxProgress: 100

    //achieve 100% progress to win this game, progress is made by clicking on the codeBubble in gameScene
    property double progress: 1

    //days are tries you have to get your progress to 100%
    property int daysLeft: 7

    property int currentDay: 1

    GameScene {
        id: gameScene
    }


}
