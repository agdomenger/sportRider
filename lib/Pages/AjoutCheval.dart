import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sport_rider/Pages/profil.dart';

class AddHorsePage extends StatefulWidget {
  final String id_document;

  AddHorsePage({required this.id_document});
  @override
  _AddHorsePageState createState() => _AddHorsePageState();
}

class _AddHorsePageState extends State<AddHorsePage> {
  late String id_document;
  late TextEditingController nameController;
  late TextEditingController birthYearController;
  late TextEditingController breedingController;

  @override
  void initState() {
    super.initState();
    id_document = widget.id_document;
    nameController = TextEditingController();
    birthYearController = TextEditingController();
    breedingController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthYearController.dispose();
    breedingController.dispose();
    super.dispose();
  }

  Future<void> addHorse(String id_doc) async {
    final String nom = nameController.text;
    final int anneeNaissance = int.parse(birthYearController.text);
    final String elevage = breedingController.text;

    final Map<String, dynamic> requestBody = {
      "cmptId": id_doc,
      "equides": [
        {
          "nom": nom,
          "anneeNaissance": anneeNaissance,
          "elevage": elevage,
          "epreuves": []
        }
      ]
    };

    final Uri uri = Uri.parse(
        'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/equides');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(requestBody);

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Le cheval a été ajouté avec succès');
      Navigator.pushReplacement(
        // Revenir à la page SportPage
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(id_doc: id_doc),
        ),
      );
      // Revenir à la page profil et recharger les données
    } else {
      print('Échec de l\'ajout du cheval : ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un cheval'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nom du cheval',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: birthYearController,
              decoration: InputDecoration(
                labelText: 'Année de naissance',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: breedingController,
              decoration: InputDecoration(
                labelText: 'Élevage',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addHorse(id_document);
                // Clear the text fields
                nameController.clear();
                birthYearController.clear();
                breedingController.clear();
              },
              child: Text('Ajouter le cheval'),
            ),
          ],
        ),
      ),
    );
  }
}
