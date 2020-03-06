import 'package:codename_monumentapp/Auxiliar/cabecera.dart';
import 'package:codename_monumentapp/Logica/HelperUsuarios.dart';
import 'package:codename_monumentapp/Logica/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  HelperUsuarios instancia2;
  static FirebaseUser actual;

  MyHomePage(){
  }


  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  HelperUsuarios instancia;
  FirebaseUser actual;
  String p;
  String q;
  int _indice = 0;

  _getActual() async {
    actual = await FirebaseAuth.instance.currentUser();
  }


  MyHomePageState() {
    _getActual().whenComplete(() {
      print("ESTOY AQUI");
      Usuario u = new Usuario(actual);
      instancia = new HelperUsuarios(u, actual);
      p = instancia.usuario.id;
      print(p);
      print(q);
    });
  }


  var _paginas = [
    //new Mapa(), //(0) Inicio
    //chat2(), //(1) Chat
    //foro(), //(2) Foro
    //new Buscador(), //(3) Buscador

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCabecera(_indice),
      drawer: getMenu(actual, context),
      //body: _indice == 0 ? mActual : _paginas[_indice],
      /**
       * PIE DE PÁGINA
       */
      bottomNavigationBar: generarBarra(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  BottomNavigationBar generarBarra() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[

        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Inicio')),
        //BottomNavigationBarItem(icon: Icon(Icons.explore), title: Text('Explorar')),
        BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text('Chat')),
        BottomNavigationBarItem(icon: Icon(Icons.forum), title: Text('Foro')),

      ],
      //unselectedItemColor: getSecundario(),
      //unselectedLabelStyle: TextStyle(color: getSecundario()),
      //selectedItemColor: getPrimario(),
      currentIndex: _indice,
      //onTap: accionAlPulsar,

    );
  }
}

