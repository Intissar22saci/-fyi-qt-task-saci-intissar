


import QtQuick.Layouts 2.1
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtMultimedia



Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("Video Player")
  property int mediaPlayerState: mediaPlayer.playbackState
 ColumnLayout{

    MediaPlayer {
        id: mediaPlayer
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
    }

    FileDialog{
        id: fileDialog
        title: qsTr("Select Video File")
        nameFilters: ["Video Files (*.avi *.mp4 *.mkv)"]

        onAccepted: {

            mediaPlayer.source = fileDialog.currentFile
            mediaPlayer.play()

        }

    }
    Button {

        text: qsTr("Select Video File")
        anchors.centerIn: parent
        onClicked: fileDialog.open()
    }




   Row{
       Layout.topMargin:100
    Layout.alignment: Qt.AlignCenter


    Button {
                           id: pauseButton

                           text: "\u2016";
                           onClicked: mediaPlayer.pause()
                       }

                       Button {
                           id: playButton

                           text: "\u25B6";
                           onClicked: mediaPlayer.play()
                       }


                       Button {
                                              id: stopButton

                                              text: "\u25A0";
                                              onClicked: mediaPlayer.stop()
                                          }

                       State {
                                   name: "playing"
                                   when: mediaPlayerState == MediaPlayer.PlayingState
                                   PropertyChanges { target: pauseButton; visible: true}
                                   PropertyChanges { target: playButton; visible: false}
                                   PropertyChanges { target: stopButton; visible: true}
                               }
                               State {
                                   name: "stopped"
                                   when: mediaPlayerState == MediaPlayer.StoppedState
                                   PropertyChanges { target: pauseButton; visible: false}
                                   PropertyChanges { target: playButton; visible: true}
                                   PropertyChanges { target: stopButton; visible: false}
                               }
                               State {
                                   name: "paused"
                                   when: mediaPlayerState ==MediaPlayer.PausedState
                                   PropertyChanges { target: pauseButton; visible: false}
                                   PropertyChanges { target: playButton; visible: true}
                                   PropertyChanges { target: stopButton; visible: true}
                               }

}
   Text {
              id: mediaTime
              Layout.minimumWidth: 100
              Layout.minimumHeight: 50
              horizontalAlignment: Text.AlignRight
              text: {
                  var m = Math.floor(mediaPlayer.position / 60000)
                  var ms = (mediaPlayer.position / 1000 - m * 60).toFixed(1)
                  return `${m}:${ms.padStart(4, 0)}`
              }
          }
   Slider {
             id: mediaSlider
             Layout.fillWidth: true
             enabled: mediaPlayer.seekable
             //to: 1.0
             value: mediaPlayer.position / mediaPlayer.duration

             onMoved: mediaPlayer.setPosition(value * mediaPlayer.duration)
         }
}}

