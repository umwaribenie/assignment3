import 'package:flutter/material.dart';
import 'drawer.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String number1 = "";
  String number2 = "";
  String operand = "";
  String displayText = "";

  @override
  Widget build(BuildContext context) {
    // Determine background color based on current theme mode
    Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;


    return Scaffold(
      drawer: Sidemenu(),
      appBar: AppBar(
        title: Text(
          "Calculator",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Container(
        color: backgroundColor, // Use dynamically determined background color
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  displayText.isEmpty ? "0" : displayText,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 60.0,
                  ),
                ),
              ),
            ),
            buildButtonRow(['C', '( )', '%', '÷'], Colors.blue),
            buildButtonRow(['7', '8', '9', '×'], Colors.black),
            buildButtonRow(['4', '5', '6', '-'], Colors.black),
            buildButtonRow(['1', '2', '3', '+'], Colors.black),
            buildButtonRow(['+/-', '0', '.', '='], Colors.black),
          ],
        ),
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons, Color color) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          return Expanded(
            child: Container(
              margin: EdgeInsets.all(4.0),
              child: TextButton(
                onPressed: () => onBtnTap(buttonText),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Text color in buttons
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // Handle button tap actions
  void onBtnTap(String value) {
    if (value == 'C') {
      clearAll();
    } else if (value == '%') {
      convertToPercentage();
    } else if (value == '=') {
      calculate();
    } else if (value == '+/-') {
      toggleSign();
    } else if (value == '(' || value == ')') {
      handleParentheses(value);
    } else {
      appendValue(value);
    }
  }

  // Perform calculations
  void calculate() {
    if (number1.isEmpty || operand.isEmpty || number2.isEmpty) return;

    final int num1 = int.parse(number1);
    final int num2 = int.parse(number2);

    var result = 0;
    switch (operand) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '×':
        result = num1 * num2;
        break;
      case '÷':
        result = num1 ~/ num2;
        break;
      default:
        return;
    }

    setState(() {
      number1 = result.toStringAsPrecision(3);

      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }

      operand = "";
      number2 = "";
      displayText = number1;
    });
  }

  // Convert to percentage
  void convertToPercentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    final number = int.parse(number1);
    setState(() {
      number1 = "${(number / 100)}";
      operand = "";
      number2 = "";
      displayText = number1;
    });
  }

  // Clear all
  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
      displayText = "";
    });
  }

  // Append value to the appropriate number variable
  void appendValue(String value) {
    if (value != '.' && int.tryParse(value) == null) {
      if (operand.isNotEmpty && number2.isNotEmpty) {
        calculate();
      }
      operand = value;
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == '.' && number1.contains('.')) return;
      if (value == '.' && (number1.isEmpty || number1 == '0')) {
        value = "0.";
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == '.' && number2.contains('.')) return;
      if (value == '.' && (number2.isEmpty || number2 == '0')) {
        value = "0.";
      }
      number2 += value;
    }

    setState(() {
      displayText = "$number1$operand$number2";
    });
  }

  // Handle parentheses
  void handleParentheses(String value) {
    // Example implementation for parentheses handling
    if (value == '(') {
      appendValue('(');
    } else if (value == ')') {
      if (operand.isEmpty || number2.isEmpty) return; // No closing parenthesis without operation and second number
      appendValue(')');
    }

    setState(() {
      displayText = "$number1$operand$number2";
    });
  }

  // Toggle sign
  void toggleSign() {
    if (number2.isNotEmpty) {
      // Toggle sign of number2
      setState(() {
        if (number2.startsWith('-')) {
          number2 = number2.substring(1);
        } else {
          number2 = "-$number2";
        }
        displayText = "$number1$operand$number2";
      });
    } else if (number1.isNotEmpty) {
      // Toggle sign of number1
      setState(() {
        if (number1.startsWith('-')) {
          number1 = number1.substring(1);
        } else {
          number1 = "-$number1";
        }
        displayText = "$number1$operand$number2";
      });
    }
  }
}
