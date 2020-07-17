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
    float actaulResult = NAN;
    char myOperator;
    QString myDisplay = "0";
    QString display(){ return myDisplay; }
    void setDisplay(QString value);
    float Calculate(char op, float a, float b);
    bool isOperator = false;
    bool emptyDisplay = true;

};
#endif // CALCULATOR_H
