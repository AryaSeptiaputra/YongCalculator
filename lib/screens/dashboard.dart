import 'package:flutter/material.dart';
import 'temperature_converter.dart';
import 'profile.dart';
import 'calculator.dart';
import 'time_converter.dart';
import 'binary_converter.dart';

class Dashboard extends StatelessWidget {
  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(16),
        elevation: 4,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.white),
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[50]!, Colors.blue[100]!],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              _buildMenuItem(
                title: 'Standard\nCalculator',
                icon: Icons.calculate,
                color: Colors.blue[600]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalculatorScreen()),
                ),
              ),
              _buildMenuItem(
                title: 'Temperature\nConverter',
                icon: Icons.thermostat,
                color: Colors.blue[600]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TemperatureConverterScreen()),
                ),
              ),
              _buildMenuItem(
                title: 'Time\nConverter',
                icon: Icons.access_time,
                color: Colors.blue[600]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimeConverterScreen()),
                ),
              ),
              _buildMenuItem(
                title: 'Binary\nConverter',
                icon: Icons.code,
                color: Colors.blue[600]!,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BinaryConverterScreen()), // Navigasi ke layar Binary Converter
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
