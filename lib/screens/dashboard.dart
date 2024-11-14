import 'package:flutter/material.dart';
import 'temperature_converter.dart';
import 'profile.dart';
import 'calculator.dart';
import 'time_converter.dart';
import 'binary_converter.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _taskController = TextEditingController();
  final List<String> _tasks = [];
  final FocusNode _taskFocusNode = FocusNode(); // FocusNode to manage focus

  Widget _buildMenuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Material(
        color: color,  // Using widget color (blue shades)
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

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
        _taskFocusNode.unfocus(); // Remove focus from the TextField
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white), // Set text color to white
        ),
        backgroundColor: Colors.blue[600], // Update AppBar color to match the widget color
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Colors.white), // Set icon color to white
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileScreen()),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard if user taps anywhere outside the TextField
          _taskFocusNode.unfocus();
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue[50]!, Colors.blue[100]!], // Blue gradient
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // To-Do List input and button
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        focusNode: _taskFocusNode, // Attach FocusNode
                        decoration: InputDecoration(
                          hintText: 'Enter a new task...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onSubmitted: (value) {
                          _addTask(); // Add task on Enter key press
                        },
                      ),
                    ),
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addTask,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[600], // Blue button color
                        foregroundColor: Colors.white, // White text color
                      ),
                      child: Text('Add'),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Display list of tasks with limited height
                SizedBox(
                  height: 250, // Limit height to fit 5 rows approximately
                  child: Scrollbar(
                    child: ListView.builder(
                      itemCount: _tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            title: Text(_tasks[index]),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeTask(index),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Grid of buttons
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: [
                      _buildMenuItem(
                        title: 'Standard\nCalculator',
                        icon: Icons.calculate,
                        color: Colors.blue[600]!, // Blue color for buttons
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalculatorScreen()),
                        ),
                      ),
                      _buildMenuItem(
                        title: 'Temperature\nConverter',
                        icon: Icons.thermostat,
                        color: Colors.blue[600]!, // Blue color for buttons
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TemperatureConverterScreen()),
                        ),
                      ),
                      _buildMenuItem(
                        title: 'Time\nConverter',
                        icon: Icons.access_time,
                        color: Colors.blue[600]!, // Blue color for buttons
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TimeConverterScreen()),
                        ),
                      ),
                      _buildMenuItem(
                        title: 'Binary\nConverter',
                        icon: Icons.code,
                        color: Colors.blue[600]!, // Blue color for buttons
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BinaryConverterScreen()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    _taskFocusNode.dispose(); // Dispose FocusNode
    super.dispose();
  }
}
