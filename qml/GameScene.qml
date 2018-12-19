import VPlay 2.0
import QtQuick 2.0


Scene {

    id: gameScene
    visible: false
    enabled: visible

    width: 480
    height: 320

    property bool gameRunning: false
    property alias startButton: startButton

    property alias clickBubbleSound: clickBubbleSound
    property alias missBubbleSound: missBubbleSound
    property alias redBullSound: redBullSound
    property alias comboSound: comboSound
    property alias startDaySound: startDaySound
    property alias endDaySound: endDaySound

    property int bubbleSize: 60
    property int fallSpeed: 1
    property int spawnInt: 500
    property int clickAreaSize: 50
    property int redBullSpawnInt: 5000

    property int startEnergy: 100
    property int startMotivation: 100

    property int maxEnergy: 100
    property int maxMotivation: 100

    property int motivationPenalityPerMiss: 20
    property int energyConPerClick: 2




    property int energy: startEnergy
    property int motivation: startMotivation

    property int combo: 20
    property int hitCount: 0

    SoundEffectVPlay {id:clickBubbleSound; source:"../assets/sounds/320655__rhodesmas__level-up-01.wav"}
    SoundEffectVPlay {id:missBubbleSound; source:"../assets/sounds/WINDOWS_XP_ERROR_SOUND.wav"}
    SoundEffectVPlay {id:redBullSound; source:"../assets/sounds/Soda-can-opening-sound-effect.wav"}
    SoundEffectVPlay {id:comboSound; source:"../assets/sounds/Wombo_Combo_Sound_Effect.wav"}
    SoundEffectVPlay {id:startDaySound; source:"../assets/sounds/Microsoft_Windows_XP_Startup_Sound.wav"}
    SoundEffectVPlay {id:endDaySound; source:"../assets/sounds/Microsoft_Windows_XP_Shutdown_Sound.wav"}


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

    //Area where the code bubbles are clickable
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

    //Button to start the game
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

    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    //gravity for code bubbles so they can fall down
    PhysicsWorld { gravity.y: gameScene.fallSpeed; z: 1 }

    //code bubbles will spawn at given interval
    Timer {
        id: spawnBubble
        interval: gameScene.spawnInt
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            entityManager.createEntityFromUrl(Qt.resolvedUrl("CodeBubble.qml"))
        }
    }

    Timer {
        id: spawnRedBull
        interval: gameScene.redBullSpawnInt
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            //there is only a 50% chance that a red bull can will spawn
            var rand=utils.generateRandomValueBetween(0,10)
            if(rand>=5)
            {
                entityManager.createEntityFromUrl(Qt.resolvedUrl("RedBullCan.qml"))
            }
        }
    }

    Timer {
        id: gameTimer
        running: parent.gameRunning
        repeat: true
        onTriggered: {
            gameScene.checkGameOver()

        }
    }

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

    function checkGameOver() {
        if(gameScene.energy<=0||gameScene.motivation<=0||gameWindow.progress>=gameWindow.maxProgress) {
            entityManager.removeAllEntities()
            gameScene.energy=gameScene.startEnergy
            gameScene.motivation=gameScene.startMotivation
            comboReset(false)
            gameScene.gameRunning=false
            gameScene.startButton.visible=true
            gameScene.endDaySound.play()

            if(gameWindow.currentDay<gameWindow.daysLeft&&gameWindow.progress<gameWindow.maxProgress) {
                gameWindow.currentDay++
                gameWindow.state="night"
            }
            else {
                creditsScene.generateResultText()
                gameWindow.resetGame()
                gameWindow.state="credits"
            }


        }
    }

    function gainEnergy(energyValue) {
        if(gameScene.energy<=(maxEnergy-energyValue))
        {
            gameScene.energy+=energyValue
        }
        else
        {
            gameScene.energy=gameScene.maxEnergy
        }

    }

    function gainMotivation(motivationValue) {
        if(gameScene.motivation<=(maxMotivation-motivationValue))
        {
            gameScene.motivation+=motivationValue
        }
        else
        {
            gameScene.motivation=gameScene.maxMotivation
        }

    }

    //param is bool
    function comboReset(comboSuccess) {
        if(comboSuccess)
        {
            comboSound.play()
            gainEnergy(10)
            gainMotivation(20)
            gameWindow.comboCount++
        }
        gameScene.hitCount=0


    }


}
