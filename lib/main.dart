import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/AjoutEvent.dart';
import 'package:sport_rider/Pages/Bottom.dart';
import 'package:sport_rider/Pages/Calendar.dart';
import 'package:sport_rider/Pages/Sport.dart';
import 'package:sport_rider/Pages/profil.dart';
import 'package:sport_rider/Pages/questionnaireProfil.dart';
import 'themes.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Pages/Login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      home: const MyHomePage(title: 'SportRider'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: MyCalendar(),
      ),
      //bottomNavigationBar: MyBottomNavigationBar(), il faut que ce soit seulement pour les pages une fois connecté
    );
  }
}

Future<List<dynamic>> fetchComptes() async {
  final response = await http.get(Uri.parse('http://localhost:8080/comptes'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load comptes');
  }
}

class ComptesWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des comptes'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchComptes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          } else {
            final comptes = snapshot.data!;
            return ListView.builder(
              itemCount: comptes.length,
              itemBuilder: (context, index) {
                final compte = comptes[index];
                return ListTile(
                  title: Text(compte['email']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
