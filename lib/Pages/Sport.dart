import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importer la bibliothèque HTTP
import 'dart:convert';

import 'package:sport_rider/Pages/Bottom.dart';

class SportPage extends StatefulWidget {
  final String id_doc; // L'ID ddu document firebase
  SportPage({required this.id_doc});
  @override
  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  @override
  Widget build(BuildContext context) {
    var selectedExercise;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text('Preparation physique'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 250, // Adjust the width as needed
                height: 250, // Adjust the height as needed
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 250, // Adjust the size of the gray part
                      height: 250, // Adjust the size of the gray part
                      child: CircularProgressIndicator(
                        value: 1.0, // Max value to create the gray part
                        strokeWidth: 20,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: CircularProgressIndicator(
                        value: 0.2, // 20% completion
                        strokeWidth: 20,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 90,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          Text(
                            '20%', // User's progress percentage
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColorDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Displaying the three training rectangles
              TrainingRectangle(title: 'Entrainement 1'),
              TrainingRectangle(title: 'Entrainement 2'),
              TrainingRectangle(title: 'Entrainement 3'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        id_doc: widget.id_doc,
      ),
    );
  }
}

class TrainingRectangle extends StatelessWidget {
  final String title;

  const TrainingRectangle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10), // Adjust the vertical spacing
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColorDark, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title),
        leading: Icon(Icons.add),
        onTap: () {
          // Action when the "+" icon is tapped (open menu)
          _showTrainingMenu(context);
        },
      ),
    );
  }

  void _showTrainingMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // List of exercises
              // Replace this with your actual exercises
              for (int i = 1; i <= 5; i++)
                ListTile(
                  leading: Icon(Icons.directions_run), // Person exercising icon
                  title: Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'X5', // Replace with your parameter label logic
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.check_circle, //Icons.check_circle_outline,
                    color: Colors.green, // Colors.grey,
                  ),
                  onTap: () {
                    // Action when the exercise is tapped
                  },
                ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Action when "Commencer cet entraînement" button is pressed
                },
                child: Text('Commencer cet entraînement'),
              ),
            ],
          ),
        );
      },
    );
  }
}
