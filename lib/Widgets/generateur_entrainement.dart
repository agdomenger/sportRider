import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

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
      // Récupérer la liste des IDs d'exercices depuis l'URL spécifiée
      final response =
          await http.get(Uri.parse('http://localhost:8080/exercices'));
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
          Uri.parse('http://localhost:8080/entrainements'),
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "compteId": widget.idDoc,
            "exerciceIds": selectedExercises,
          }),
        );

        if (trainingResponse.statusCode == 201) {
          // L'entraînement a été créé avec succès
          print('Entraînement créé avec succès !');
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
