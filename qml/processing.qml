import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml 2.15

Window{
    id: rootProcessing
    width: 1024
    height: 720
    visible: true
    color: "#17939b"

    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    ListView {
        anchors.fill: parent
        model: JSON.parse(tableData.getTableData())
        delegate: Rectangle {
            width: 100
            height: 50
            color: "lightblue"
            border.color: "black"
            Text {
                text: model.name
                anchors.centerIn: parent
            }
        }
    }
}