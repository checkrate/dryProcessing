import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.3
import QtQuick.Dialogs 1.3
import QtQml 2.15



ApplicationWindow {
    id: mainWindow
    width: 1027
    height: 721
    visible: true
    color: "#17939b"
    
    header: ToolBar{
        background: Rectangle{
            anchors.fill: parent
            color: '#176092'
            }
        RowLayout{
            anchors.fill: parent
            ToolButton{
                text: 'Меню'
                onClicked: {menu.open();}
                width: parent.width / 3
            }/*
            Label{
                text: "ffff"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
                width: parent.width / 3
            }
            ToolButton{
                text: "aaaa"
                onClicked: {stack.pop();}
                width: parent.width / 3
            }*/
        }
    }
    

    StackView{
        id: stack
        anchors.fill: parent
    }

    Menu{
        id: menu

        MenuItem{
            text: "Руководство пользователя"
        }

        MenuItem{
            text: "Справка"
        }

        MenuItem{
            text: "Контакты"
        }
    }

    FileDialog {
        id: fileDialog
        title: "Select a file"
        selectMultiple: true
        nameFilters: ["Text files (*.txt)", "CSV files (*.csv)"]
        currentFolder: StandartPaths.standartLocations(StandartPaths.DocumentsLocation)[0]
        //fileMode: FileDialog.OpenFile
        onAccepted:{
            jsonPath.text = selectedFile.toString().replace("file:///", "")
        }
    }

    Component.onCompleted:{
        for(var ix = 0; ix < 10; ix++){
            fileList.model.append({valText: 'hello' + ix});
        }
    }

    ListModel {
        id: filePathsModel
    }


    RowLayout {
    
    anchors.bottom: parent.bottom
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.margins: 30
    spacing: 60


        Button {
            id: processButton
            text: "Обработать данные"
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
            id: exitButton
            text: "Выйти"
            Layout.preferredWidth: 181
            Layout.preferredHeight: 41
            onClicked: mainWindow.close()
            background: Rectangle{
                anchors.fill: parent
                radius: 10
                color: '#23d4ee'
            }
        }
    }
/*   
    Connections {
    target: signalSender
    onFinished: {
        switch (command) {
            case 'setDataModel':
                view.dataModel = JSValue(arguments[0]).toVariantList()
                break;
        }
    }
}

    TableView {
        id: view

        anchors.margins: 10
        anchors.fill: parent
        model: dataModel
        clip: true

        Column {
            width: 100
            title: "Color"
            role: "color"
        }
        Column {
            width: 100
            title: "Text"
            role: "text"
        }

        itemDelegate: Item {
            Text {
                anchors.centerIn: parent
                renderType: Text.NativeRendering
                text: styleData.value
            }
        }
    }
    
*/
TableView {
    id: tableView
    width: 571   // Фиксированная ширина в пикселях
    height: 331  // Фиксированная высота в пикселях
    anchors.right: parent.right // Правый отступ
    anchors.top: parent.top    // Верхний отступ
    anchors.rightMargin: 30
    anchors.topMargin: 150
    //leftMargin: rowsHeader.implicitWidth
    //topMargin: columnsHeader.implicitHeight
    clip: true // Add this line to enable clipping when content overflows the viewport
    
    columnWidthProvider: function (column) { return 100; }
    rowHeightProvider: function (column) { return 60; }
    model: table_model
    delegate: Rectangle {
        Text {
            text: display
            anchors.fill: parent
            anchors.margins: 10
            color: 'black'
            font.pixelSize: 15
            verticalAlignment: Text.AlignVCenter
        }
    }

    Rectangle { // mask the headers
        z: 3
        color: "#222222"
        y: tableView.contentY
        x: 0 //tableView.contentX
        width: tableView.leftMargin
        height: tableView.topMargin
    }

    Row {
        id: columnsHeader
        y: tableView.contentY
        z: 2
        Repeater {
            model: tableView.columns > 0 ? tableView.columns : 1
            Label {
                width: tableView.columnWidthProvider(modelData)
                height: 35
                text: table_model.headerData(modelData, Qt.Horizontal)
                color: '#aaaaaa'
                font.pixelSize: 15
                padding: 10
                verticalAlignment: Text.AlignVCenter

                background: Rectangle { color: "#333333" }
            }
        }
    }
    Column {
        id: rowsHeader
        x: 0 //tableView.contentX
        z: 2
        Repeater {
            model: tableView.rows > 0 ? tableView.rows : 1
            Label {
                width: 40
                height: tableView.rowHeightProvider(modelData)
                text: table_model.headerData(modelData, Qt.Vertical)
                color: '#aaaaaa'
                font.pixelSize: 15
                padding: 10
                verticalAlignment: Text.AlignVCenter

                background: Rectangle { color: "#333333" }
            }
        }
    }

    Component.onCompleted: {
        flickable.contentWidth = tableView.width
        flickable.contentHeight = tableView.height
    }

    ScrollIndicator.horizontal: ScrollIndicator {}
    ScrollIndicator.vertical: ScrollIndicator {}


Flickable {
    id: flickable
    anchors.fill: parent
    anchors.right: parent.left // Правый отступ для Flickable
    anchors.top: parent.top    // Верхний отступ для Flickable
    //anchors.rightMargin: 10  // Отступ справа для Flickable
    //anchors.topMargin: 10     // Отступ сверху для Flickable
}
}


ListView {
    id: fileList
    model: filePathsModel
    anchors.left: parent.left // Правый отступ
    anchors.top: parent.top    // Верхний отступ
    anchors.leftMargin: 30
    anchors.topMargin: 150
    width: 250
    height: 331
    spacing: 1
    clip: true
    delegate: Rectangle{
        color: "white"
        width: fileList.width
        height: fileList.height / 10
        Text{
            anchors{
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            color: "black"
            font.pointSize: 5
            text: path
        }
    }

}
}
    