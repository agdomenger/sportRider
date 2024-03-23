import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;
  final String description;
  final DateTime date;

  const EventWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.time,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Première colonne (icône)
          Expanded(
            flex: 3, // 30% de la largeur
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centrage horizontal
              children: [
                SizedBox(
                  height: 10,
                ),
                Icon(
                  icon,
                  size: 50,
                  color: Theme.of(context).primaryColorDark,
                ),
              ],
            ),
          ),

          // Deuxième colonne (détails de l'événement)
          Expanded(
            flex: 7, // 70% de la largeur
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                // Horaire
                Text(
                  time,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 5),
                // Description
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
