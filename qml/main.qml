import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml 2.15


Window{
    id: root
    width: 1024
    height: 720
    visible: true
    color: "#17939b"

    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    Rectangle {
        width: 614
        height: 432
        anchors.centerIn: parent
        radius: 5
        border.width: 2
        border.color: "black"
        opacity: 0.7

            RowLayout {
                anchors.fill: parent

            ListView {
                id: listTxt
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: [] 
                Layout.alignment: Qt.AlignLeft // Выравнивание по левому краю
                clip: true
                delegate: Text {
                    text: modelData
                    font.pixelSize: 15
                    verticalAlignment: Text.AlignVCenter
                    padding: 3
                }
            }

            ListView {
                id: listCsv
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: [] 
                Layout.alignment: Qt.AlignRight // Выравнивание по правому краю
                clip: true
                delegate: Text {
                    text: modelData
                    font.pixelSize: 15
                    verticalAlignment: Text.AlignVCenter
                    padding: 3
                }
            }
        }
    }


    RowLayout {
    
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 30
        spacing: 60

        FileDialog {
            id: fileDialog
            title: "Select a file"
            selectMultiple: true
            nameFilters: ["Text files (*.txt)", "CSV files (*.csv)"]
            property var selectedCsvFiles: []
            property var selectedTxtFiles: []
            onAccepted:{
                for (var i = 0; i < fileDialog.fileUrls.length; i++) {
                    if(fileDialog.fileUrls[i].toString().indexOf('.csv') !== -1){
                        selectedCsvFiles.push(fileDialog.fileUrls[i].toString().replace("file:///", ""))
                    }
                    else{
                        selectedTxtFiles.push(fileDialog.fileUrls[i].toString().replace("file:///", ""))
                    }
                }
                listTxt.model = selectedTxtFiles
                listCsv.model = selectedCsvFiles
            }
        }

        Dialog{
            id: testDialog
            title: "Custom Dialog Title"
            standardButtons: Dialog.Ok | Dialog.Cancel
            //implicitWidth: parent.width
            //implicitHeight: parent.height
        }

        Button {
            id: processButton
            text: "Загрузить данные"
            Layout.preferredWidth: 181
            Layout.preferredHeight: 41
            onClicked: fileDialog.open()
            background: Rectangle{
                anchors.fill: parent
                radius: 10
                color: '#23d4ee'
            }
        }

        Button {
            id: startButton
            text: "Начать"
            Layout.preferredWidth: 181
            Layout.preferredHeight: 41
            onClicked:{
                backend.loadTxt(listTxt.model);
                backend.loadCsv(listCsv.model);
            }
            background: Rectangle{
                anchors.fill: parent
                radius: 10
                color: '#23d4ee'
            }
        }
    }
}