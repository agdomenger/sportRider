import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/AjoutEvent.dart';
import 'package:sport_rider/Pages/Bottom.dart';
import 'package:sport_rider/Pages/Login.dart';
import 'package:sport_rider/Pages/questionnaireProfil.dart';
import 'package:sport_rider/Widgets/Horse.dart';
import 'package:sport_rider/Widgets/deco.dart';
import 'package:sport_rider/Widgets/eventList.dart';

class ProfilePage extends StatefulWidget {
  final String id_doc; // L'ID du document Firebase
  ProfilePage({required this.id_doc});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Map<String, dynamic>> _userData = _fetchUserData();
//récuperer les informations de l'utilisateur
  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/comptes/${widget.id_doc}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  void _logout() async {
    try {
      // requête GET vers la route de déconnexion
      var response = await http.get(Uri.parse(
          'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/logout'));

      // Vérifiez si la requête a réussi
      if (response.statusCode == 200) {
        // Déconnexion réussie
        print('Déconnexion réussie');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        // La requête a échoué
        print(
            'Échec de la déconnexion. Code de statut: ${response.statusCode}');
      }
    } catch (e) {
      // Une erreur s'est produite lors de l'envoi de la requête
      print('Erreur lors de la déconnexion: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: CustomAppBar(onLogout: _logout),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>>(
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
                //modulé l'affichage en fonction de si on a les infos ou pas
                // permet pour les comptes qui viennent d'être créés d'être guidé,
                // et pour les comptes actifs d'avoir accès à leurs infos
                final userData = snapshot.data!;
                List<dynamic> equides = userData['equides'] ?? [];
                final email = userData['email'] as String;
                final userName = userData['nom'] as String ?? "";
                final userSurname = userData['prenom'] as String ?? "";
                String horseName = "Ajouter un équidé";
                String horseElevage = "";
                String horseYear = "non communiqué";
                double pourcentage = calculatePercentage(userData);
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
                      // En-tête avec l'image ronde au centre
                      Container(
                        height: 80,
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 44,
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
                            CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  Theme.of(context).primaryColorDark,
                              backgroundImage: AssetImage(
                                'assets/user_image.jpg',
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2 - 44,
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
                                    id_doc: widget.id_doc,
                                    nom: horseName,
                                    elevage: horseElevage,
                                    annee: horseYear),
                                SizedBox(height: 4),
                                InkWell(
                                  onTap: () {
                                    //redirection vers la page qcm
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              QuestionnaireApp(
                                                id_doc: widget.id_doc,
                                              )),
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
                                        color: Theme.of(context).canvasColor,
                                        width: 3.0,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 6,
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
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                            width: 70,
                                            height: 70,
                                            child: Text(
                                              "⚠️",
                                              style: TextStyle(
                                                  fontSize: 60,
                                                  color: Color.fromARGB(
                                                      255, 255, 149, 2)),
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
                                  color: Theme.of(context).primaryColorDark,
                                  width: 3.0,
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
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: CircularProgressIndicator(
                                            value: 1.0,
                                            strokeWidth: 20,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Theme.of(context)
                                                  .primaryColorLight,
                                            ),
                                          ),
                                        ),
                                        Positioned.fill(
                                          child: CircularProgressIndicator(
                                            value: pourcentage / 100,
                                            strokeWidth: 20,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Theme.of(context)
                                                  .primaryColorDark,
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
                                                '$pourcentage %', //prencentage d'avancement dans les entrainements
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
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Theme.of(context).primaryColorDark,
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
              }
            }),
      ),
      bottomNavigationBar: MyBottomNavigationBar(id_doc: widget.id_doc),
    );
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

//fonction epermettant de connaire l'avancement de l'utilisateur dans les exercices proposés
double calculatePercentage(Map<String, dynamic> userData) {
  // Vérifier si les données utilisateur contiennent la liste des entraînements
  if (userData.containsKey('entrainements')) {
    // Récupérer la liste des entraînements depuis les données utilisateur
    List<dynamic> entrainements = userData['entrainements'];

    // Initialiser le nombre total d'exercices et le nombre d'exercices vrais
    int totalExercises = 1;
    int trueExercises = 0;

    // Parcourir chaque entraînement
    if (entrainements.length >= 1) {
      for (var entrainement in entrainements) {
        // Récupérer la liste des exercices de l'entraînement
        List<dynamic> exerciceIds = entrainement['exerciceIds'] ?? [];

        // Mettre à jour le nombre total d'exercices
        totalExercises += exerciceIds.length;

        // Parcourir chaque exercice ID
        for (var exerciseId in exerciceIds) {
          var exerciseStatus = exerciseId['status'];
          if (exerciseStatus == true) {
            trueExercises++;
          }
        }
      }
    }

    // Calculer le pourcentage
    double percentage = (trueExercises / totalExercises) * 100;

    // Arrondir le résultat à l'unité
    return percentage.roundToDouble();
  }
  return 0.0;
}
