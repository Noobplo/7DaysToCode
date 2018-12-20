import VPlay 2.0
import QtQuick 2.0


Scene {

    //every scene has a opacity of 0 by default and is not visible
    id: gameScene
    opacity: 0
    visible: opacity > 0
    enabled: visible

    //game is not running by default
    property bool gameRunning: false
    //game will run as soon the start button is clicked
    property alias startButton: startButton

    //game soundeffects
    property alias clickBubbleSound: clickBubbleSound
    property alias missBubbleSound: missBubbleSound
    property alias redBullSound: redBullSound
    property alias comboSound: comboSound
    property alias startDaySound: startDaySound
    property alias endDaySound: endDaySound
    property alias redBullSpawnSound: redBullSpawnSound

    //size of the code pieces
    property int bubbleSize: 60
    //how fast the code pieces will fall
    property int fallSpeed: 1
    //spawn interval of code pieces
    property int spawnInt: 500
    //height of the border where code pieces can be clicked
    property int clickAreaSize: 50
    //spawn interval of red bull cans
    property int redBullSpawnInt: 5000

    //starting value of energy and motivation on each day
    property int startEnergy: 100
    property int startMotivation: 100

    //the max value of energy and motivation
    property int maxEnergy: 100
    property int maxMotivation: 100

    //motivation reduction per missed code piece
    property int motivationPenalityPerMiss: 20
    //energy consumption per clicked code piece
    property int energyConPerClick: 2

    //current energy and motivation
    property int energy: startEnergy
    property int motivation: startMotivation

    //clicks in a row without miss to trigger combo
    property int combo: 20
    //current clicks in a row without miss
    property int hitCount: 0

    //game soundeffects links
    SoundEffectVPlay {id:clickBubbleSound; source:"../assets/sounds/320655__rhodesmas__level-up-01.wav"}
    SoundEffectVPlay {id:missBubbleSound; source:"../assets/sounds/WINDOWS_XP_ERROR_SOUND.wav"}
    SoundEffectVPlay {id:redBullSound; source:"../assets/sounds/Soda-can-opening-sound-effect.wav"}
    SoundEffectVPlay {id:comboSound; source:"../assets/sounds/Wombo_Combo_Sound_Effect.wav"}
    SoundEffectVPlay {id:startDaySound; source:"../assets/sounds/Microsoft_Windows_XP_Startup_Sound.wav"}
    SoundEffectVPlay {id:endDaySound; source:"../assets/sounds/Microsoft_Windows_XP_Shutdown_Sound.wav"}
    SoundEffectVPlay {id:redBullSpawnSound; source:"../assets/sounds/411639__inspectorj__pop-low-a-h1.wav"}

    //background
    Rectangle {
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        MultiResolutionImage {
            id: backgroundImage

            width: parent.width
            height: parent.height
            source: "../assets/images/windows-xp_pixelBackground.jpg"
        }
    }

    //HUD
    MultiResolutionImage {
        width: parent.gameWindowAnchorItem.width
        anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
        anchors.top: parent.gameWindowAnchorItem.top
        height: 50
        //HUD is always on the front
        z: 3
        Row {
            id: hud
            anchors.horizontalCenter: parent.Center
            x: 10
            spacing: 5
            Column {
                y: 4
                Text {
                    text: "Progress: "+Math.round(gameWindow.progress)+"%"
                    color: "lightgreen"
                    font.pixelSize: 11
                    font.family: gameWindow.pixelFont.name
                }
                Text {
                    text: "Energy: "+gameScene.energy+"%"
                    color: "yellow"
                    font.pixelSize: 11
                    font.family: gameWindow.pixelFont.name
                }
                Text {
                    text: "Motivation: "+gameScene.motivation+"%"
                    color: "purple"
                    font.pixelSize: 11
                    font.family: gameWindow.pixelFont.name
                }
            }
            Column {
                y: 4
                spacing: 5
                Rectangle {
                    width: (350*gameWindow.progress)/100
                    height: 10
                    color: "lightgreen"
                }
                Rectangle {
                    width: (350*gameScene.energy)/100
                    height: 10
                    color: "yellow"
                }
                Rectangle {
                    width: (350*gameScene.motivation)/100
                    height: 10
                    color: "purple"
                }
            }
        }
        source: "../assets/images/pixelXPBorder"
    }

    //Area where the code pieces are clickable
    Rectangle {
        id: clickableArea
        width: parent.gameWindowAnchorItem.width
        height: gameScene.clickAreaSize
        anchors.horizontalCenter: parent.gameWindowAnchorItem.horizontalCenter
        y: parent.gameWindowAnchorItem.height*0.7
        color: "black"
        opacity: 0.5
        border.color: "cyan"
        border.width: 2

        BoxCollider {
            categories: Box.Category2
            collisionTestingOnlyMode: true
            anchors.fill: parent
        }
    }

    //Button to start the game, will be disabled after clicking
    MultiResolutionImage {
        id: startButton
        width: 100
        height: 50
        anchors.centerIn: parent
        enabled: visible

        Text {
            text: "Start Day "+gameWindow.currentDay
            color: "black"
            anchors.centerIn: parent
            font.family: gameWindow.pixelFont.name
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                gameScene.startDaySound.play()
                gameScene.gameRunning=true
                parent.visible=false

            }
        }
        source: "../assets/images/pixelBorder"
    }
    // used to create code pieces and red bull cans at runtime
    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    //gravity for code pieces so they can fall down
    PhysicsWorld { gravity.y: gameScene.fallSpeed; z: 1 }

    //code pieces will spawn at given interval
    Timer {
        id: spawnBubble
        interval: gameScene.spawnInt
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("CodeBubble.qml"))
        }
    }

    //red bull cans will spawn at given interval
    Timer {
        id: spawnRedBull
        interval: gameScene.redBullSpawnInt
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            //there is only a 50% chance that a red bull can will spawn
            var rand=utils.generateRandomValueBetween(0,10)
            if(rand>=5) {
                gameScene.redBullSpawnSound.play()
                entityManager.createEntityFromUrl(Qt.resolvedUrl("RedBullCan.qml"))
            }
        }
    }

    //Listener for game over
    Timer {
        id: gameTimer
        interval: 1
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            gameScene.checkGameOver()
        }
    }

    //death zone: code pieces will be removed when they hit this area, it is located below the game window
    Rectangle {
        id: deathZone
        width: parent.gameWindowAnchorItem.width
        height: 10
        color: "red"
        anchors.top: parent.gameWindowAnchorItem.bottom

        BoxCollider {
            categories: Box.Category1
            collisionTestingOnlyMode: true
            anchors.fill: parent
        }
    }

    //skip to night scene if energy/motivation hits 0 or skip to credits scene if the last day passed or progress hits 100%
    function checkGameOver() {
        if(gameScene.energy<=0||gameScene.motivation<=0||gameWindow.progress>=gameWindow.maxProgress) {
            entityManager.removeAllEntities()
            comboReset(false)
            gameScene.gameRunning=false
            gameScene.startButton.visible=true
            if(gameWindow.currentDay<gameWindow.daysLeft&&gameWindow.progress<gameWindow.maxProgress) {
                gameWindow.currentDay++
                gameWindow.state="night"
                gameScene.endDaySound.play()
                nightScene.getRandomEvent()
            }
            else {
                creditsScene.generateResultText()
                gameWindow.resetGame()
                gameWindow.state="credits"
            }
            gameScene.energy=gameScene.startEnergy
            gameScene.motivation=gameScene.startMotivation
        }
    }

    //function to increase energy
    function gainEnergy(energyValue) {
        if(gameScene.energy<=(maxEnergy-energyValue)) {
            gameScene.energy+=energyValue
        }
        else {
            gameScene.energy=gameScene.maxEnergy
        }
    }

    //function to increase motivation
    function gainMotivation(motivationValue) {
        if(gameScene.motivation<=(maxMotivation-motivationValue)) {
            gameScene.motivation+=motivationValue
        }
        else {
            gameScene.motivation=gameScene.maxMotivation
        }
    }

    //param is bool, clicks in a row will be reseted if a click piece is missed or combo triggered
    //combo increases energy and motivation
    function comboReset(comboSuccess) {
        if(comboSuccess) {
            comboSound.play()
            gainEnergy(10)
            gainMotivation(20)
            gameWindow.comboCount++
        }
        gameScene.hitCount=0
    }

    //reset all game settings to the original value
    function resetGameSettings() {
        gameScene.bubbleSize= 60
        gameScene.fallSpeed= 1
        gameScene.spawnInt= 500
        gameScene.clickAreaSize= 50
        gameScene.redBullSpawnInt= 5000
        gameScene.startEnergy= 100
        gameScene.startMotivation= 100

    }
}
