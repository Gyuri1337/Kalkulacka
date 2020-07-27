#include "calculator.h"
#include <QObject>
#include <stdio.h>
#include <string>
#include <math.h>

void Calculator::buttonClick(QString value) {
  if(value.count()==2){
      if(value.toStdString()[1]== 'R'){
          myDisplay = QString::fromStdString(std::to_string(actualMemory));
          isOperator=false;
      }
      else{
      actaulResult = Calculate(myOperator, actaulResult,
                                std::stof(myDisplay.toStdString()));
      switch(value.toStdString()[1])
      {
        case'+': actualMemory += actaulResult; break;
        case'-': actualMemory -= actaulResult; break;
        case'C': actualMemory = 0; break;
        case'S': actualMemory = actaulResult; break;
      }
      myDisplay = QString::fromStdString(std::to_string(actaulResult));
      myOperator = '=';
      isOperator = true;
      }
  }
  else if (value.count() == 1) {

    if ((value[0] <= 57 && value[0] >= 48))                                                // if its a NUMBER or a DOT
    {
      if (isOperator) {
        if (myOperator == '=') {  // New equaliton started
          actaulResult = 0;       // Delete the actual result after new eq started....
        }
        myDisplay = value[0];
        isOperator = false;
      } else {                    //Writing digits on display

         if(isNull)
         {
             if(!(value[0]== '0')){
                 myDisplay = value[0];
                isNull = false;
             }

         }
         else {
             myDisplay = myDisplay + value[0];
         }

      }
    }
    else if(value[0] == '.'){
        if (isOperator) {
          if (myOperator == '=') {  // New equaliton started
            actaulResult = 0;       // Delete the actual result after new eq started....
          }
          myDisplay = "0";
          myDisplay = myDisplay + value[0];
          isDot = true;
          isOperator = false;
        }

        else if(!isDot)
        {
            myDisplay = myDisplay + value[0];
            isDot = true;
            isNull = false;
        }
    }

    else if (value[0] == 'C') {                                        // if Clearing the calculation
      myDisplay = "0";
      isNull = true;
      isDot = false;
      actaulResult = 0;
      myOperator = '=';
    }

    else if (value == "=") {                                         // if operator is equals
      actaulResult = Calculate(myOperator, actaulResult,
                                std::stof(myDisplay.toStdString()));
      myDisplay = QString::fromStdString(std::to_string(actaulResult));
      myOperator = '=';
      isDot = false;
      isOperator = true;
    }
    else if (!isOperator) {                                             // if its a operand
      actaulResult = Calculate(myOperator, actaulResult,std::stof(myDisplay.toStdString()));
      myDisplay = QString::fromStdString(std::to_string(actaulResult));
      myOperator = value.toStdString()[0];
      isOperator = true;
      isDot = false;
    }
    else {
      myOperator = value.toStdString()[0];
    }
  }
  else {

          if(std::isnan(actaulResult)){
              actaulResult = Calculate(myOperator,actaulResult, Calculate(std::to_string(actaulResult),std::stof(myDisplay.toStdString()) ));
              myDisplay = QString::fromStdString(std::to_string(actaulResult));
          }
          else {
              actaulResult = Calculate(myOperator,actaulResult, Calculate(value.toStdString(),std::stof(myDisplay.toStdString()) ));
              myDisplay = QString::fromStdString(std::to_string(actaulResult));
          }
      }


  displayChanged();
}

void Calculator::setDisplay(QString value) { myDisplay = value; }

float Calculator::Calculate(std::string myFunction, float num) {
    if(myFunction == "sin") {
        return std::sin(num);
    }
    else if (myFunction == "cos") {
        return std::cos(num);
    }
    else if (myFunction == "tan") {
        return std::tan(num);
    }
    else if (myFunction == "exp") {
        return std::exp(num);
    }
    else if (myFunction == "log") {
        return std::log(num);
    }
    else if (myFunction == "abs") {
        return std::abs(num);
    }
}

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
