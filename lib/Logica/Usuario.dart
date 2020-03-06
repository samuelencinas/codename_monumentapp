import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class Usuario {

  bool nuevo;
  FirebaseUser user;
  String id = "";
  String nick = "";
  String nombre = "";
  String correo = "";
  String fotoPerfilURL = "";
  //Monedas:
  int segobricks = 0;//exp
  int baseSegoBricks = 64;
  double expSegoBricks = 2.5;
  int ponches = 0;//dinero
  //varibales de racha:
  final double bonificadorRacha = 1.5;
  bool racha = false;

  int rango; // de 1 a 10

  //Generar un Usuario a partir de un FirebaseUser
  Usuario(FirebaseUser user){
    if (user != null) {
      this.id = user.uid;
      this.user = user;
      this.nombre = user.displayName;
      this.fotoPerfilURL = user.photoUrl;
      this.segobricks = 0;
      this.ponches = 0;
      this.rango = 1;
      this.racha = false;


    } else {
      //this.user = user;
    }
  }

  sumarSegoBricks(int base){
    Random rand = new Random(new DateTime.now().millisecondsSinceEpoch);
    double delta = base*(0.5-rand.nextDouble())/8;

    if(racha) {
      this.segobricks = (this.segobricks + base * this.bonificadorRacha + delta).round();
      this.ponches = (this.ponches + base * this.bonificadorRacha + delta).round();
    }else{
      this.segobricks = (this.segobricks + base * this.bonificadorRacha + delta).round();
      this.ponches = (this.ponches + base + delta).round();

    }

    if(this.segobricks >= rangoSegobricks()){
      //Subir de rango! TODO: Generar evento
      this.segobricks = (this.segobricks - rangoSegobricks()).round();
      this.rango++;
    }
  }

  rangoSegobricks(){
    return this.baseSegoBricks*(pow(this.rango,this.expSegoBricks));
  }







}
