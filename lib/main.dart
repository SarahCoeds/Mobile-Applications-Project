import 'package:flutter/material.dart';

void main() {
  runApp(FocusApp());
}

class FocusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Daily Focus Planner', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController taskController = TextEditingController();
  String mood = "Normal";
  String priority = "Medium";
  String result = "";
  String userName = "Student"; // For welcome message

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient background
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // Welcome card
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: Colors.white.withOpacity(0.8),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            "Welcome, $userName!",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Let's plan your day and stay focused!",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Task input
                  TextField(
                    controller: taskController,
                    decoration: InputDecoration(
                      labelText: 'Enter your task',
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Mood label + dropdown
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select your mood:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: mood,
                    items: <String>['Low', 'Normal', 'High'].map((
                      String value,
                    ) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        mood = newValue!;
                      });
                    },
                  ),

                  SizedBox(height: 10),

                  // Priority label + dropdown
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select task priority:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: priority,
                    items: ['Low', 'Medium', 'High'].map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        priority = newValue!;
                      });
                    },
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        result = generateMessage();
                      });
                    },
                    child: Text('Generate Focus Plan'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                      backgroundColor: Colors
                          .blue
                          .shade700, // <-- use backgroundColor instead of primary
                    ),
                  ),

                  SizedBox(height: 20),

                  // Result text
                  Text(
                    result,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Generate focus message
  String generateMessage() {
    String task = taskController.text;

    if (task.isEmpty) {
      return "Please enter a task first.";
    }

    if (mood == "Low" && priority == "High") {
      return "Take a deep breath. Work slowly and focus only on $task";
    }

    if (mood == "High" && priority == "Low") {
      return "Your mood is ideal to start working on $task";
    }

    return "Focus and work on $task";
  }
}
