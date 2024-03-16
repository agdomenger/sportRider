import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MyCalendar extends StatefulWidget {
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
        appBar: AppBar(
          title: Text('Calendrier d\'événements'),
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
                                '🎉', // Emoji que vous souhaitez utiliser
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
                  time: '10:00 - 11:00',
                  description: 'Entraînement de musculation',
                  date: event.date,
                ),
                EventWidget(
                  icon: Icons.restaurant,
                  title: 'Déjeuner',
                  time: '12:00 - 13:00',
                  description: 'Déjeuner avec des amis',
                  date: event.date,
                ),
                EventWidget(
                  icon: Icons.local_library,
                  title: 'Lecture',
                  time: '15:00 - 16:00',
                  description: 'Lecture du nouveau roman',
                  date: event.date,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

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
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icone
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Icon(
              icon,
              size: 40,
            ),
          ),
          SizedBox(width: 10),
          // Détails de l'événement
          Expanded(
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
