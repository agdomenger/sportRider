import 'package:flutter/material.dart';
import 'signup.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                labelStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Placeholder for login logic
                print('Login Button Pressed');
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColorLight,
                  backgroundColor: Theme.of(context).primaryColorDark),
            ),
            SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignupPage(
                      backgroundColor: Theme.of(context).primaryColorLight,
                    ),
                  ),
                );
              },
              child: Text('Don\'t have an account? Sign up'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).primaryColorDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
