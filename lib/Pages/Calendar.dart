import 'package:flutter/material.dart';
import 'package:sport_rider/Widgets/event.dart';
import 'package:sport_rider/Widgets/eventList.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyCalendar extends StatefulWidget {
  final String id_doc; // L'ID du document Firebase
  MyCalendar({required this.id_doc});
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  late Future<Map<String, dynamic>> _userData = _fetchUserData();

  Future<Map<String, dynamic>> _fetchUserData() async {
    final response = await http.get(Uri.parse(
        'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/comptes/${widget.id_doc}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final userData = snapshot.data!;
            List<dynamic> events = userData['evenements'] ?? [];
            return SingleChildScrollView(
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
                      List<dynamic> eventsForDay = [];
                      for (var event in events) {
                        if (isSameDay(DateTime.parse(event['date']), day)) {
                          eventsForDay.add(event);
                        }
                      }
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
                                if (event is Map<String, dynamic>) {
                                  final tag = event['tag'] as String?;
                                  if (tag != null) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2),
                                      child: Text(
                                        getEventEmoji(
                                            tag), // Emoji que vous souhaitez utiliser
                                        style: TextStyle(
                                          fontSize: 16,
                                        ), // Taille de l'emoji
                                      ),
                                    );
                                  }
                                }
                                return SizedBox.shrink();
                              }).toList(),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Les évènements à venir : ',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                  ),
                  // Liste des événements
                  EventListWidget(userData: userData),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

bool isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

String getEventEmoji(String tag) {
  switch (tag) {
    case 'concours':
      return '🏆'; // Emoji pour un concours
    case 'mental':
      return '💡'; // Emoji pour le mental
    case 'sport':
      return '🏋️'; // Emoji pour le sport
    case 'cheval':
      return '🐎'; // Emoji pour le cheval
    case 'balade':
      return '🍃'; // Emoji pour la balade
    default:
      return '📅'; // Emoji par défaut
  }
}
