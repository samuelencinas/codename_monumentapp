import 'package:firebase_auth/firebase_auth.dart';

class Usuario {

  bool nuevo;
  FirebaseUser user;
  String id = "";
  String nick = "";
  String nombre = "";
  String correo = "";
  String fotoPerfilURL = "";

  //Generar un Usuario a partir de un FirebaseUser
  Usuario(FirebaseUser user){
    if (user != null) {
      this.id = user.uid;
      this.user = user;
      this.nombre = user.displayName;
      this.fotoPerfilURL = user.photoUrl;
    } else {
      //this.user = user;
    }
  }









}
