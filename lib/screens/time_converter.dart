import 'package:flutter/material.dart';

class TimeConverterScreen extends StatefulWidget {
  @override
  _TimeConverterScreenState createState() => _TimeConverterScreenState();
}

class _TimeConverterScreenState extends State<TimeConverterScreen> {
  TextEditingController _controller = TextEditingController();
  String _convertedTime = '';
  String _selectedConversion = 'Hour to Minute';

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
            padding: EdgeInsets.all(14),
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
      _convertTime();
    });
  }

  void _clearInput() {
    setState(() {
      _controller.clear();
      _convertedTime = '';
    });
  }

  void _addDecimalPoint() {
    if (!_controller.text.contains('.')) {
      setState(() {
        _controller.text =
            _controller.text.isEmpty ? '0.' : _controller.text + '.';
        _convertTime();
      });
    }
  }

  void _backspace() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
        if (_controller.text.isNotEmpty) {
          _convertTime();
        } else {
          _convertedTime = '';
        }
      });
    }
  }

  void _convertTime() {
    String inputText = _controller.text;
    if (inputText.isEmpty || inputText == '.') {
      setState(() {
        _convertedTime = '';
      });
      return;
    }

    double? inputTime = double.tryParse(inputText);
    if (inputTime == null) {
      setState(() {
        _convertedTime = 'Invalid input';
      });
      return;
    }

    double result = 0;
    String unit = '';

    switch (_selectedConversion) {
      case 'Hour to Minute':
        result = inputTime * 60;
        unit = 'minutes';
        break;
      case 'Hour to Second':
        result = inputTime * 3600;
        unit = 'seconds';
        break;
      case 'Minute to Hour':
        result = inputTime / 60;
        unit = 'hours';
        break;
      case 'Minute to Second':
        result = inputTime * 60;
        unit = 'seconds';
        break;
      case 'Second to Hour':
        result = inputTime / 3600;
        unit = 'hours';
        break;
      case 'Second to Minute':
        result = inputTime / 60;
        unit = 'minutes';
        break;
    }

    setState(() {
      _convertedTime = '${result.toStringAsFixed(2)} $unit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Converter'),
      ),
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
                      _convertedTime,
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
                            'Hour to Minute',
                            'Hour to Second',
                            'Minute to Hour',
                            'Minute to Second',
                            'Second to Hour',
                            'Second to Minute',
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
                                _convertTime();
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
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    children: [
                      _buildButton('1', onPressed: () => _onButtonClick('1')),
                      _buildButton('2', onPressed: () => _onButtonClick('2')),
                      _buildButton('3', onPressed: () => _onButtonClick('3')),
                      _buildButton('4', onPressed: () => _onButtonClick('4')),
                      _buildButton('5', onPressed: () => _onButtonClick('5')),
                      _buildButton('6', onPressed: () => _onButtonClick('6')),
                      _buildButton('7', onPressed: () => _onButtonClick('7')),
                      _buildButton('8', onPressed: () => _onButtonClick('8')),
                      _buildButton('9', onPressed: () => _onButtonClick('9')),
                      _buildButton('⌫',
                          backgroundColor: Colors.orange[600],
                          onPressed: _backspace),
                      _buildButton('0', onPressed: () => _onButtonClick('0')),
                      _buildButton('C',
                          backgroundColor: Colors.red[400],
                          onPressed: _clearInput),
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
