import 'package:flutter/material.dart';
import 'package:sport_rider/Pages/profil.dart';
import 'themes.dart';
import 'package:firedart/firedart.dart';
import 'Pages/Login.dart';

void main() async {
  // Initialisez Firebase avec la clé d'API et le gestionnaire de jetons
  final firebase = Firestore.initialize('data-5b679');
  var tokenStore = MyCustomTokenStore();
  final firebaseAuth = FirebaseAuth.initialize(
      'AIzaSyDRzzZT9gYFShI9OnWuosB80SXtEDg4p2c', tokenStore);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: myTheme,
      home: LoginPage(), // Redirection en fonction de la connexion
    );
  }
}

/*
fonction sur mesure pour la gestion du custom */
class MyCustomTokenStore implements TokenStore {
  String? _token;

  @override
  Future<void> clear() async {
    _token = null;
  }

  @override
  void delete() {
    // TODO: implement delete
  }

  @override
  void expireToken() {
    // TODO: implement expireToken
  }

  @override
  // TODO: implement expiry
  DateTime? get expiry => throw UnimplementedError();

  @override
  // TODO: implement hasToken
  bool get hasToken => throw UnimplementedError();

  @override
  // TODO: implement idToken
  String? get idToken => throw UnimplementedError();

  @override
  Token? read() {
    return _token != null
        ? Token(
            _token!,
            DateTime.now().add(const Duration(hours: 1)).toString(),
            DateTime.now().toString(),
            DateTime.now())
        : null;
  }

  @override
  // TODO: implement refreshToken
  String? get refreshToken => throw UnimplementedError();

  @override
  void setToken(
      String? userId, String idToken, String refreshToken, int expiresIn) {
    // TODO: implement setToken
  }

  @override
  // TODO: implement userId
  String? get userId => throw UnimplementedError();

  @override
  void write(Token? token) {
    if (token != null) {
      _token = token as String?;
    }
  }
}
