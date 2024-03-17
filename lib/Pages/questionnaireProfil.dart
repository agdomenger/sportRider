import 'package:flutter/material.dart';

import '../themes.dart';

void main() {
  runApp(QuestionnaireApp());
}

class QuestionnaireApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questionnaire Équestre',
      theme: myTheme,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColorLight,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Retour à la page précédente
            },
          ),
        ),
        body: SingleChildScrollView(
          child: QuestionnaireScreen(),
        ),
      ),
    );
  }
}

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  String categorieAge = "";
  bool faitCompetitions = false;
  String categorieCompetition = "";
  String niveauEpreuve = "";
  String discipline = "";
  String frequenceEquitation = "";
  String frequenceAutreActivite = "";
  String typeProgrammeSportif = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context)
          .primaryColor, // Choisissez la couleur de fond souhaitée
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question 1
            Text(
              '1. Quelle est votre catégorie d\'âge ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.5,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            RadioListTile(
              title: Text('15 ans et moins'),
              value: 'a',
              groupValue: categorieAge,
              onChanged: (value) {
                setState(() {
                  categorieAge = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('16 à 40 ans'),
              value: 'b',
              groupValue: categorieAge,
              onChanged: (value) {
                setState(() {
                  categorieAge = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('+ de 40 ans'),
              value: 'c',
              groupValue: categorieAge,
              onChanged: (value) {
                setState(() {
                  categorieAge = value!;
                });
              },
            ),

            // Question 2
            Text(
              '2. Faites-vous des compétitions ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.5,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            RadioListTile(
              title: Text('Oui'),
              value: true,
              groupValue: faitCompetitions,
              onChanged: (value) {
                setState(() {
                  faitCompetitions = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Non'),
              value: false,
              groupValue: faitCompetitions,
              onChanged: (value) {
                setState(() {
                  faitCompetitions = value!;
                });
              },
            ),

            // Questions compétitions (si oui)
            if (faitCompetitions)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dans quelle catégorie ?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  RadioListTile(
                    title: Text('Poney'),
                    value: 'a',
                    groupValue: categorieCompetition,
                    onChanged: (value) {
                      setState(() {
                        categorieCompetition = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Club'),
                    value: 'b',
                    groupValue: categorieCompetition,
                    onChanged: (value) {
                      setState(() {
                        categorieCompetition = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Amateur'),
                    value: 'c',
                    groupValue: categorieCompetition,
                    onChanged: (value) {
                      setState(() {
                        categorieCompetition = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Pro'),
                    value: 'd',
                    groupValue: categorieCompetition,
                    onChanged: (value) {
                      setState(() {
                        categorieCompetition = value!;
                      });
                    },
                  ),
                  Text(
                    'Quel niveau d\'épreuve ?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  RadioListTile(
                    title: Text('4'),
                    value: 'a',
                    groupValue: niveauEpreuve,
                    onChanged: (value) {
                      setState(() {
                        niveauEpreuve = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('3 et 2'),
                    value: 'b',
                    groupValue: niveauEpreuve,
                    onChanged: (value) {
                      setState(() {
                        niveauEpreuve = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('1'),
                    value: 'c',
                    groupValue: niveauEpreuve,
                    onChanged: (value) {
                      setState(() {
                        niveauEpreuve = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Elite'),
                    value: 'd',
                    groupValue: niveauEpreuve,
                    onChanged: (value) {
                      setState(() {
                        niveauEpreuve = value!;
                      });
                    },
                  ),
                  Text(
                    'Quelle discipline ?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.5,
                      color: Theme.of(context).primaryColorDark,
                    ),
                  ),
                  RadioListTile(
                    title: Text('Dressage'),
                    value: 'a',
                    groupValue: discipline,
                    onChanged: (value) {
                      setState(() {
                        discipline = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('CSO'),
                    value: 'b',
                    groupValue: discipline,
                    onChanged: (value) {
                      setState(() {
                        discipline = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('CCE'),
                    value: 'c',
                    groupValue: discipline,
                    onChanged: (value) {
                      setState(() {
                        discipline = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Hunter'),
                    value: 'd',
                    groupValue: discipline,
                    onChanged: (value) {
                      setState(() {
                        discipline = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Trec'),
                    value: 'e',
                    groupValue: discipline,
                    onChanged: (value) {
                      setState(() {
                        discipline = value!;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('Autre'),
                    value: 'f',
                    groupValue: discipline,
                    onChanged: (value) {
                      setState(() {
                        discipline = value!;
                      });
                    },
                  ),
                ],
              ),
            // Question 3
            Text(
              '3. À quelle fréquence pratiquez-vous l\'équitation ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.5,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            RadioListTile(
              title: Text('Rarement'),
              value: 'a',
              groupValue: frequenceEquitation,
              onChanged: (value) {
                setState(() {
                  frequenceEquitation = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('1 fois par semaine'),
              value: 'b',
              groupValue: frequenceEquitation,
              onChanged: (value) {
                setState(() {
                  frequenceEquitation = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('1 à 2 fois'),
              value: 'c',
              groupValue: frequenceEquitation,
              onChanged: (value) {
                setState(() {
                  frequenceEquitation = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('2 à 4 fois'),
              value: 'd',
              groupValue: frequenceEquitation,
              onChanged: (value) {
                setState(() {
                  frequenceEquitation = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Quasi quotidiennement / Quotidiennement'),
              value: 'e',
              groupValue: frequenceEquitation,
              onChanged: (value) {
                setState(() {
                  frequenceEquitation = value!;
                });
              },
            ),

// Question 4
            Text(
              '4. À quelle fréquence pratiquez-vous une activité physique autre ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.5,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            RadioListTile(
              title: Text('Jamais'),
              value: 'a',
              groupValue: frequenceAutreActivite,
              onChanged: (value) {
                setState(() {
                  frequenceAutreActivite = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Rarement'),
              value: 'b',
              groupValue: frequenceAutreActivite,
              onChanged: (value) {
                setState(() {
                  frequenceAutreActivite = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('1 fois par semaine'),
              value: 'c',
              groupValue: frequenceAutreActivite,
              onChanged: (value) {
                setState(() {
                  frequenceAutreActivite = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('- de 4 fois par semaine'),
              value: 'd',
              groupValue: frequenceAutreActivite,
              onChanged: (value) {
                setState(() {
                  frequenceAutreActivite = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Quotidiennement'),
              value: 'e',
              groupValue: frequenceAutreActivite,
              onChanged: (value) {
                setState(() {
                  frequenceAutreActivite = value!;
                });
              },
            ),

// Question 5
            Text(
              '5. Quel type de programme sportif souhaitez-vous ?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.5,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
            RadioListTile(
              title: Text('Remise en forme'),
              value: 'a',
              groupValue: typeProgrammeSportif,
              onChanged: (value) {
                setState(() {
                  typeProgrammeSportif = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Entraînement régulier'),
              value: 'b',
              groupValue: typeProgrammeSportif,
              onChanged: (value) {
                setState(() {
                  typeProgrammeSportif = value!;
                });
              },
            ),
            RadioListTile(
              title: Text('Entraînement intensif'),
              value: 'c',
              groupValue: typeProgrammeSportif,
              onChanged: (value) {
                setState(() {
                  typeProgrammeSportif = value!;
                });
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Ajoutez ici le code pour traiter l'envoi du questionnaire
                  // Vous pouvez par exemple afficher un message de confirmation
                  // ou envoyer les réponses à un serveur.
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        title: Text(
                          'Questionnaire envoyé !',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        content: Text(
                          'Merci pour vos réponses.',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        actions: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              side: BorderSide(
                                  color: Theme.of(context).primaryColorDark,
                                  width: 2.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Fermer',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorDark),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).shadowColor,
                  backgroundColor: Theme.of(context).primaryColor,
                  side: BorderSide(
                      color: Theme.of(context).shadowColor, width: 2.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Envoyer',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
