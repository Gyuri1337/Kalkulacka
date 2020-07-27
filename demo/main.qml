import QtQuick 2.5
import QtQuick.Window 2.0
import QtScxml 5.8
import QtQuick.Controls 1.4
import com.Calculator 1.0
import QtQuick.Controls.Styles 1.4


Window {
    id: window
    visible: true
    property real myWidth: 320
    property real realWidth: isBasic ? width : width * 4 /5
    property bool isBasic: true
    property int numOfButtonsInAColumn: 6
    property int numOfBlockForResult: 3
    property int verticalBlocksCount: numOfButtonsInAColumn + numOfBlockForResult;
    property int horizontalBlocksCount:5
    property int numOfButtonsInARow: horizontalBlocksCount - 1

    width: myWidth
    height: 480
    Calculator {                                            //////C++ class
        id: calculator

        }
    Repeater{
        id: resultAreaButtons
        model: ["Ch", "MR", "MS"]

        Button{
            x: 0
            y: index * height
            width: parent.width - resultArea.width
            height: parent.height / verticalBlocksCount
            text: modelData
            onClicked: {
                if(modelData === "Ch"){
                    if(isBasic){
                        isBasic = false
                        myWidth = parent.width / numOfButtonsInARow *(numOfButtonsInARow +1)
                        myWidth = parent.width / 4 *5
                    }
                    else{
                        isBasic = true
                        myWidth = parent.width /(numOfButtonsInARow+1) *(numOfButtonsInARow)
                    }
                }
                else{
                    calculator.buttonClick(modelData)
                }
            }
        }

    }
    Rectangle {
        id: resultArea
        anchors.right: parent.right
        width: isBasic ? parent.width / numOfButtonsInARow * (numOfButtonsInARow - 1): realWidth
        anchors.top: parent.top
        height: parent.height * numOfBlockForResult / verticalBlocksCount
        border.color: "white"
        border.width: 1
        color: "#395EC6"

        Text {
            id: resultText
            anchors.fill: parent
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
            text: calculator.display
            color: "white"
            font.pixelSize: window.height * 3 / 32
            font.family: "Open Sans Regular"
            fontSizeMode: Text.Fit
        }
    }





    Item {                                              //////Button part of calculator
        id: buttons
        anchors.top: resultArea.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        property int horizontalCount: 4
        Repeater
        {
            id: memoryButtons
            model: ["M+", "M-", "MS", "MC"]
            Button
            {
                y: 0
                x: index * width
                width: realWidth / buttons.horizontalCount
                height: parent.height / numOfButtonsInAColumn
                text: modelData
                onClicked:
                {
                    calculator.buttonClick(text)
                }
            }
        }

        Repeater
        {
            id: operations
            model: ["/", "*", "+", "-"]
            Button
            {
                y: height
                x: index * width
                width: realWidth / buttons.horizontalCount
                height: parent.height / numOfButtonsInAColumn
                text: modelData
                onClicked:
                {
                    calculator.buttonClick(text)
                }
            }
        }
        Repeater {                                      //////Digits on calculator
            id: digits
            model: ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "C"]
            Button {
                x: (index % 3) * width
                y: Math.floor(index / 3 + 1 ) * height + height
                width: realWidth / buttons.horizontalCount
                height: parent.height / numOfButtonsInAColumn
                text: modelData
                onClicked: {
                    calculator.buttonClick(text)
                    }
                }
            }


        Button {                                        //////Result button
            id: resultButton
            style: ButtonStyle {
                background: Rectangle{
                    color: control.pressed ? "#395EC6" : "#5574CB"
                    border.width: control.activeFocus ? 1 : 2
                    border.color: "#888"
                    radius: 4
                }
            }

            x: 3 * width
            y: parent.height / numOfButtonsInAColumn * 2
            width: realWidth / buttons.horizontalCount
            height: parent.height / numOfButtonsInAColumn * (numOfButtonsInAColumn -2)
            text: "="
            onClicked: calculator.buttonClick(text);
        }

        Repeater {                                      //////Advanced calculator part
            id: advancedButtons
            model: ["exp","log","cos","sin","tan","abs"]
            Button{
                x: realWidth
                y: index * height
                width: parent.width / (numOfButtonsInARow + 1)
                height: parent.height / numOfButtonsInAColumn
                text: modelData
                onClicked:
                {
                    calculator.buttonClick(text)
                }

            }
        }

    }

        Item {                                          //////Item for writing on keyboard
            focus: true
            Keys.enabled: true
            Keys.onPressed: {
                if(event.key >= 48 && event.key <= 57)      //numbers from keyboard
                    calculator.buttonClick(event.key - 48)
                else switch(event.key) {                    //symbols from keyboard
                    case 42: calculator.buttonClick("*"); break;
                    case 43: calculator.buttonClick("+"); break;
                    case 45: calculator.buttonClick("-"); break;
                    case 46: calculator.buttonClick("."); break;
                    case 47: calculator.buttonClick("/"); break;
                    case 61: calculator.buttonClick("="); break;
                }
            }
    }
}
