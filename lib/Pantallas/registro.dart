import 'package:codename_monumentapp/Logica/HelperUsuarios.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'inicio.dart';

class PantallaRegistro extends StatelessWidget {
  @override

  bool unico;
  bool conseguido;
  String nick;
  HelperUsuarios instancia;

  PantallaRegistro(HelperUsuarios a){
    this.instancia = a;
  }

  final TextEditingController c_nick = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //color: getSecundario(),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50), //...y he usado una SizedBox para
              Image.asset(
                'assets/logo.png',
                fit: BoxFit.contain,
                height: 128,
              ),
              SizedBox(height: 100),
              new Text('Parece que es tu primera vez en Monumentapp, ¡pon un nombre de usuario único!',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
              SizedBox(height: 100),
              TextField(
                autofocus: true,
                controller: c_nick,
                decoration: new InputDecoration(
                    labelText: 'Nombre de usuario', hintText: 'ej. "Niscalero_90"'),
              ),
              RaisedButton(
                onPressed: () {
                  validar(c_nick.text, context);
                  if (conseguido){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context){
                          return MyHomePage();
                        },
                      ),
                    );
                  }

                },
                //color: getPrimario(),
                child: const Text(
                  'Siguiente',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validar(String intento, BuildContext context) async {
    conseguido = false;
    bool mostrado = false;
    while (!conseguido || mostrado) {
      nick = intento;
      await instancia.comprobarNick(nick);
      if (instancia.unico) {
        instancia.nuevoUsuario();
        conseguido = true;
      } else if (!mostrado) {
        _showDialog(context);
        mostrado = true;
        conseguido = false;
      } else {
        mostrado = false;
      }
    }
  }

  void _showDialog(BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("¡Nombre de usuario ya existente!"),
          content: new Text("El nombre de usuario que has elegido ya está cogido. Por favor, vuelve a intentarlo."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Cerrar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}