import 'package:codename_monumentapp/Pantallas/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Auxiliar/Colores.dart';
import 'Pantallas/iniciarsesion.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Zoom Menu',
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.green,
      ),
      home: new MyMaterialPage(),
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
            return MyMaterialPage();
          } //if
          return LoginPage(user);
        } //builder
    );
  }
}
