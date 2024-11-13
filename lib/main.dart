import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlue[50], 
        body: const Calculator(),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _displayText = '0';
  double? _firstNumber;
  String? _operation;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _displayText = '0';
        _firstNumber = null;
        _operation = null;
      } else if (value == '=') {
        if (_firstNumber != null && _operation != null) {
          double secondNumber = double.tryParse(_displayText) ?? 0;
          switch (_operation) {
            case '+':
              _displayText = (_firstNumber! + secondNumber).toString();
              break;
            case '-':
              _displayText = (_firstNumber! - secondNumber).toString();
              break;
            case 'x':
              _displayText = (_firstNumber! * secondNumber).toString();
              break;
            case '/':
              _displayText = secondNumber != 0
                  ? (_firstNumber! / secondNumber).toString()
                  : 'Error';
              break;
          }
          _firstNumber = null;
          _operation = null;
        }
      } else if (value == '+' || value == '-' || value == 'x' || value == '/') {
        _firstNumber = double.tryParse(_displayText);
        _operation = value;
        _displayText = '$_firstNumber $value';
      } else {
        if (_displayText == '0' || (_operation != null && _displayText == '$_firstNumber $_operation')) {
          _displayText = value;
        } else {
          _displayText += value;
        }
      }
    });
  }

  Widget _buildButton(String label, Color color, Color textColor) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ElevatedButton(
          onPressed: () => _onButtonPressed(label),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 28, color: textColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            "Alejandro Ortiz",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text(
            _displayText,
            style: const TextStyle(
              fontSize: 36,
              color: Colors.black87, 
            ),
          ),
        ),
        const Divider(color: Colors.grey),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  _buildButton('7', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('8', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('9', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('/', Colors.teal[300]!, Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton('4', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('5', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('6', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('x', Colors.teal[300]!, Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton('1', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('2', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('3', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('-', Colors.teal[300]!, Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton('0', Colors.lightGreen[100]!, Colors.black),
                  _buildButton('C', Colors.blueGrey[200]!, Colors.black),
                  _buildButton('=', Colors.teal[300]!, Colors.white),
                  _buildButton('+', Colors.teal[300]!, Colors.white),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}