import 'package:codename_monumentapp/Logica/HelperUsuarios.dart';
import 'package:codename_monumentapp/Logica/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar getCabecera(int s) {
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          fit: BoxFit.contain,
          height: 64,
        ),
        Container(
            padding: const EdgeInsets.all(20.0)

        ),
        Text(
            getTitulo(s),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
        )
      ],
    ),
  );
}

String getTitulo(int seleccion){
  switch (seleccion) {
    case 0:
      return "Mapa";
      break;
    case 1:
      return "Chat";
      break;
    case 2:
      return "Foro";
      break;
    case 3:
      return "Buscador";
      break;
    case 4:
      return "Mis lugares";
      break;
    case 5:
      return "Chat";
      break;
    default:
      return null;
      break;
  }
}

Drawer getMenu(FirebaseUser u, BuildContext context) {
  HelperUsuarios instancia = new HelperUsuarios(new Usuario(u), u);
  return new Drawer(
    child: new ListView(
      children: <Widget>[
        generarHeader(),
        ListTile(
          title: Text('Mis lugares guardados'),
          leading: Icon(Icons.home),
          //onTap: () => navegar(4, context, m),
        ),
        Divider(),
        ListTile(
          title: Text('Mis solicitudes de amistad'),
          leading: Icon(Icons.share),
        ), //ListTile
        ListTile(
          title: Text('Buscar usuarios'),
          leading: Icon(Icons.search),
          //onTap: () => navegar(3, context, m),
        ),
        Divider(),
        ListTile(
          title: Text('Salir de Monumentapp'),
          leading: Icon(Icons.exit_to_app),
          onTap: () {
            instancia.cerrarSesion(context);
          },
        ),
      ],
    ),
  );
}
void navegar(int indice, BuildContext context){
  Widget pagina;
  if (indice == 3){
    //pagina = Buscador();
  }
  if (indice == 4){
    //pagina = ListarSetas(m.setas);
  }
  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => pagina)
  );
}

/// Funciones relativas a dibujar la cabecera del usuario


UserAccountsDrawerHeader generarHeader() {
  return UserAccountsDrawerHeader(
      currentAccountPicture: getFoto(),
      accountName: getNombre(),
      accountEmail: getEmail()
  );
}
FutureBuilder getNombre() {
  return new FutureBuilder(
      future: dameNombre(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return RichText(
            text: new TextSpan(
              text: snapshot.data,
              style: new TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ); // your widget
        } else return CircularProgressIndicator();
      }
  );
}
Future<String> dameNombre() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('nickname');
}
FutureBuilder getEmail() {
  String estado;
  return new FutureBuilder(
      future: dameEmail(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Text("Cuenta de Google asociada:\n" + snapshot.data);// your widget
          //return Text(snapshot.data);
        } else return Text("Usuario registrado con Twitter");
      }
  );
}
Future<String> dameEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('correo');
}
FutureBuilder getFoto() {
  return new FutureBuilder(
      future: dameFoto(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return CircleAvatar(
            backgroundImage: NetworkImage(snapshot.data),
            //radius: 40,
          );
        } else {
          return Text("Error");
        }
      }
  );
}
Future<String> dameFoto() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('fotoUrl');
}
String setEstado(String estado){
  dameEstado(estado).whenComplete((){
    return estado;
  });
}
Future<String> dameEstado(String estado) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  estado = prefs.getString('estado');
}
