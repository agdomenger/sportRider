import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SportPage extends StatefulWidget {
  final String id_doc; // L'ID du document Firebase

  SportPage({required this.id_doc});

  @override
  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  late Future<Map<String, dynamic>> _userData = _fetchUserData();

  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/comptes/${widget.id_doc}'));
    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      return userData;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder<Map<String, dynamic>>(
          future: _userData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final userData = snapshot.data!;
              List<dynamic> entrainements = userData['entrainements'] ?? [];
              return SingleChildScrollView(
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
                    // Displaying the training rectangles
                    for (var i = 0; i < entrainements.length; i++)
                      TrainingRectangle(
                        title: 'Entraînement ${i + 1}',
                        exercises: entrainements[i]['exerciceIds'] ?? [],
                        // Assurez-vous que exercises ne soit pas null
                      ),

                    SizedBox(height: 20),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class TrainingRectangle extends StatelessWidget {
  final String title;
  final List<dynamic> exercises;

  const TrainingRectangle({
    required this.title,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showTrainingMenu(context, exercises);
      },
      child: Container(
        margin:
            EdgeInsets.symmetric(vertical: 10), // Adjust the vertical spacing
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColorDark, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(title),
          leading: Icon(Icons.add),
        ),
      ),
    );
  }

  void _showTrainingMenu(BuildContext context, List<dynamic> exercises) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // List of exercises
              for (var exercise in exercises)
                ListTile(
                  leading: Icon(Icons.directions_run), // Person exercising icon
                  title: Text(
                    exercise['description'] ?? 'Description missing',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Icon(
                    Icons.check_circle,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    // Action when the exercise is tapped
                  },
                ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Action when "Start this training" button is pressed
                },
                child: Text('Start this training'),
              ),
            ],
          ),
        );
      },
    );
  }
}
