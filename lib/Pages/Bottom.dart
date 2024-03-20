import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/AjoutEvent.dart'; // Importez vos pages ici
import 'package:sport_rider/Pages/Calendar.dart';
import 'package:sport_rider/Pages/Sport.dart';
import 'package:sport_rider/Pages/questionnaireProfil.dart';

class MyBottomNavigationBar extends StatelessWidget {
  final String id_doc; // L'ID de la page

  MyBottomNavigationBar({required this.id_doc});

  // Fonction pour créer un élément BottomNavigationBarItem avec une icône spécifique
  BottomNavigationBarItem _createBottomNavItem(
      IconData icon, BuildContext context) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(top: 18.0), // Ajoutez une marge en haut
        child: Icon(
          icon,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
      label: '', // Laissez le label vide
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColorDark,
      iconSize: 30.0,
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 0.0,
      items: [
        _createBottomNavItem(Icons.date_range, context),
        _createBottomNavItem(Icons.fitness_center, context),
        _createBottomNavItem(Icons.psychology, context),
      ],
      onTap: (int index) {
        // Ajoutez votre logique de navigation ici en fonction de l'index
        // Par exemple, utilisez un Navigator pour changer d'écran
        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MyCalendar(
                        id_doc: id_doc,
                      )),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SportPage(
                        id_doc: id_doc,
                      )),
            );
            break;
          case 2:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TodoPage()),
            );
            break;
        }
      },
    );
  }
}

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text('Preparation mentale'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Retour à la page précédente
          },
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Text(
          'Cette page n\'est pas implémentée dans le cadre du P2i',
          style: TextStyle(fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
