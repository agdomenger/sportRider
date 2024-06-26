import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'package:sport_rider/Pages/Sport.dart';

/*
le widget fait appel à l'api afin de créer un entrainement sur mesure de 5 exercices correspondant
au profil de l'utilisateur.
 */
class CreerEntrainement extends StatefulWidget {
  final String idDoc;

  CreerEntrainement({required this.idDoc});

  @override
  _CreerEntrainementState createState() => _CreerEntrainementState();
}

class _CreerEntrainementState extends State<CreerEntrainement> {
  List<String> _exerciseIds = [];

  Future<void> _fetchExercisesAndCreateTraining() async {
    try {
      // Récupérer la liste des IDs d'exercices depuis l'API
      final response = await http.get(Uri.parse(
          'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/exercices'));
      if (response.statusCode == 200) {
        final List<dynamic> exerciseIds = json.decode(response.body);
        // Tirer au sort 5 IDs d'exercices aléatoires
        List<String> selectedExercises = [];
        final random = Random();
        while (selectedExercises.length < 5) {
          final int randomIndex = random.nextInt(exerciseIds.length);
          final String exerciseId = exerciseIds[randomIndex];
          if (!selectedExercises.contains(exerciseId)) {
            selectedExercises.add(exerciseId);
          }
        }
        print(
          json.encode({
            "compteId": widget.idDoc,
            "exerciceIds": selectedExercises,
          }),
        );
        // Créer l'entraînement avec les IDs d'exercices sélectionnés
        final trainingResponse = await http.post(
          Uri.parse(
              'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/entrainements'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "compteId": widget.idDoc,
            "exerciceIds": selectedExercises,
          }),
        );

        if (trainingResponse.statusCode == 201) {
          // L'entraînement a été créé avec succès
          print('Entraînement créé avec succès !');
          Navigator.pushReplacement(
            // Revenir à la page SportPage
            context,
            MaterialPageRoute(
              builder: (context) => SportPage(id_doc: widget.idDoc),
            ),
          );
        } else {
          // Erreur lors de la création de l'entraînement
          print('Erreur lors de la création de l\'entraînement.');
        }
      } else {
        // Erreur lors de la récupération des IDs d'exercices
        print('Erreur lors de la récupération des IDs d\'exercices.');
      }
    } catch (e) {
      print('Une erreur est survenue : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _fetchExercisesAndCreateTraining,
      child: Text('Créer un nouvel entraînement'),
    );
  }
}
