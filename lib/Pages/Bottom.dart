import 'package:flutter/material.dart';

class MyBottomNavigationBar extends StatelessWidget {
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
      backgroundColor: Theme.of(context).primaryColor,
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
        print('Tapped on item $index');
      },
    );
  }
}
