import 'package:flutter/material.dart';

class EventWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String date;

  const EventWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.description,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String day = date.split('-')[2].split('T')[0];
    String month = getMonthName(int.parse(date.split('-')[1]));
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
          // Deuxième colonne (détails de l'événement)
          // Deuxième colonne (détails de l'événement)
          // Extraire le jour et le mois de la date

// Deuxième colonne (détails de l'événement)
          Expanded(
            flex: 7, // 70% de la largeur
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Titre et Date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Titre
                    Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // Date au format jj/mm
                    Text(
                      '$day $month',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
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

String getMonthName(int month) {
  switch (month) {
    case 1:
      return 'Janvier';
    case 2:
      return 'Février';
    case 3:
      return 'Mars';
    case 4:
      return 'Avril';
    case 5:
      return 'Mai';
    case 6:
      return 'Juin';
    case 7:
      return 'Juillet';
    case 8:
      return 'Août';
    case 9:
      return 'Septembre';
    case 10:
      return 'Octobre';
    case 11:
      return 'Novembre';
    case 12:
      return 'Décembre';
    default:
      return '';
  }
}
