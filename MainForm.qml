import QtQuick 2.7
import QtQuick.Controls 1.5
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4
import QtQuick.Controls.Styles 1.4

import fp.system.temperaturesensor 1.0

Item {
    width: 150
    height: 150

    Rectangle {
        Temperatursensor{
            id: ts1
        }
        id: rectangle
        color: "#343434"
        anchors.fill: parent

        CircularGauge {
            id: tempGauge
            anchors.rightMargin: 2
            anchors.bottomMargin: 2
            anchors.leftMargin: 2
            anchors.topMargin: 2
            anchors.fill: parent
            value: ts1.getTemperature

            style: CircularGaugeStyle {
                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                background: Canvas {
                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.reset();

                        ctx.beginPath();
                        ctx.strokeStyle = "#e34c22";
                        ctx.lineWidth = outerRadius * 0.02;

                        ctx.arc(outerRadius, outerRadius, outerRadius - ctx.lineWidth / 2,
                            degreesToRadians(valueToAngle(75) - 90), degreesToRadians(valueToAngle(100) - 90));
                        ctx.stroke();
                    }
                }

                tickmark: Rectangle {
                    visible: styleData.value < 75 || styleData.value % 10 == 0
                    implicitWidth: outerRadius * 0.02
                    antialiasing: true
                    implicitHeight: outerRadius * 0.06
                    color: styleData.value >= 75 ? "#e34c22" : "#999999"
                }

                minorTickmark: Rectangle {
                    visible: styleData.value < 75
                    implicitWidth: outerRadius * 0.01
                    antialiasing: true
                    implicitHeight: outerRadius * 0.03
                    color: "#999999"
                }


                needle: Rectangle {
                    implicitWidth: outerRadius * 0.03
                    implicitHeight: outerRadius * 0.9
                    antialiasing: true
                    color: "#e34c22"
                }
            }

            TextEdit {
                id: textEdit
                x: 280
                y: 135
                width: 80
                height: 15
                color: "#999999"
                text: qsTr("CPU Temp")
                anchors.horizontalCenterOffset: 0
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 10
            }
        }
    }

}
