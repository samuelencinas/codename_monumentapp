import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Auxiliar/Colores.dart';
import 'Pantallas/iniciarsesion.dart';
import 'Pantallas/inicio.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
      //primaryColor: getPrimario(),
    ),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseUser usuarioFirebase;

  @override
  Widget build(BuildContext context) {
    //new _comprobarUsuario(usuarioFirebase);
    return new SplashScreen(
        seconds: 4,
        //navigateAfterSeconds: new _comprobarUsuario(usuarioFirebase),
        navigateAfterSeconds: new MyHomePage(),
        title: new Text('Espera mientras cargamos todo...',
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0
          ),),
        image: new Image.asset("assets/logo.png"),
        //backgroundColor: getSecundario(),
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: getPrimario()
    );

  }



}

class _comprobarUsuario extends StatelessWidget {
  FirebaseUser user;
  String nick;

  getUsuarioActual() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    nick = prefs.getString('nickname');
  }

  _comprobarUsuario(FirebaseUser u) {
    this.user = u;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data; // this is your user instance
            return MyHomePage();
          } //if
          return LoginPage(user);
        } //builder
    );
  }
}
