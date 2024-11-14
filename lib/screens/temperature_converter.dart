import 'package:flutter/material.dart';

class TemperatureConverterScreen extends StatefulWidget {
  @override
  _TemperatureConverterScreenState createState() =>
      _TemperatureConverterScreenState();
}

class _TemperatureConverterScreenState
    extends State<TemperatureConverterScreen> {
  TextEditingController _controller = TextEditingController();
  String _convertedTemperature = '';
  String _selectedConversion = 'Celsius to Fahrenheit';

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
      _controller.text = _controller.text + value;
      _convertTemperature();
    });
  }

  void _clearInput() {
    setState(() {
      _controller.clear();
      _convertedTemperature = '';
    });
  }

  void _addDecimalPoint() {
    if (!_controller.text.contains('.')) {
      setState(() {
        _controller.text =
            _controller.text.isEmpty ? '0.' : _controller.text + '.';
        _convertTemperature();
      });
    }
  }

  void _convertTemperature() {
    String inputText = _controller.text;
    if (inputText.isEmpty || inputText == '.') {
      setState(() {
        _convertedTemperature = '';
      });
      return;
    }

    double? inputTemp = double.tryParse(inputText);
    if (inputTemp == null) {
      setState(() {
        _convertedTemperature = '';
      });
      return;
    }

    double result;
    setState(() {
      if (_selectedConversion == 'Celsius to Fahrenheit') {
        result = (inputTemp * 9 / 5) + 32;
        _convertedTemperature = '${result.toStringAsFixed(2)}°F';
      } else if (_selectedConversion == 'Fahrenheit to Celsius') {
        result = (inputTemp - 32) * 5 / 9;
        _convertedTemperature = '${result.toStringAsFixed(2)}°C';
      } else if (_selectedConversion == 'Celsius to Kelvin') {
        result = inputTemp + 273.15;
        _convertedTemperature = '${result.toStringAsFixed(2)}K';
      } else if (_selectedConversion == 'Fahrenheit to Kelvin') {
        result = (inputTemp - 32) * 5 / 9 + 273.15;
        _convertedTemperature = '${result.toStringAsFixed(2)}K';
      } else if (_selectedConversion == 'Kelvin to Celsius') {
        result = inputTemp - 273.15;
        _convertedTemperature = '${result.toStringAsFixed(2)}°C';
      } else if (_selectedConversion == 'Kelvin to Fahrenheit') {
        result = (inputTemp - 273.15) * 9 / 5 + 32;
        _convertedTemperature = '${result.toStringAsFixed(2)}°F';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature Converter')),
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
                      _controller.text,
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      _convertedTemperature,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white.withOpacity(0.9),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _selectedConversion,
                          items: <String>[
                            'Celsius to Fahrenheit',
                            'Fahrenheit to Celsius',
                            'Celsius to Kelvin',
                            'Fahrenheit to Kelvin',
                            'Kelvin to Celsius',
                            'Kelvin to Fahrenheit'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedConversion = newValue!;
                              if (_controller.text.isNotEmpty) {
                                _convertTemperature();
                              }
                            });
                          },
                        ),
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
                      _buildButton('1', onPressed: () => _onButtonClick('1')),
                      _buildButton('2', onPressed: () => _onButtonClick('2')),
                      _buildButton('3', onPressed: () => _onButtonClick('3')),
                      _buildButton('.',
                          backgroundColor: Colors.orange[600],
                          onPressed: _addDecimalPoint),
                      _buildButton('4', onPressed: () => _onButtonClick('4')),
                      _buildButton('5', onPressed: () => _onButtonClick('5')),
                      _buildButton('6', onPressed: () => _onButtonClick('6')),
                      _buildButton('±', backgroundColor: Colors.orange[600],
                          onPressed: () {
                        if (_controller.text.startsWith('-')) {
                          _controller.text = _controller.text.substring(1);
                        } else if (_controller.text.isNotEmpty) {
                          _controller.text = '-' + _controller.text;
                        }
                        _convertTemperature();
                      }),
                      _buildButton('7', onPressed: () => _onButtonClick('7')),
                      _buildButton('8', onPressed: () => _onButtonClick('8')),
                      _buildButton('9', onPressed: () => _onButtonClick('9')),
                      Container(),
                      _buildButton('⌫',
                          backgroundColor: Colors.orange[600],
                          onPressed: _clearInput),
                      _buildButton('0', onPressed: () => _onButtonClick('0')),
                      _buildButton('C',
                          backgroundColor: Colors.red[400],
                          onPressed: _clearInput),
                      Container(),
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
