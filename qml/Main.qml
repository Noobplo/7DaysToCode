import VPlay 2.0
import QtQuick 2.0

GameWindow {
    id: gameWindow

    state: "menu"

    screenWidth: 960
    screenHeight: 640

    property double maxProgress: 100

    //achieve 100% progress to win this game, progress is made by clicking on the codeBubble in gameScene
    property double progress: 0.1

    property int score: 0
    property int miss: 0
    property int comboCount: 0

    //days are tries you have to get your progress to 100%
    property int daysLeft: 7

    property int currentDay: 1

    property alias pixelFont: pixelFont
    FontLoader {
        id: pixelFont
        source: "../assets/arcadeclassic_regular.ttf"
    }

    GameScene {
        id: gameScene
    }

    StartScene {
        id: startScene
        onGamePressed: {gameWindow.state="game"; startScene.bgMusic.stop()}
        onTutorialPressed: {gameWindow.state="tutorial"}
    }

    NightScene {
        id: nightScene
        onGamePressed: gameWindow.state="game"
    }

    CreditsScene {
        id: creditsScene
        onMenuPressed: {gameWindow.state="menu"; startScene.bgMusic.play(); creditsScene.bgMusic.stop()}
    }

    TutorialScene {
        id:tutorialScene
        onMenuPressed: {gameWindow.state="menu"}
    }

    states: [
        State {
            name: "menu"
            PropertyChanges {target: startScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: startScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: gameScene}
        },
        State {
            name: "night"
            PropertyChanges {target: nightScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: nightScene}
        },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: creditsScene}
        },
        State {
            name: "tutorial"
            PropertyChanges {target: tutorialScene; opacity: 1}
            PropertyChanges {target: gameWindow; activeScene: tutorialScene}
        }
    ]

    function resetGame() {
        progress=0.1
        score=0
        miss=0
        comboCount=0
        currentDay=1
        gameScene.resetGameSettings()
    }
}
