import 'package:flutter/material.dart';

void main() {
  runApp(FocusApp());
}

 class FocusApp extends StatelessWidget {
    @override
    Widget build(BuildContext context){
        return MaterialApp(actions:
        title: 'Daily Focus Planner',
        home: HomePage(),
        );
    }
 }

 class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
 } 

    class _HomePageState extends State<HomePage> {
        TextEditingController taskController = TextEditingController();
        String mood= "Normal";
        String priority= "Medium";
        String result = "";
        
        @override
        Widget build(BuildContext context){
            return Scaffold(
                appBar: AppBar(
                    title: Text('Daily Focus Planner'),
                    centerTitle: true,
                    backgroundColor: const Color.fromARGB(255, 85, 163, 226),
                ),
                body: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                        children: [
                            TextField(
                                controller: taskController,
                                decoration: InputDecoration(
                                    labelText: 'Enter your task',
                                    border: OutlineInputBorder(),
                                ),
                            ),

                            SizedBox(height: 20),
                            DropdownButton<String>(
                                value: mood,
                                items: <String>['Low', 'Normal', 'High']
                                    .map((String value) {
                                        return DropdownMenuItem( value: value,child: Text(value));
                                    }).toList(),
                                onChanged: (newValue) {
                                    setState(() {
                                        mood = newValue!;
                                    });
                                },
                            ),
                            SizedBox(height: 10),
                            DropdownButton<String>(
                                value: priority,
                                items: ['Low', 'Medium', 'High']
                                    .map((String value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text(value)
                                        );
                                    }).toList(),
                                onChanged: (newValue) {
                                    setState(() {
                                        priority = newValue!;
                                    });
                                },
                            ),
                            SizedBox(height:20),

                            ElevatedButton(
                                onPressed: () {
                                    setState(() {
                                        result = generateMessage();
                                    });
                                },
                                child: Text('Generate Focus Plan'),
                            ),

                            SizedBox(height: 20),
                            Text(
                                result,
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                            )
                        ],
                    ),
                ),
            );
        }}

    