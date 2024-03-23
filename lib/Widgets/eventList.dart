import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sport_rider/Widgets/event.dart';

class EventListWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final int? numberOfEventsToShow;

  EventListWidget({required this.userData, this.numberOfEventsToShow});

  @override
  Widget build(BuildContext context) {
    final events = userData['evenements'] ?? [];
    if (events.isEmpty) {
      return Text(
        "Pas d'événements prévus pour l'instant",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      );
    } else {
      events.sort((a, b) {
        print('Type de a["date"]: ${a["date"].runtimeType}');
        print('Type de b["date"]: ${b["date"].runtimeType}');

        final DateFormat dateFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");

        final DateTime dateTimeA = dateFormat.parse(a['date']);
        final DateTime dateTimeB = dateFormat.parse(b['date']);

        return dateTimeA.compareTo(dateTimeB);
      });

      final numberOfEvents = numberOfEventsToShow ?? events.length;
      final displayedEvents = events.take(numberOfEvents).toList();

      return Column(
        children: displayedEvents.map<Widget>((event) {
          return EventWidget(
            icon: Icons.fitness_center,
            title: event['titre'],
            description: event['description'],
            date: event['date'],
          );
        }).toList(),
      );
    }
  }
}
