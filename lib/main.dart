import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalculatorApp',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      home: CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String _output = "0";  // Displayed result
  String _currentNumber = ""; // Stores the current number being entered
  String _operand = ""; // Stores the selected operator
  double _num1 = 0;  // First operand
  double _num2 = 0;  // Second operand

  // Function to handle button presses
  void _buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        _clear();
      } else if (value == "+" || value == "-" || value == "*" || value == "/") {
        _operand = value;
        _num1 = double.parse(_currentNumber);
        _currentNumber = "";  // Reset for the second operand
      } else if (value == "=") {
        _num2 = double.parse(_currentNumber);
        _calculate();
      } else {
        _currentNumber += value;
        _output = _currentNumber;  // Update display
      }
    });
  }

  // Function to calculate the result based on the selected operator
  void _calculate() {
    double result;
    switch (_operand) {
      case "+":
        result = _num1 + _num2;
        break;
      case "-":
        result = _num1 - _num2;
        break;
      case "*":
        result = _num1 * _num2;
        break;
      case "/":
        result = _num2 != 0 ? _num1 / _num2 : double.nan; // Handle divide by zero
        break;
      default:
        result = 0;
    }
    _output = result.toString();
    _currentNumber = "";  // Reset the current number
  }

  // Function to clear/reset the calculator
  void _clear() {
    _output = "0";
    _currentNumber = "";
    _num1 = 0;
    _num2 = 0;
    _operand = "";
  }

  // Widget for calculator buttons with color themes
  Widget _buildButton(String value, {Color backgroundColor = const Color.fromARGB(210, 117, 113, 113), Color textColor = Colors.white}) {
    return Expanded(
      child: InkWell(
        onTap: () => _buttonPressed(value),
        child: Container(
          margin: EdgeInsets.all(10),
          height: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 28, color: textColor, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              color: Colors.black,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  _buildButton("7"),
                  _buildButton("8"),
                  _buildButton("9"),
                  _buildButton("/", backgroundColor: Colors.orange, textColor: Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton("4"),
                  _buildButton("5"),
                  _buildButton("6"),
                  _buildButton("*", backgroundColor: Colors.orange, textColor: Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton("1"),
                  _buildButton("2"),
                  _buildButton("3"),
                  _buildButton("-", backgroundColor: Colors.orange, textColor: Colors.white),
                ],
              ),
              Row(
                children: [
                  _buildButton("0"),
                  _buildButton("C", backgroundColor: Colors.grey[600]!),
                  _buildButton("=", backgroundColor: Colors.orange, textColor: Colors.white),
                  _buildButton("+", backgroundColor: Colors.orange, textColor: Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
