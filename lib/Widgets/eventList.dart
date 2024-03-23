import 'package:flutter/material.dart';
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
      events.sort((a, b) =>
          DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));

      final numberOfEvents = numberOfEventsToShow ?? events.length;
      final displayedEvents = events.take(numberOfEvents).toList();

      return Column(
        children: displayedEvents.map<Widget>((event) {
          return EventWidget(
            icon: Icons.fitness_center,
            title: event['title'],
            time: event['time'],
            description: event['description'],
            date: event['date'],
          );
        }).toList(),
      );
    }
  }
}
