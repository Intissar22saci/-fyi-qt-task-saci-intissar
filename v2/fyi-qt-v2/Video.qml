

import QtQuick.Controls 2.0

import QtQuick.Layouts 2.1
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtMultimedia
Item {
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

}
