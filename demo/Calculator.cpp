#include "calculator.h"
#include <QObject>
#include <stdio.h>
#include <string>
#include <math.h>

void Calculator::buttonClick(QString value) {
  if (value.count() == 1) {
    if ((value[0] <= 57 && value[0] >= 48) ||
        value[0] == '.')  // if its a number or a dot
    {
      if (isOperator) {
        if (myOperator == '=') {
          actaulResult = NAN;
        }
        myDisplay = value[0];
        isOperator = false;
      } else {
        if (myDisplay[0] == '0')
          myDisplay = value[0];
        else {
          myDisplay = myDisplay + value[0];
        }
      }
    } else if (value[0] == 'C')  // if Clearing the clalculation
    {
      myDisplay = "0";
      actaulResult = NAN;
      myOperator = '=';
    } else if (value[0] == '=')  // if operator is equals
    {
      if (!std::isnan(actaulResult) && !isOperator) {
        actaulResult = Calculate(myOperator, actaulResult,
                                 std::stof(myDisplay.toStdString()));
        myDisplay = QString::fromStdString(std::to_string(actaulResult));
        isOperator = true;
      }
      myOperator = value.toStdString()[0];
    } else if (!isOperator) {  // if its a operand
      if (std::isnan(actaulResult)) {
        actaulResult = std::stof(myDisplay.toStdString());
        myOperator = value.toStdString()[0];
        isOperator = true;
      } else {
        actaulResult = Calculate(myOperator, actaulResult,
                                 std::stof(myDisplay.toStdString()));
        myDisplay = QString::fromStdString(std::to_string(actaulResult));
        myOperator = value.toStdString()[0];
        isOperator = true;
      }

    } else {
      myOperator = value.toStdString()[0];
    }
  }
  displayChanged();
}

void Calculator::setDisplay(QString value) { myDisplay = value; }

float Calculator::Calculate(char op, float a, float b) {
  if (op == '=') {
    return b;
  }
  switch (op) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      return a / b;
    default:
      return a;
  }
}
