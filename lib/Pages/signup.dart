import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sport_rider/Pages/Login.dart'; // Importez la page de connexion pour la redirection

class SignupPage extends StatelessWidget {
  SignupPage();

  @override
  Widget build(BuildContext context) {
    TextEditingController prenomController = TextEditingController();
    TextEditingController nomController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    void navigateToLoginUpPage() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }

    return Scaffold(
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
            CustomTextField(
              label: 'Nom',
              controller: nomController,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              label: 'Prénom',
              controller: prenomController,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              label: 'Email',
              controller: emailController,
            ),
            SizedBox(height: 16.0),
            CustomTextField(
              label: 'Mot de passe',
              obscureText: true,
              controller: passwordController,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Créer un objet Compte à partir des données du formulaire
                final Map<String, dynamic> compteData = {
                  'prenom': prenomController.text,
                  'nom': nomController.text,
                  'email': emailController.text,
                  'passwordHash': passwordController.text,
                };

                // Envoyer les données du compte à votre API d'inscription
                final response = await http.post(
                  Uri.parse(
                      'https://api-sportrider-q2q3hzs-agdomenger.globeapp.dev/comptes'),
                  headers: <String, String>{
                    'Content-Type': 'application/json; charset=UTF-8',
                  },
                  body: jsonEncode(compteData),
                );

                if (response.statusCode == 201) {
                  // Le compte a été créé avec succès
                  // Rediriger l'utilisateur vers la page de connexion
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                } else {
                  // Gérer les cas d'erreur
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to sign up. Please try again.'),
                    ),
                  );
                }
              },
              child: Text('S\'inscrire'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).primaryColorDark,
              ),
            ),
            GestureDetector(
              onTap:
                  navigateToLoginUpPage, // Appeler la méthode lorsque l'utilisateur tape sur le texte
              child: Text(
                "Vous avez déjà un compte? connectez-vous",
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

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    required this.label,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
        ),
        labelStyle: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
