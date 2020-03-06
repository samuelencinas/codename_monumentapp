import 'dart:ui';

import 'package:flutter/material.dart';

const cPrimario = Color(0xFFf57f5b);
const cSecundario = Color(0xFFb5e2e7);
const cAlarma = Color(0xFFea4130);
const cGris = Color(0xFF36353f);
const cNegro = Color(0xFF181818);

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

Map<int, Color> colorSecundario =
{
  50: Color.fromRGBO(181, 226, 231, .1),
  100: Color.fromRGBO(181, 226, 231, .2),
  200: Color.fromRGBO(181, 226, 231, .3),
  300: Color.fromRGBO(181, 226, 231, .4),
  400: Color.fromRGBO(181, 226, 231, .5),
  500: Color.fromRGBO(181, 226, 231, .6),
  600: Color.fromRGBO(181, 226, 231, .7),
  700: Color.fromRGBO(181, 226, 231, .8),
  800: Color.fromRGBO(181, 226, 231, .9),
  900: Color.fromRGBO(181, 226, 231, 1),
};

Map<int, Color> colorAlarma =
{
  100: Color.fromRGBO(234, 65, 48, .2),
  200: Color.fromRGBO(234, 65, 48, .3),
  300: Color.fromRGBO(234, 65, 48, .4),
  400: Color.fromRGBO(234, 65, 48, .5),
  500: Color.fromRGBO(234, 65, 48, .6),
  600: Color.fromRGBO(234, 65, 48, .7),
  700: Color.fromRGBO(234, 65, 48, .8),
  800: Color.fromRGBO(234, 65, 48, .9),
  900: Color.fromRGBO(234, 65, 48, 1),
};

Map<int, Color> colorGris =
{
  100: Color.fromRGBO(54, 53, 63, .2),
  200: Color.fromRGBO(54, 53, 63, .3),
  300: Color.fromRGBO(54, 53, 63, .4),
  400: Color.fromRGBO(54, 53, 63, .5),
  500: Color.fromRGBO(54, 53, 63, .6),
  600: Color.fromRGBO(54, 53, 63, .7),
  700: Color.fromRGBO(54, 53, 63, .8),
  800: Color.fromRGBO(54, 53, 63, .9),
  900: Color.fromRGBO(54, 53, 63, 1),
};

Map<int, Color> colorNegro =
{
  100: Color.fromRGBO(255, 24, 24, .2),
  200: Color.fromRGBO(255, 24, 24, .3),
  300: Color.fromRGBO(255, 24, 24, .4),
  400: Color.fromRGBO(255, 24, 24, .5),
  500: Color.fromRGBO(255, 24, 24, .6),
  600: Color.fromRGBO(255, 24, 24, .7),
  700: Color.fromRGBO(255, 24, 24, .8),
  800: Color.fromRGBO(255, 24, 24, .9),
  900: Color.fromRGBO(255, 24, 24, 1),
};

MaterialColor primario = MaterialColor(0xFFf7f5b, colorPrimario);
MaterialColor secundario = MaterialColor(0xFFb5e2e7, colorSecundario);
MaterialColor alarma = MaterialColor(0xFFea4130, colorAlarma);
MaterialColor gris = MaterialColor(0xFF36353f, colorGris);
MaterialColor negro = MaterialColor(0xFF181818, colorNegro);

MaterialColor getPrimario(){
  return primario;
}

MaterialColor getSecundario(){
  return secundario;
}

MaterialColor getAlarma(){
  return alarma;
}

MaterialColor getGris(){
  return gris;
}

MaterialColor getNegro(){
  return negro;
}