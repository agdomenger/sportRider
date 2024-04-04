import 'package:flutter/material.dart';

/*
Widget rectangulaire pour l'apparence des evenements dans la page d'accueil et la page calendrier 
*/
class EventWidget extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String tag;

  const EventWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.date,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String day = date.split('-')[2].split('T')[0];
    String month = getMonthName(int.parse(date.split('-')[1]));
    String emoji;
    switch (tag) {
      case 'concours':
        emoji = '🏆'; // Emoji pour un concours
        break;
      case 'mental':
        emoji = '💡'; // Emoji pour le mental
        break;
      case 'sport':
        emoji = '🏋️'; // Emoji pour le sport
        break;
      case 'cheval':
        emoji = '🐎'; // Emoji pour le cheval
        break;
      case 'balade':
        emoji = '🍃'; // Emoji pour la balade
        break;
      default:
        emoji = '📅'; // Emoji par défaut
    }
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
          // Première colonne (emoji)
          Expanded(
            flex: 3, // 30% de la largeur
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Centrage horizontal
              children: [
                Text(
                  emoji,
                  style: TextStyle(fontSize: 40),
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

// pour avoir la date à un format plus digest
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
