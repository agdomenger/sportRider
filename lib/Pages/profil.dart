import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/AjoutEvent.dart';
import 'package:sport_rider/Pages/Bottom.dart';
import 'package:sport_rider/Pages/Calendar.dart';
import 'package:sport_rider/Pages/questionnaireProfil.dart';
import 'package:sport_rider/Widgets/Horse.dart';
import 'package:sport_rider/Widgets/event.dart';
import 'package:sport_rider/Widgets/eventList.dart';

class ProfilePage extends StatefulWidget {
  final String id_doc; // L'ID du document Firebase
  ProfilePage({required this.id_doc});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userData = _fetchUserData();

  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http
        .get(Uri.parse('http://localhost:8080/comptes/${widget.id_doc}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  // Email de l'utilisateur (à remplacer par les données réelles)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder<Map<String, dynamic>>(
          future: _userData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              final userData = snapshot.data!;
              List<dynamic> equides = userData['equides'] ?? [];
              final email = userData['email'] as String;
              final userName = userData['nom'] as String ?? "";
              final userSurname = userData['prenom'] as String ?? "";
              String horseName = "Ajouter un équidé";
              String horseElevage = "";
              String horseYear = "non communiqué";
              if (equides.isNotEmpty) {
                horseName = equides[0]['nom'].toString();
                horseElevage = equides[0]['elevage'].toString();
                horseYear = equides[0]['anneeNaissance'].toString();
              }
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    // En-tête avec l'image ronde
                    Container(
                      height: 80,
                      child: Row(
                        children: [
                          // Moitié haute à gauche de l'image
                          Container(
                            width: MediaQuery.of(context).size.width / 2 -
                                44, // 44 est la largeur totale des deux bordures
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 37,
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                          // Image ronde
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(context).primaryColorDark,
                            backgroundImage: AssetImage(
                              '/Users/domenger/Desktop/P2i/sport_rider/assets/user_image.jpg',
                            ),
                          ),
                          // Moitié haute à droite de l'image
                          Container(
                            width: MediaQuery.of(context).size.width / 2 -
                                44, // 44 est la largeur totale des deux bordures
                            height: 200,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  color: Colors.transparent,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          width: 3.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 37,
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    // Informations utilisateur
                    Text(
                      'Bienvenue $userName  $userSurname',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                    ),
                    Text(
                      email,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).primaryColorDark),
                    ),
                    SizedBox(height: 30),
                    // Cadres organisés en lignes et colonnes
                    Row(
                      children: [
                        // Première colonne
                        Expanded(
                          child: Column(
                            children: [
                              HorseWidget(
                                  nom: horseName,
                                  elevage: horseElevage,
                                  annee: horseYear),
                              SizedBox(height: 4),
                              InkWell(
                                onTap: () {
                                  // Ajoutez ici la navigation vers la page du questionnaire
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            QuestionnaireApp()),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4.0),
                                  margin: EdgeInsets.all(4.0),
                                  height: 86,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .canvasColor, // Couleur de la bordure
                                      width: 3.0, // Épaisseur de la bordure
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      // Colonne pour le titre
                                      Expanded(
                                        flex: 6, // 60% de la largeur
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Mon profil',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                'À complèter',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .canvasColor,
                                                  fontSize: 12.0,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // Colonne pour l'icône
                                      Expanded(
                                        flex: 4, // 40% de la largeur
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  Theme.of(context).canvasColor,
                                            ),
                                            child: Icon(
                                              Icons.warning,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Deuxième colonne
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            margin: EdgeInsets.all(4.0),
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Theme.of(context)
                                    .primaryColorDark, // Couleur de la bordure
                                width: 3.0, // Épaisseur de la bordure
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    ' Preparation sportive',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColorDark,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 100, // Adjust the width as needed
                                  height: 100, // Adjust the height as needed
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width:
                                            100, // Adjust the size of the gray part
                                        height:
                                            100, // Adjust the size of the gray part
                                        child: CircularProgressIndicator(
                                          value:
                                              1.0, // Max value to create the gray part
                                          strokeWidth: 20,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).primaryColorLight,
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: CircularProgressIndicator(
                                          value: 0.2, // 20% completion
                                          strokeWidth: 20,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Theme.of(context).primaryColorDark,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.fitness_center,
                                              size: 45,
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            Text(
                                              '0%', // User's progress percentage
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context)
                                                    .primaryColorDark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Les évènements à venir : ',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    EventListWidget(
                        userData: userData, numberOfEventsToShow: 3),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0, right: 16.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.transparent, // Fond neutre
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Theme.of(context)
                                  .primaryColorDark, // Bord bleu foncé
                              width: 2.0,
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              // Naviguer vers la page d'ajout d'événement
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EventForm(id_document: widget.id_doc),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                                SizedBox(width: 6.0),
                                Text(
                                  'Ajouter un événement',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).primaryColorDark),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
              bottomNavigationBar:
              MyBottomNavigationBar(id_doc: widget.id_doc);
            }
          }),
    );
  }
}

class Event {
  final DateTime date;

  Event(this.date);
}

List<Event> _events = [
  Event(DateTime(2024, 3, 1)),
  Event(DateTime(2024, 3, 16)),
  Event(DateTime(2024, 3, 17)), // Un événement pour aujourd'hui
  Event(DateTime(2024, 3, 17)), // Un événement pour demain
  Event(DateTime(2024, 3, 18)), // Un événement pour le lendemain
  // Ajoutez d'autres événements au besoin
];

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
