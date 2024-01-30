import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/questionnaireProfil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Page',
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                                  color: Theme.of(context).primaryColorDark,
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
                                  color: Theme.of(context).primaryColorDark,
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
              'Nom Prénom',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColorDark),
            ),
            Text(
              'utilisateur@example.com',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).primaryColorDark),
            ),
            SizedBox(height: 80),
            // Cadres organisés en lignes et colonnes
            Row(
              children: [
                // Première colonne
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.0),
                        margin: EdgeInsets.all(4.0),
                        height: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).shadowColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                '  Mes chevaux',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom:
                                  4.0, // ajustez la marge en bas selon vos besoins
                              left:
                                  10.0, // ajustez la marge à gauche selon vos besoins
                              child: Text(
                                '0%',
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      InkWell(
                        onTap: () {
                          // Ajoutez ici la navigation vers la page du questionnaire
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionnaireApp()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(4.0),
                          margin: EdgeInsets.all(4.0),
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  '  Mon profil',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 4.0,
                                left: 10.0,
                                child: Text(
                                  '0%',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColorDark,
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
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
                    height: 200,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorDark,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '  Préparation',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '0%',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .primaryColor, // Choisir la couleur appropriée pour le texte
                              fontSize:
                                  40.0, // Ajuster la taille du texte selon vos préférences
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
