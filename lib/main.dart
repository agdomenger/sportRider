import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/Bottom.dart';
import 'package:sport_rider/Pages/profil.dart';
import 'themes.dart';
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
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: ProfilePage(),
      ),
      //bottomNavigationBar: MyBottomNavigationBar(), il faut que ce soit seulement pour les pages une fois connecté
    );
  }
}
