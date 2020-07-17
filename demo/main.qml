import QtQuick 2.5
import QtQuick.Window 2.0
import QtScxml 5.8
import QtQuick.Controls 1.4
import com.Calculator 1.0


Window {
    id: window
    visible: true
    property real myWidth: 320
    property real realWidth: isBasic ? width : width * 4 /5
    property bool isBasic: true
    width: myWidth
    height: 480
    Calculator{
        id: calculator

        }
    Rectangle {
        id: resultArea
        anchors.left: calculatorType.right
        width: isBasic ? parent.width / 4 * 3 : realWidth
        anchors.top: parent.top
        height: parent.height * 3 / 8 - 10
        border.color: "white"
        border.width: 1
        color: "#46a2da"
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
    Button {
        id: calculatorType
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width - resultArea.width
        height: resultArea.height
        text: "Change"
        onClicked: {
            if(isBasic === true) {
                myWidth = parent.width * 5 / 4
                isBasic = false
            }
            else {
                myWidth = parent.width /5 *4
                isBasic = true
            }
        }
    }

    Item {
        id: buttons
        anchors.top: resultArea.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom


        Repeater
        {
            id: operations
            model: ["/", "*", "+", "-"]
            Button
            {
                y: 0
                x: index * width
                width: realWidth / 4
                height: parent.height / 5
                text: modelData
                onClicked:
                {
                    calculator.buttonClick(text)
                }
            }
        }
        Repeater {
            id: digits
            model: ["7", "8", "9", "4", "5", "6", "1", "2", "3", "0", ".", "C"]
            Button {
                x: (index % 3) * width
                y: Math.floor(index / 3 + 1) * height
                width: realWidth / 4
                height: parent.height / 5
                text: modelData
                onClicked: {
                    calculator.buttonClick(text)
                    }
                }
            }


        Button {
            id: resultButton
            x: 3 * width
            y: parent.height / 5
            width: realWidth / 4
            height: y * 4
            text: "="
            onClicked: calculator.buttonClick(text);
        }

        Repeater {
            id: advancedButtons
            model: ["exp","log","cos","sin","tan"]
            Button{
                x: realWidth
                y: index * height
                width: parent.width / 5
                height: parent.height / 5
                text: modelData
                onClicked:
                {
                    calculator.buttonClick(text)
                }

            }
        }

    }

        Item{
            focus: true
            Keys.enabled: true
            Keys.onPressed: {
                if(event.key >= 48 && event.key <= 57)
                    calculator.buttonClick(event.key - 48)
            }



    }

}
