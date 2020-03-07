import 'package:codename_monumentapp/Auxiliar/Colores.dart';
import 'package:codename_monumentapp/Auxiliar/flip_bar_item.dart';
import 'package:codename_monumentapp/Auxiliar/flip_box_bar.dart';
import 'package:codename_monumentapp/Auxiliar/menu.dart';
import 'package:codename_monumentapp/Auxiliar/widgets.dart';
import 'package:codename_monumentapp/Auxiliar/zoomscaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_icon_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:provider/provider.dart';

class MyMaterialPage extends StatefulWidget {
  @override
  _MyMaterialPageState createState() => _MyMaterialPageState();
}

class _MyMaterialPageState extends State<MyMaterialPage> with TickerProviderStateMixin {
  MenuController menuController;

  @override
  void initState() {
    super.initState();

    menuController = new MenuController(
      vsync: this,
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => menuController,
      child: ZoomScaffold(
          menuScreen: MenuScreen(),
          contentScreen: Layout(
              contentBuilder: (cc) => generarContenido())
      ),
    );
  }

  Stack generarContenido(){
    double percent = 20;
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/acueducto.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
      ),
      Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.grey,
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black,
                ],
                stops: [
                  0.7,
                  1.0
                ])),
      ),
      Container(

        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 80, left: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: IconRoundedProgressBar(
                widthIconSection: 70,
                icon: Padding(
                    padding: EdgeInsets.all(8),
                    child: Image(
                      image: AssetImage(
                        'assets/ladrillo.png',
                      ),
                      fit: BoxFit.cover,
                    )),
                style: RoundedProgressBarStyle(
                    colorBackgroundIcon: Color(0xffc0392b),
                    colorProgress: Color(0xffe74c3c),
                    colorProgressDark: Color(0xffc0392b),
                    colorBorder: Color(0xff2c3e50),
                    backgroundProgress: Color(0xff4a627a),
                    borderWidth: 4,
                    widthShadow: 6),
                margin: EdgeInsets.symmetric(vertical: 16),
                borderRadius: BorderRadius.circular(6),
                percent: percent,
              ),

            ),
            Text(
              '¡Gana Ladrillos y ayuda a construir Segovia!',
              style: TextStyle(
                  fontSize: 28, color: devolverPrimario(), fontWeight: FontWeight.bold),
            ),
            Text(
              'También puedes ganar Ponchitos y conseguir fabulosas recompensas.',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Añade Segobricks viajando en bus urbano, utilizando las bicis del ayuntamiento o avisando de enseres abandonados.',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            WaterFallList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                  text: "Escanear QR o hacer foto",
                  color: Color(0xFFb5e2e7),
                )
              ],
            )
          ],
        ),
      ),
    ]);
  }
}