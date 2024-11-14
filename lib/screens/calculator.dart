import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _output = '';

  Widget _buildButton(
    String label, {
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onPressed,
  }) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Material(
        color: backgroundColor ?? Colors.blue[600],
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                color: textColor ?? Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onButtonClick(String value) {
    setState(() {
      _input += value;
      _output = _evaluateExpression(_input).toString();
    });
  }

  void _clear() {
    setState(() {
      _input = '';
      _output = '';
    });
  }

  void _backspace() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
        _output = _evaluateExpression(_input).toString();
      }
    });
  }

  double _evaluateExpression(String expression) {
    try {
      Parser p = Parser();
      Expression exp =
          p.parse(expression.replaceAll('×', '*').replaceAll('÷', '/'));
      ContextModel cm = ContextModel();
      return exp.evaluate(EvaluationType.REAL, cm);
    } catch (e) {
      return double.nan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.blue[100]!],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(24),
                alignment: Alignment.bottomRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _input,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _output,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                    children: [
                      _buildButton('7', onPressed: () => _onButtonClick('7')),
                      _buildButton('8', onPressed: () => _onButtonClick('8')),
                      _buildButton('9', onPressed: () => _onButtonClick('9')),
                      _buildButton('÷',
                          backgroundColor: Colors.orange[600],
                          onPressed: () => _onButtonClick('÷')),
                      _buildButton('4', onPressed: () => _onButtonClick('4')),
                      _buildButton('5', onPressed: () => _onButtonClick('5')),
                      _buildButton('6', onPressed: () => _onButtonClick('6')),
                      _buildButton('×',
                          backgroundColor: Colors.orange[600],
                          onPressed: () => _onButtonClick('×')),
                      _buildButton('1', onPressed: () => _onButtonClick('1')),
                      _buildButton('2', onPressed: () => _onButtonClick('2')),
                      _buildButton('3', onPressed: () => _onButtonClick('3')),
                      _buildButton('-',
                          backgroundColor: Colors.orange[600],
                          onPressed: () => _onButtonClick('-')),
                      _buildButton('⌫',
                          backgroundColor: Colors.orange[600],
                          onPressed: _backspace),
                      _buildButton('0', onPressed: () => _onButtonClick('0')),
                      _buildButton('C',
                          backgroundColor: Colors.red[400], onPressed: _clear),
                      _buildButton('+',
                          backgroundColor: Colors.orange[600],
                          onPressed: () => _onButtonClick('+')),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
