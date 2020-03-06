import 'dart:ui';

import 'package:flutter/material.dart';

const cPrimario = Color(0xFFf57f5b);
/**
const cSecundario = Color(0xFFb5e2e7);
const cAlarma = Color(0xFFb5e2e7);
const cGris = Color(0xFF36353f);
const cNegro = Color(0xFF181818);
    **/

Map<int, Color> colorPrimario =
{
  50: Color.fromRGBO(245, 127, 91, .1),
  100: Color.fromRGBO(245, 127, 91, .2),
  200: Color.fromRGBO(245, 127, 91, .3),
  300: Color.fromRGBO(245, 127, 91, .4),
  400: Color.fromRGBO(245, 127, 91, .5),
  500: Color.fromRGBO(245, 127, 91, .6),
  600: Color.fromRGBO(245, 127, 91, .7),
  700: Color.fromRGBO(245, 127, 91, .8),
  800: Color.fromRGBO(245, 127, 91, .9),
  900: Color.fromRGBO(245, 127, 91, 1),
};

MaterialColor primario = MaterialColor(0xFFf7f5b, colorPrimario);

MaterialColor getPrimario(){
  return primario;
}