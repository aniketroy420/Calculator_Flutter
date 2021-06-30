import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(Calcuroyter());

String equation = '0';
String result = '0';
String expression = '';
double equationFontSize = 38.0;
double resultFontSize = 48.0;
Color numbers = Colors.black38;
Color operations = Colors.deepPurple;
Color other = Colors.redAccent;

class Calcuroyter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CALCUROYTER',
      theme: ThemeData.dark(),
      home: SimpleCalcuroyter(),
    );
  }
}

class SimpleCalcuroyter extends StatefulWidget {
  @override
  _SimpleCalcuroyterState createState() => _SimpleCalcuroyterState();
}

class _SimpleCalcuroyterState extends State<SimpleCalcuroyter> {
  onTap(String buttonText) {
    setState(
      () {
        if (buttonText == 'C') {
          equation = '0';
          result = '0';
          equationFontSize = 38.0;
          resultFontSize = 48.0;
        } else if (buttonText == '⌫') {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          equation = equation.substring(0, equation.length - 1);
          if (equation == '') {
            equation = '0';
          }
        } else if (buttonText == '=') {
          equationFontSize = 38.0;
          resultFontSize = 48.0;

          expression = equation;
          expression = expression.replaceAll('÷', '/');
          expression = expression.replaceAll('×', '*');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);

            ContextModel cm = ContextModel();
            result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          } catch (e) {
            result = 'Error';
          }
        } else {
          equationFontSize = 48.0;
          resultFontSize = 38.0;
          if (equation == '0') {
            equation = buttonText;
          } else {
            equation = equation + buttonText;
          }
        }
      },
    );
  }

  Widget calculatorButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => onTap(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
                color: Colors.white, width: 1, style: BorderStyle.solid),
          ),
          padding: EdgeInsets.all(16.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calcuroyter'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        calculatorButton(
                          'C',
                          1,
                          other,
                        ),
                        calculatorButton(
                          '⌫',
                          1,
                          operations,
                        ),
                        calculatorButton(
                          '÷',
                          1,
                          operations,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calculatorButton(
                          '7',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '8',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '9',
                          1,
                          numbers,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calculatorButton(
                          '4',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '5',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '6',
                          1,
                          numbers,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calculatorButton(
                          '3',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '2',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '1',
                          1,
                          numbers,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calculatorButton(
                          '.',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '0',
                          1,
                          numbers,
                        ),
                        calculatorButton(
                          '00',
                          1,
                          numbers,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        calculatorButton(
                          '×',
                          1,
                          operations,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calculatorButton(
                          '⁻',
                          1,
                          operations,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calculatorButton(
                          '+',
                          1,
                          operations,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        calculatorButton(
                          '=',
                          2,
                          other,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
