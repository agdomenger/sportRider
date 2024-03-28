import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importer la bibliothèque HTTP
import 'dart:convert';

import 'package:sport_rider/Pages/profil.dart';
import 'package:sport_rider/Pages/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String authMessage = ''; // Message d'authentification à afficher
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void navigateToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupPage()),
    );
  }

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
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(
              image: AssetImage('assets/logo.png'),
              width: 300,
              height: 300,
            ),
            SizedBox(height: 20),
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
                      'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/connect?email=${emailController.text}&password=${passwordController.text}'),
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
                    authMessage = 'Authentication refusée. Essayez à nouveau.';
                  });
                }
              },
              child: Text('connectez-vous'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              authMessage,
              style: TextStyle(
                color: Theme.of(context).canvasColor,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap:
                  navigateToSignUpPage, // Appeler la méthode lorsque l'utilisateur tape sur le texte
              child: Text(
                "Si vous n'avez pas de compte, inscrivez-vous",
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
