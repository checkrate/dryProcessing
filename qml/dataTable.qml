import QtQuick 2.15
import QtQuick.Controls 1.4 as C1

C1.TableView{
    model: data
    C1.TableViewColumn{
        role: "name"
        title: "Name"
        width: 100
    }
}