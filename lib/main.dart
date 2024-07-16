import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(CalculatorApp());
}
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}
class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}
class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String display = '';
  void onDigitPress(String digit) {
    setState(() {
      display += digit;
    });
  }
  void onClearPress() {
    setState(() {
      display = '';
    });
  }
  void onEqualsPress() {
    try {
      Parser p = Parser();
      Expression exp = p.parse(display);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        display = eval.toString();
      });
    } catch (e) {
      setState(() {
        display = 'Error';
      });
    }
  }
  void onBackspacePress() {
    setState(() {
      if (display.length > 0) {
        display = display.substring(0, display.length - 1);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                onBackspacePress();
              },
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('(', backgroundColor: Colors.orangeAccent),
                _buildButton(')', backgroundColor: Colors.orangeAccent),
                _buildButton('%', backgroundColor: Colors.orangeAccent),
                _buildButton('C', backgroundColor: Colors.red),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('1', backgroundColor: Colors.white),
                _buildButton('2', backgroundColor: Colors.white),
                _buildButton('3', backgroundColor: Colors.white),
                _buildButton('+', backgroundColor: Colors.orangeAccent),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('4', backgroundColor: Colors.white),
                _buildButton('5', backgroundColor: Colors.white),
                _buildButton('6', backgroundColor: Colors.white),
                _buildButton('-', backgroundColor: Colors.orangeAccent),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('7', backgroundColor: Colors.white),
                _buildButton('8', backgroundColor: Colors.white),
                _buildButton('9', backgroundColor: Colors.white),
                _buildButton('*', backgroundColor: Colors.orangeAccent),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _buildButton('.', backgroundColor: Colors.white),
                _buildButton('0', backgroundColor: Colors.white),
                _buildButton('=', backgroundColor: Colors.green),
                _buildButton('/', backgroundColor: Colors.orangeAccent),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, {Color? backgroundColor, Color? textColor}) {
    double buttonSize = 70.0;
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
        ),
        child: TextButton(
          onPressed: () {
            if (text == 'C') {
              onClearPress();
            } else if (text == '=') {
              onEqualsPress();
            } else {
              onDigitPress(text);
            }
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            shape: CircleBorder(),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 24.0, color: textColor ?? Colors.black),
          ),
        ),
      ),
    );
  }
}
