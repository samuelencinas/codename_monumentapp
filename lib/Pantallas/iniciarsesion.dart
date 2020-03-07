import 'package:codename_monumentapp/Logica/HelperUsuarios.dart';
import 'package:codename_monumentapp/Logica/Usuario.dart';
import 'package:codename_monumentapp/Pantallas/registro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  final FirebaseUser u;

  LoginPage(this.u);

  @override
  _LoginPageState createState() => _LoginPageState(u);
}

class _LoginPageState extends State<LoginPage> {
  Usuario u;
  HelperUsuarios a;
  _LoginPageState(FirebaseUser a){
    this.u = new Usuario(a);
    this.a = new HelperUsuarios(u, u.user);
    print("A");
  }
  bool flag = false;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
              new Text('Bienvenido a Monumentapp',
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                ),),
              SizedBox(height: 100),
              _signInButton(),
              _TwitterButton(),
            ],
          ),
        ),
      ),
    );
  }

  //Botón de inicio de sesión
  Widget _signInButton() {
    return FlatButton(
      //splashColor: getPrimario(),
      //Al presionar...
      onPressed: () {
        //Cuando se complete el inicio de sesión...
        a.signInWithGoogle().whenComplete(() {
          a.baseDatos().whenComplete((){
            if (a.nuevo){
              //¡Paso de página!
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PantallaRegistro(a);
                  },
                ),
              );
            } else {
              a.guardarLocal().whenComplete(() {
                //¡Paso de página!
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyMaterialPage();
                    },
                  ),
                );
              });
            }
          });
        });
      },

      //Aquí damos forma al botón
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          //side: BorderSide(color: getPrimario())
      ),

      //Y aquí ajustamos el padding
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Iniciar sesión con Google',
                style: TextStyle(
                  fontSize: 20,
                  //color: getPrimario(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget _TwitterButton() {
    return FlatButton(
      //splashColor: getPrimario(),

      //Al presionar...
      onPressed: () {
        //Cuando se complete el inicio de sesión...
        a.twitterSignIn().whenComplete(() {
          //a.usuario.estado = "Twitter";
          a.baseDatos().whenComplete(() {
            if (a.nuevo) {
              //¡Paso de página!
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return PantallaRegistro(a);
                  },
                ),
              );
            } else {
              a.guardarLocal().whenComplete(() {
                //¡Paso de página!
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return MyMaterialPage();
                    },
                  ),
                );
              });
            }
          });
        });
      },

      //Aquí damos forma al botón
      shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(18.0),
          //side: BorderSide(color: getPrimario())
      ),

      //Y aquí ajustamos el padding
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),

        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/twitter_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Iniciar sesión con Twitter',
                style: TextStyle(
                  fontSize: 20,
                  //color: getPrimario(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}