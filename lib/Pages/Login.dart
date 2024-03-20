import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importer la bibliothèque HTTP
import 'dart:convert';

import 'package:sport_rider/Pages/profil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String authMessage = ''; // Message d'authentification à afficher
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Méthode pour naviguer vers la page de profil après une connexion réussie
  void navigateToProfilePage(String id_doc) {
    String id = "";
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => ProfilePage(
                id_doc: id_doc,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorDark),
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColorDark),
                ),
                labelStyle: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Utilisez la bibliothèque http pour envoyer une requête à votre API d'authentification
                final response = await http.get(
                  Uri.parse(
                      'http://localhost:8080/connect?email=${emailController.text}&password=${passwordController.text}'),
                  headers: <String, String>{
                    'Content-Type': 'application/json',
                  },
                );

                if (response.statusCode == 200) {
                  // Authentification réussie
                  final email = emailController.text;
                  print(jsonDecode(response.body)['documentReference']);

                  var id = jsonDecode(response.body)['documentReference'];
                  // Mettre à jour la variable id du state
                  setState(() {
                    id = id;
                  });
                  // je veux initialiser le string dans login page en mode widget.id = jsonDecode(response.body)['documentReference']
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Bonjour $email'),
                        content: Text('Vous êtes connecté!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              navigateToProfilePage(id);
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Authentification échouée
                  setState(() {
                    authMessage = 'Authentication failed. Please try again.';
                  });
                }
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              authMessage,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            // ... (votre code pour le bouton Sign up)
          ],
        ),
      ),
    );
  }
}
