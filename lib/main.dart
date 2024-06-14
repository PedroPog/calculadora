import 'package:flutter/material.dart';

void main() {
  runApp(Calculadora());
}

class Calculadora extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, // Color for all buttons
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  String display = "";

  buttonPressed(String buttonText) {
    if (buttonText == "CLEAR") {
      _output = "0";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      display = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "x") {
      num1 = double.parse(_output.replaceAll(',', '.'));
      operand = buttonText;
      _output = "0";
      display = num1.toString().replaceAll('.', ',') + " " + operand;
    } else if (buttonText == "." || buttonText == ",") {
      if (_output.contains(".") || _output.contains(",")) {
        print("Já contém um ponto ou vírgula");
        return;
      } else {
        _output = _output + (buttonText == "." ? "." : ",");
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output.replaceAll(',', '.'));

      if (operand == "+") {
        _output = (num1 + num2).toString();
      }
      if (operand == "-") {
        _output = (num1 - num2).toString();
      }
      if (operand == "x") {
        _output = (num1 * num2).toString();
      }
      if (operand == "/") {
        _output = (num1 / num2).toString();
      }

      display = num1.toString().replaceAll('.', ',') + " " + operand + " " + num2.toString().replaceAll('.', ',') + " = " + _output.replaceAll('.', ',');

      num1 = 0.0;
      num2 = 0.0;
      operand = "";
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    print(_output);

    setState(() {
      output = _output.replaceAll('.', ',');
    });
  }

  Widget buildButton(String buttonText, {Color color = Colors.white}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: color,
            textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.all(24.0),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora"),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                display,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(
                vertical: 24.0,
                horizontal: 12.0,
              ),
              child: Text(
                output,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Divider(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    buildButton("7", color: Colors.blueGrey),
                    buildButton("8", color: Colors.blueGrey),
                    buildButton("9", color: Colors.blueGrey),
                    buildButton("/", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("4", color: Colors.blueGrey),
                    buildButton("5", color: Colors.blueGrey),
                    buildButton("6", color: Colors.blueGrey),
                    buildButton("x", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("1", color: Colors.blueGrey),
                    buildButton("2", color: Colors.blueGrey),
                    buildButton("3", color: Colors.blueGrey),
                    buildButton("-", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton(".", color: Colors.blueGrey),
                    buildButton("0", color: Colors.blueGrey),
                    buildButton(",", color: Colors.blueGrey),
                    buildButton("+", color: Colors.orange),
                  ],
                ),
                Row(
                  children: [
                    buildButton("CLEAR", color: Colors.redAccent),
                    buildButton("=", color: Colors.green),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
