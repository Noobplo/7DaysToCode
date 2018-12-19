import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    state: "menu"

    screenWidth: 960
    screenHeight: 640

    property double maxProgress: 100

    //achieve 100% progress to win this game, progress is made by clicking on the codeBubble in gameScene
    property double progress: 1

    property int score: 0
    property int miss: 0
    property int comboCount: 0

    //days are tries you have to get your progress to 100%
    property int daysLeft: 7

    property int currentDay: 1

    //Credits Scene will generate a result text as soon game has ended
    property bool gameEnding: false

    GameScene {
        id: gameScene
    }

    StartScene {
        id: startScene
        onGamePressed: gameWindow.state="game"
    }

    NightScene {
        id: nightScene
        onGamePressed: gameWindow.state="game"
    }

    CreditsScene {
        id: creditsScene
        onMenuPressed: gameWindow.state="menu"
    }



    states: [
        State {
            name: "menu"
            PropertyChanges {target: startScene; visible: true}
            PropertyChanges {target: gameWindow; activeScene: startScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; visible: true}
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        },
        State {
            name: "night"
            PropertyChanges {target: nightScene; visible: true}
            PropertyChanges {target: gameWindow; activeScene: nightScene}
        },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; visible: true}
            PropertyChanges {target: gameWindow; activeScene: creditsScene}
        }

    ]

    function resetGame() {
        progress=1
        score=0
        miss=0
        comboCount=0
        currentDay=1
        gameEnding=false

    }





}
