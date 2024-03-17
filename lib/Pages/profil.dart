import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/AjoutEvent.dart';
import 'package:sport_rider/Pages/Bottom.dart';
import 'package:sport_rider/Pages/Calendar.dart';
import 'package:sport_rider/Pages/questionnaireProfil.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
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
              'Bienvenue  [Prénom]',
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
            SizedBox(height: 30),
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
                        height: 86,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Theme.of(context)
                                .shadowColor, // Couleur de la bordure
                            width: 3.0, // Épaisseur de la bordure
                          ),
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '[Nom cheval]',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).shadowColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'amateur4 cso',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Theme.of(context).shadowColor,
                                      fontSize: 12.0,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 70, // Largeur du conteneur principal
                                height: 70, // Hauteur du conteneur principal
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).shadowColor,
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    '/Users/domenger/Desktop/P2i/sport_rider/assets/saut.png',
                                    // Hauteur de l'icône à l'intérieur du rond blanc
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
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
                                          color: Theme.of(context).canvasColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'À complèter',
                                        style: TextStyle(
                                          color: Theme.of(context).canvasColor,
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
                                      color: Theme.of(context).canvasColor,
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
                                width: 100, // Adjust the size of the gray part
                                height: 100, // Adjust the size of the gray part
                                child: CircularProgressIndicator(
                                  value:
                                      1.0, // Max value to create the gray part
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
                                      size: 45,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    Text(
                                      '20%', // User's progress percentage
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Theme.of(context).primaryColorDark,
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
                  fontSize: 20.0, // Taille de la police
                  fontWeight: FontWeight.bold, // Texte en gras
                  color: Theme.of(context).primaryColorDark, // Couleur du texte
                ),
              ),
            ),

            for (var i = 0; i < 3 && i < _events.length; i++)
              EventWidget(
                icon: Icons.fitness_center,
                title: 'Séance de sport',
                time: '10:00 - 11:00',
                description: 'Entraînement de musculation',
                date: _events[i].date,
              ),
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
                      color:
                          Theme.of(context).primaryColorDark, // Bord bleu foncé
                      width: 2.0,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Naviguer vers la page d'ajout d'événement
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventForm(),
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
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(),
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
