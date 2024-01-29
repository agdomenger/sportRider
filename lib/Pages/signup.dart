import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  final Color backgroundColor;

  SignupPage({required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            CustomTextField(label: 'Full Name'),
            SizedBox(height: 16.0),
            CustomTextField(label: 'Email'),
            SizedBox(height: 16.0),
            CustomTextField(label: 'Password', obscureText: true),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Placeholder for signup logic
                print('Sign Up Button Pressed');
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                  foregroundColor: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).primaryColorDark),
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

  const CustomTextField({
    required this.label,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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
