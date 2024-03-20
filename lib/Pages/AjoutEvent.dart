import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventForm extends StatefulWidget {
  final String id_document;

  EventForm({this.id_document = ''});
  @override
  _EventFormState createState() => _EventFormState();
}

class _EventFormState extends State<EventForm> {
  late String id_doc;

  @override
  void initState() {
    super.initState();
    id_doc = widget.id_document;
  }

  String title = '';
  String description = '';
  DateTime? selectedDate;
  String eventType = '';
  String subEventType = '';
  String horseName = '';

  ButtonStyle selectedButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: Colors.blue,
      onPrimary: Colors.white,
      side: BorderSide(color: Colors.blue),
      minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 20),
      padding: EdgeInsets.all(16),
      textStyle: TextStyle(fontSize: 18),
    );
  }

  ButtonStyle unselectedButtonStyle() {
    return ElevatedButton.styleFrom(
      primary: Colors.white,
      onPrimary: Colors.blue,
      side: BorderSide(color: Colors.blue),
      minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 20),
      padding: EdgeInsets.all(16),
      textStyle: TextStyle(fontSize: 18),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(
                "Ajoutez un nouvel évènement",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              SizedBox(height: 50.0),
              Text('Titre'),
              TextField(
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
              ),
              SizedBox(height: 30),
              Text('Description de l\'événement...'),
              TextField(
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text('Date'),
                  SizedBox(width: 30),
                  InkWell(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2022),
                        lastDate: DateTime(2025),
                      );

                      if (pickedDate != null && pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate;
                        });
                      }
                    },
                    child: Icon(Icons.calendar_today),
                  ),
                  SizedBox(width: 20),
                  Text(
                    selectedDate != null
                        ? 'Date sélectionnée : ${DateFormat('dd/MM/yyyy').format(selectedDate!)}'
                        : 'Sélectionnez une date',
                  ),
                ],
              ),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        eventType = 'Équestre';
                        subEventType = '';
                      });
                    },
                    style: eventType == 'Équestre'
                        ? selectedButtonStyle()
                        : unselectedButtonStyle(),
                    child: Text('Équestre'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        eventType = 'Mentale';
                        subEventType = '';
                      });
                    },
                    style: eventType == 'Mentale'
                        ? selectedButtonStyle()
                        : unselectedButtonStyle(),
                    child: Text('Mentale'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        eventType = 'Physique';
                        subEventType = '';
                      });
                    },
                    style: eventType == 'Physique'
                        ? selectedButtonStyle()
                        : unselectedButtonStyle(),
                    child: Text('Physique'),
                  ),
                ],
              ),
              if (eventType == 'Équestre') ...[
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Saut';
                        });
                      },
                      style: subEventType == 'Saut'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Saut'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Dressage';
                        });
                      },
                      style: subEventType == 'Dressage'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Dressage'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Balade';
                        });
                      },
                      style: subEventType == 'Balade'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Balade'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Autre';
                        });
                      },
                      style: subEventType == 'Autre'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Autre'),
                    ),
                  ],
                ),
              ] else if (eventType == 'Mentale') ...[
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Preparation concours';
                        });
                      },
                      style: subEventType == 'Preparation concours'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Préparation concours'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Médiation';
                        });
                      },
                      style: subEventType == 'Médiation'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Médiation'),
                    ),
                  ],
                ),
              ] else if (eventType == 'Physique') ...[
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Entrainement';
                        });
                      },
                      style: subEventType == 'Entrainement'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Entrainement'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Footing';
                        });
                      },
                      style: subEventType == 'Footing'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Footing'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Salle de sport';
                        });
                      },
                      style: subEventType == 'Salle de sport'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Salle de sport'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          subEventType = 'Autre';
                        });
                      },
                      style: subEventType == 'Autre'
                          ? selectedButtonStyle()
                          : unselectedButtonStyle(),
                      child: Text('Autre'),
                    ),
                  ],
                ),
              ],
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    _showAddEventPopup();
                  },
                  style: unselectedButtonStyle(),
                  child: Text('Valider l\'événement'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddEventPopup() {
    // Code pour afficher le pop-up d'ajout d'événement
  }
}
