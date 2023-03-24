import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Dialogs
import QtMultimedia
import QtQuick.Layouts 2.1
Window{

    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Video Player")
    property int mediaPlayerState: mediaPlayer.playbackState
   ColumnLayout{
       spacing: 6
    MediaPlayer {
        id: mediaPlayer
        videoOutput: videoOutput
        Layout.bottomMargin:10
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
         //anchors.margins: 20
    }

    FileDialog{
        id: fileDialog
        title: qsTr("Select Video File")
        nameFilters: ["Video Files (*.avi *.mp4 *.mkv)"]

        onAccepted: {
            mediaPlayer.stop()
            mediaPlayer.source = fileDialog.selectedFile
            mediaPlayer.play()

        }

    }


    //slider

  RowLayout{
Layout.topMargin:50
 spacing: 4
    Layout.alignment: Qt.AlignCenter
//selectfile

       Rectangle {
           width: 100;
           height: 20;

           color: "grey"
         Text{
          text:"select file"
         }

           MouseArea {
               anchors.fill: parent
               onClicked: fileDialog.open()
           }
       }


//button pause
    Rectangle {
        id:pauseButton;
        width: 10;
        height: 20;
        color: "grey"
      Text{
       text: "\u2016";
      }

        MouseArea {
            anchors.fill: parent
            onClicked: mediaPlayer.pause()
        }
    }
   // button player
    Rectangle {
        id: playButton;
        width: 20;
        height: 20;
        color: "grey"
      Text{
       text: "\u25B6";
      }

        MouseArea {
            anchors.fill: parent
            onClicked: mediaPlayer.play()
        }
    }

    State {
                name: "playing"
                when: mediaPlayerState == MediaPlayer.PlayingState
                PropertyChanges { target: pauseButton; visible: true}
                PropertyChanges { target: playButton; visible: false}

            }

            State {
                name: "paused"
                when: mediaPlayerState == MediaPlayer.PausedState
                PropertyChanges { target: pauseButton; visible: false}
                PropertyChanges { target: playButton; visible: true}

            }


   }
   Item {
       id: slider; width: 1300; height: 16

       // value is read/write.

       property int xMax: slider.width - handle.width - 4

       Rectangle {
           anchors.fill: parent
           border.color: "white"; border.width: 0; radius: 8
           gradient: Gradient {
               GradientStop { position: 0.0; color: "#66343434" }
               GradientStop { position: 1.0; color: "#66000000" }
           }
       }

       Rectangle {
           id: handle; smooth: true
           x: slider.width / 2 - handle.width / 2; y: 2; width: 30; height: slider.height-4; radius: 6
           gradient: Gradient {
               GradientStop { position: 0.0; color: "lightgray" }
               GradientStop { position: 1.0; color: "gray" }
           }

           MouseArea {
               anchors.fill: parent; drag.target: parent
               drag.axis: Drag.XAxis; drag.minimumX: 2; drag.maximumX: slider.xMax+2

               enabled: mediaPlayer.seekable

                property real  minimumValue: 0
                property real value: mediaPlayer.position / mediaPlayer.duration


             onPositionChanged : mediaPlayer.setPosition(value * mediaPlayer.duration)
           }
       }
   }


}


}
