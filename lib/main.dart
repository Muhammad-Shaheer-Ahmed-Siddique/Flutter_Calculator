import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TodoApp",
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.purple,
        brightness: Brightness.dark,
      ),

      themeMode: ThemeMode.system,
      home: DashBoardScreen(),
    );
  }
}

class DashBoardScreen extends StatefulWidget {
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String expression = '';
  String result = '';

  void onButtonTap(String value) {
    setState(() {
      if (value == 'AC') {
        expression = '';
        result = '';
      } else if (value == '⌫') {
        if (expression.isNotEmpty) {
          expression = expression.substring(0, expression.length - 1);
        }
      } else if (value == '=') {
        calculate();
      } else {
        expression += value;
      }
    });
  }

  void calculate() {
    try {
      String exp = expression.replaceAll('×', '*').replaceAll('÷', '/');

      result = _eval(exp).toString();
    } catch (e) {
      result = 'Error';
    }
  }

  double _eval(String exp) {
    List<String> tokens = RegExp(
      r'(\d+(\.\d+)?)|[+\-*/]',
    ).allMatches(exp).map((e) => e.group(0)!).toList();

    double total = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      double next = double.parse(tokens[i + 1]);
      switch (tokens[i]) {
        case '+':
          total += next;
          break;
        case '-':
          total -= next;
          break;
        case '*':
          total *= next;
          break;
        case '/':
          total /= next;
          break;
      }
    }
    return total;
  }

  Widget buildButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onButtonTap(text),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.tealAccent,
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 22, color: Colors.purple),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(-1.0, -0.5),
            end: const Alignment(1.0, 1.0),
            colors: [
              Color(0xFFFF9A8B),
              Color(0xFFFFC371),
              Color(0xFFB14FE5),
              Color(0xFF5EDFFF),
            ],
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  expression.isEmpty ? '0' : expression,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 38, color: Colors.white70),
                ),
              ),
            ),

            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  result,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const Spacer(),

            GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: [
                buildButton('AC'),
                buildButton('⌫'),
                buildButton('÷'),
                buildButton('×'),

                buildButton('7'),
                buildButton('8'),
                buildButton('9'),
                buildButton('-'),

                buildButton('4'),
                buildButton('5'),
                buildButton('6'),
                buildButton('+'),

                buildButton('1'),
                buildButton('2'),
                buildButton('3'),
                buildButton('='),

                buildButton('0'),
                buildButton('.'),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
