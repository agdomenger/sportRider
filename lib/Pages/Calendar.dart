import 'package:flutter/material.dart';
import 'package:sport_rider/Widgets/event.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
  final String id_doc; // L'ID ddu document firebase
  MyCalendar({required this.id_doc});
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Calendrier d\'événements'),
          backgroundColor: Theme.of(context).primaryColorLight,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Retour à la page précédente
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Calendrier
              TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                eventLoader: (day) {
                  List<Event> eventsForDay = [];
                  for (var event in _events) {
                    print(event.date);
                    if (isSameDay(event.date, day)) {
                      eventsForDay.add(event);
                    }
                  }
                  print('Events for $day: ${eventsForDay.length}');
                  return eventsForDay;
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarBuilders: CalendarBuilders(
                  markerBuilder: (context, day, events) {
                    if (events.isNotEmpty) {
                      return Positioned(
                        bottom: 0,
                        child: Row(
                          children: events.map((event) {
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2),
                              child: Text(
                                '🏆', // Emoji que vous souhaitez utiliser
                                style: TextStyle(
                                    fontSize: 16), // Taille de l'emoji
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),

              // Événements
              for (var event in _events) ...[
                EventWidget(
                  icon: Icons.fitness_center,
                  title: 'Séance de sport',
                  description: 'Entraînement de musculation',
                  date: event.date.toString(),
                ),
                EventWidget(
                  icon: Icons.restaurant,
                  title: 'Déjeuner',
                  description: 'Déjeuner avec des amis',
                  date: event.date.toString(),
                ),
                EventWidget(
                  icon: Icons.local_library,
                  title: 'Lecture',
                  description: 'Lecture du nouveau roman',
                  date: event.date.toString(),
                ),
              ],
            ],
          ),
        ),
      ),
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
