import 'package:flutter/material.dart';

class BinaryConverterScreen extends StatefulWidget {
  @override
  _BinaryConverterScreenState createState() => _BinaryConverterScreenState();
}

class _BinaryConverterScreenState extends State<BinaryConverterScreen> {
  TextEditingController _controller = TextEditingController();
  String _convertedResult = '';
  String _selectedConversion = 'Decimal to Binary';

  Widget _buildButton(
    String label, {
    Color? backgroundColor,
    Color? textColor,
    VoidCallback? onPressed,
    bool enabled = true,
  }) {
    return Container(
      margin: EdgeInsets.all(4),
      child: Material(
        color:
            enabled ? (backgroundColor ?? Colors.blue[600]) : Colors.grey[300],
        borderRadius: BorderRadius.circular(16),
        elevation: 2,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(14),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                color: enabled ? (textColor ?? Colors.white) : Colors.grey[500],
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
      _convertBinary();
    });
  }

  void _clearInput() {
    setState(() {
      _controller.clear();
      _convertedResult = '';
    });
  }

  void _backspace() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _controller.text =
            _controller.text.substring(0, _controller.text.length - 1);
        _convertBinary();
      });
    }
  }

  bool _isValidInput(String value) {
    if (_selectedConversion == 'Binary to Decimal') {
      return RegExp(r'^[01]*$').hasMatch(value);
    }
    return RegExp(r'^[0-9]*$').hasMatch(value);
  }

  void _convertBinary() {
    String inputText = _controller.text;
    if (inputText.isEmpty) {
      setState(() {
        _convertedResult = '';
      });
      return;
    }

    try {
      String result = '';
      if (_selectedConversion == 'Decimal to Binary') {
        int? decimal = int.tryParse(inputText);
        if (decimal != null) {
          result = decimal.toRadixString(2);
        } else {
          result = 'Invalid input';
        }
      } else if (_selectedConversion == 'Binary to Decimal') {
        if (RegExp(r'^[01]+$').hasMatch(inputText)) {
          result = int.parse(inputText, radix: 2).toString();
        } else {
          result = 'Invalid binary number';
        }
      }

      setState(() {
        _convertedResult = result;
      });
    } catch (e) {
      setState(() {
        _convertedResult = 'Error: Invalid input';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isBinaryMode = _selectedConversion == 'Binary to Decimal';

    return Scaffold(
      appBar: AppBar(
        title: Text('Binary Converter'),
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
                      _convertedResult,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.purple[700],
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
                            'Decimal to Binary',
                            'Binary to Decimal',
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedConversion = newValue!;
                              _controller.clear();
                              _convertedResult = '';
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
              padding: EdgeInsets.all(23),
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
                      _buildButton('7',
                          onPressed: () => _onButtonClick('7'),
                          enabled: !isBinaryMode),
                      _buildButton('8',
                          onPressed: () => _onButtonClick('8'),
                          enabled: !isBinaryMode),
                      _buildButton('9',
                          onPressed: () => _onButtonClick('9'),
                          enabled: !isBinaryMode),
                      _buildButton('4',
                          onPressed: () => _onButtonClick('4'),
                          enabled: !isBinaryMode),
                      _buildButton('5',
                          onPressed: () => _onButtonClick('5'),
                          enabled: !isBinaryMode),
                      _buildButton('6',
                          onPressed: () => _onButtonClick('6'),
                          enabled: !isBinaryMode),
                      _buildButton('1', onPressed: () => _onButtonClick('1')),
                      _buildButton('2',
                          onPressed: () => _onButtonClick('2'),
                          enabled: !isBinaryMode),
                      _buildButton('3',
                          onPressed: () => _onButtonClick('3'),
                          enabled: !isBinaryMode),
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
