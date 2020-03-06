import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codename_monumentapp/Pantallas/iniciarsesion.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Usuario.dart';

class HelperUsuarios {
  /**
   * CLASE HelperUsuarios
   * Esta clase engloba todas las operaciones necesarias para gestionar usuarios.
   * Cada instancia de la clase.
   */
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Usuario usuario ;
  FirebaseUser user;
  bool nuevo;
  bool unico;

  HelperUsuarios(Usuario u, FirebaseUser b){
    if (usuario == null) {
      u = new Usuario(b);
    } else {
    }
    print(u.nick);
    this.usuario = u;
    this.user = b;
  }

  //MÉTODO (0): Devuelve el string del usuario actual
  String usuarioActual() {
    return usuario.id;
  }

  //MÉTODO (1): Iniciar sesión con Google
  Future<String> signInWithGoogle() async {


    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    print("Pasa el credential");

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    this.user = authResult.user;

    print("Pasa el signInWithCredential");
    // Comprobemos si los datos no están vacíos
    assert(this.user.email != null);
    assert(this.user.displayName != null);
    assert(this.user.photoUrl != null);

    print("Pasa las comprobaciones");

    usuario.nombre = this.user.displayName;
    usuario.correo = this.user.email;
    usuario.fotoPerfilURL = this.user.photoUrl;

    //4baseDatos(this.user);

    assert(!this.user.isAnonymous);
    assert(await this.user.getIdToken() != null);

    //prefs.setString('id', nombre);
    //prefs.setString('nombre', correo);

    //prefs.setString('fotoUrl', fotoPerfilURL);

    this.user = await _auth.currentUser();
    assert(this.user.uid == this.user.uid);

    return 'signInWithGoogle succeeded: $user';
  }
  //Método (1B): INICIAR SESIÓN con Twitter
  Future<String> twitterSignIn() async {
    var twitterInstance = new TwitterLogin(
      consumerKey: 'dowvn45Z171l7RwTpGKlKaJJ5',
      consumerSecret: 'uN07LGpX2hQFehXxR6s8WuGn1C2rrCKaJlMI1Z5juUomkfXsTp',
    );
    final TwitterLoginResult resultado = await twitterInstance.authorize();
    switch (resultado.status) {
      case TwitterLoginStatus.loggedIn:
        var sesion = resultado.session;
        final AuthCredential credencial = TwitterAuthProvider.getCredential(
          authToken: sesion.token,
          authTokenSecret: sesion.secret,
        );
        final AuthResult resultado2 = await _auth.signInWithCredential(
            credencial);
        this.user = resultado2.user;
        usuario.user = this.user;

        // Comprobemos si los datos no están vacíos
        assert(this.user.displayName != null);
        assert(this.user.photoUrl != null);

        usuario.nombre = user.displayName;
        usuario.correo = sesion.username;
        //usuario.estado = "Twitter";
        usuario.fotoPerfilURL = user.photoUrl;

        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        this.user = await _auth.currentUser();
        assert(this.user.uid == this.user.uid);

        return 'signInWithTwitter succeeded: $user';

      case TwitterLoginStatus.cancelledByUser:
        break;
      case TwitterLoginStatus.error:
        break;
    }
  }

  //Método (2): CERRAR SESIÓN GLOBAL
  void cerrarSesion(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var twitterInstance = new TwitterLogin(
      consumerKey: 'dowvn45Z171l7RwTpGKlKaJJ5',
      consumerSecret: 'uN07LGpX2hQFehXxR6s8WuGn1C2rrCKaJlMI1Z5juUomkfXsTp',
    );
    prefs?.clear();
    this.usuario = null;
    await twitterInstance.logOut();
    await googleSignIn.signOut();
    this.user = null;
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context){
              return LoginPage(user);
            }
        ),
            (Route<dynamic> route) => false
    );


  }
  //Método (3): Comprueba si el usuario existe en Firebase para ir a (4) o a (5)
  Future<void> baseDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool usuarioUnico;
    if (user != null) {
      // Comprobamos si existe ya el usuario de la base de datos
      final QuerySnapshot result =
      await Firestore.instance.collection('usuarios').where(
          'id', isEqualTo: user.uid).getDocuments();
      final List <DocumentSnapshot> documents = result.documents;
      this.usuario = new Usuario(user);
      if (documents.length == 0) {
        // Como es nuevo usuario... va a (4)
        nuevo = true;
      } else {
        this.usuario.nick = documents[0]['nickname'];
        // Si el usuario ya existe, va a (5)
        nuevo = false;
        /**
            await prefs.setString('id', documents[0]['id']);
            await prefs.setString('nombre', documents[0]['nombre']);
            await prefs.setString('nickname', documents[0]['nick']);
            await prefs.setString('photoUrl', documents[0]['fotoUrl']);
            await prefs.setString('email', documents[0]['email']);
            await prefs.setString('estado', usuario.estado);
         **/
      }
    }
  }

  //Método (4): El usuario no existe en Firebase (registrar)

  //4.1. Comprueba si el nick ya existe
  comprobarNick(String n) async {
    final QuerySnapshot result2 =
    await Firestore.instance.collection('usuarios').where(
        'nickname', isEqualTo: n).getDocuments();
    final List <DocumentSnapshot> documents2 = result2.documents;
    if (documents2.length == 0) {
      usuario.nick = n;
      this.unico = true;
    } else {
      this.unico = false;
    }
  }

  //4.2. El usuario no existe, lo registra.
  nuevoUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Firestore.instance.collection('usuarios')
        .document(user.uid)
        .setData(
        {
          'nombre': user.displayName,
          'fotoURL': user.photoUrl,
          'email': user.email,
          'id': user.uid,
          'nickname': usuario.nick,
        });

  }
  //Método (5): El usuario existe en Firebase pero está iniciando sesión en un dispositivo nuevo
  guardarLocal() async {
    //await poblarUsuario();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', user.uid);
    await prefs.setString('nombre', user.displayName);
    await prefs.setString('fotoUrl', user.photoUrl);
    await prefs.setString('correo', user.email);
    await prefs.setString('nickname', usuario.nick);
  }
  //Método (5-AUX): Puebla el usuario con los datos de Firebase
  poblarUsuario() async {
    final QuerySnapshot result = await Firestore.instance.collection('usuarios').where(
        'id', isEqualTo: user.uid).getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 1){
      usuario.nick = documents[0]['nick'];
      usuario.correo = documents[0]['email'];
    }
  }

//Método (6): Enviar solicitud de amistad a otro usuario

//Método (7): Aceptar o rechazar una solicitud de amistad

//Método (8): Listar solicitudes de amistad pendientes

//Método (9): Listar amigos

//Método (10): Buscador de usuarios


//Método (11): Enviar seta

}
