#ifndef CALCULATOR_H
#define CALCULATOR_H
#include<QObject>
#include<stdio.h>
#include<string>


class Calculator: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString display READ display WRITE setDisplay NOTIFY displayChanged)

signals:
    void displayChanged();

public slots:
    void buttonClick(QString click);

private:
    float actaulResult = 0;
    float actualMemory = 0;
    char myOperator= '=';
    bool isOperator = false;
    bool isNull =true;
    bool isDot = false;
    QString myDisplay = "0";
    QString display(){ return myDisplay == 'N' ? "0" : myDisplay; }
    void setDisplay(QString value);
    float Calculate(char op, float a, float b);
    float Calculate(std::string function, float a);
    bool emptyDisplay = true;

};
#endif // CALCULATOR_H
