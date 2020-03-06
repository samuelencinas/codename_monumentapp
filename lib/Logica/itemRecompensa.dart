import 'package:firebase_auth/firebase_auth.dart';

class ItemRecompensa {
  String nombre = "";
  String descripcion = "";
  int precio;

  ItemRecompensa(int tipo){
    switch (tipo){
      case 0: //Billete bus
        this.nombre = "Viaje Bus";
        this.descripcion = "Cangea tus ponches por un billete de autobus urbano!";
        this.precio = 400;
        break;
      case 1: //Zona hora
        this.nombre = "Aparcamiento gratis";
        this.descripcion = "Cangea tus ponches por 30 minotos gratis de zona ORA";
        this.precio = 200;
        break;
      case 2: //Pon nombre al bus
        this.nombre = "Pon tu nombre a un bus";
        this.descripcion = "Uno de los autobuses de Segovia llevará tu nombre!";
        this.precio = 205000;
        break;
        //TODO: Añadir más recompensas
    }

  }

}