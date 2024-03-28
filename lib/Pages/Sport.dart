import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sport_rider/Widgets/generateur_entrainement.dart';

class SportPage extends StatefulWidget {
  final String id_doc; // L'ID du document Firebase

  SportPage({required this.id_doc});

  @override
  _SportPageState createState() => _SportPageState();
}

class _SportPageState extends State<SportPage> {
  late Future<Map<String, dynamic>> _userData = _fetchUserData();

  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/comptes/${widget.id_doc}'));
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
              double pourcentage = calculatePercentage(userData);
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
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
                              value: pourcentage / 100, // 20% completion
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
                                  " $pourcentage %", // User's progress percentage
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
                        id_doc: widget.id_doc,
                        ind: i,
                        data: userData,
                        exercises: entrainements[i]['exerciceIds'] ?? [],
                        // Assurez-vous que exercises ne soit pas null
                      ),

                    SizedBox(height: 20),
                    CreerEntrainement(idDoc: widget.id_doc)
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
  final String id_doc;
  final int ind;
  final Map<String, dynamic> data;

  const TrainingRectangle(
      {required this.title,
      required this.exercises,
      required this.id_doc,
      required this.ind,
      required this.data});

  @override
  Widget build(BuildContext context) {
    bool allExercisesCompleted = checkAllExercisesStatus(data, ind);

    return GestureDetector(
      onTap: () {
        _showTrainingMenu(context, exercises, ind);
      },
      child: Container(
        width: 370,
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).primaryColorDark, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(title),
                leading: Icon(Icons.add),
              ),
            ),
            if (allExercisesCompleted)
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }

  void _showTrainingMenu(
      BuildContext context, List<dynamic> exercises, int index) {
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
                  trailing: exercise['status'] == true
                      ? Icon(
                          Icons.check_circle,
                          color: Colors
                              .green, // Change color to green if status is true
                        )
                      : Icon(
                          Icons.check_circle,
                          color: Colors
                              .grey, // Keep color as grey if status is false
                        ),
                  onTap: () {
                    // Action when the exercise is tapped
                  },
                ),

              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _TrainingStart(context, exercises, index, id_doc);
                },
                child: Text('Start this training'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _TrainingStart(
      BuildContext context, List<dynamic> exercises, int index, String id_doc) {
    int currentExerciseIndex = 0; // Index de l'exercice en cours
    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void nextExercise() async {
              // Mettre à jour le statut de l'exercice dans la base de données
              if (currentExerciseIndex < exercises.length) {
                final exerciseId = exercises[currentExerciseIndex]['id'];
                await updateExerciseStatus(exerciseId, id_doc, index);
              }
              setState(() {
                // Passer à l'exercice suivant
                if (currentExerciseIndex < exercises.length - 1) {
                  currentExerciseIndex++;
                } else {
                  Navigator.pushReplacement(
                    // Revenir à la page SportPage
                    context,
                    MaterialPageRoute(
                      builder: (context) => SportPage(id_doc: id_doc),
                    ),
                  );
                }
              });
            }

            final exercise = exercises[currentExerciseIndex];
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(
                      exercise['description'] ?? 'Description manquante',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("X 5"),
                    trailing: ElevatedButton(
                      onPressed: nextExercise,
                      child: Text('Exercice fini'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

Future<void> updateExerciseStatus(
    String exerciseId, String idCmpt, int index) async {
  try {
    print("///////////////////////////////////");
    print(index);
    print(exerciseId);
    print(idCmpt);
    final response = await http.put(
      Uri.parse(
          'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/exercices/$exerciseId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'idCompte': idCmpt,
        'index': index,
        'status': "true", // Mettre à jour le statut à true
      }),
    );
    if (response.statusCode == 200) {
      // La mise à jour a réussi
      print('Exercise status updated successfully');
    } else {
      // La mise à jour a échoué
      print('Failed to update exercise status');
    }
  } catch (e) {
    // Une erreur s'est produite lors de la mise à jour
    print('Error updating exercise status: $e');
  }
}

double calculatePercentage(Map<String, dynamic> userData) {
  // Vérifier si les données utilisateur contiennent la liste des entraînements
  if (userData.containsKey('entrainements')) {
    // Récupérer la liste des entraînements depuis les données utilisateur
    List<dynamic> entrainements = userData['entrainements'];

    // Initialiser le nombre total d'exercices et le nombre d'exercices vrais
    int totalExercises = 0;
    int trueExercises = 0;

    // Parcourir chaque entraînement
    for (var entrainement in entrainements) {
      // Récupérer la liste des exercices de l'entraînement
      List<dynamic> exerciceIds = entrainement['exerciceIds'] ?? [];

      // Mettre à jour le nombre total d'exercices
      totalExercises += exerciceIds.length;

      // Parcourir chaque exercice ID
      for (var exerciseId in exerciceIds) {
        // Récupérer les données de l'exercice par son ID

        // Extraire le statut de l'exercice de la réponse
        var exerciseStatus = exerciseId['status'];
        // Vérifier si le statut de l'exercice est true
        if (exerciseStatus == true) {
          trueExercises++;
        }
      }
    }

    // Calculer le pourcentage d'exercices avec le statut true
    double percentage = (trueExercises / totalExercises) * 100;

    return percentage;
  } else {
    throw Exception('Entrainements data not found in user data');
  }
}

bool checkAllExercisesStatus(Map<String, dynamic> userData, int trainingIndex) {
  // Vérifier si les données utilisateur contiennent la liste des entraînements
  if (userData.containsKey('entrainements')) {
    // Récupérer la liste des entraînements depuis les données utilisateur
    List<dynamic> entrainements = userData['entrainements'];

    // Vérifier si l'indice de l'entraînement est valide
    if (trainingIndex >= 0 && trainingIndex < entrainements.length) {
      // Récupérer l'entraînement correspondant à l'indice spécifié
      var entrainement = entrainements[trainingIndex];

      // Vérifier si l'entraînement contient des exercices
      if (entrainement.containsKey('exerciceIds')) {
        // Récupérer la liste des exercices de l'entraînement
        List<dynamic> exerciceIds = entrainement['exerciceIds'];

        // Parcourir chaque exercice de l'entraînement
        for (var exerciseId in exerciceIds) {
          // Vérifier si le statut de l'exercice est true
          if (exerciseId['status'] != true) {
            return false; // Si un exercice a un statut différent de true, retourner faux
          }
        }
        return true; // Si tous les exercices ont un statut true, retourner vrai
      } else {
        throw Exception('Exercise IDs not found in training data');
      }
    } else {
      throw Exception('Invalid training index');
    }
  } else {
    throw Exception('Trainings data not found in user data');
  }
}
