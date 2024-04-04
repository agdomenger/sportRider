import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/AjoutCheval.dart'; // Assurez-vous que le fichier add_horse_page.dart est correctement importé

/*
widget de présentation de l'équidé
*/
class HorseWidget extends StatelessWidget {
  final String nom;
  final String elevage;
  final String annee;
  final String id_doc;

  HorseWidget(
      {required this.nom,
      required this.elevage,
      required this.annee,
      required this.id_doc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddHorsePage(
                    id_document: id_doc,
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
            color: Theme.of(context).shadowColor,
            width: 3.0,
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
                    '$nom $elevage',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).shadowColor,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    annee,
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
              alignment: Alignment.topRight,
              child: Container(
                width: 70,
                height: 70,
                child: Text(
                  "🐴",
                  style: TextStyle(fontSize: 60),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
