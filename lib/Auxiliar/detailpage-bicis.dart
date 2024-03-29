import 'package:flutter/material.dart';

import 'constants.dart';
import 'widgets.dart';

class DetailPage extends StatelessWidget {
  final int index;

  DetailPage({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: _height * 0.4 + 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(images[index]), fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: _height * 0.6,
              padding: const EdgeInsets.only(top: 16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      topLeft: Radius.circular(16.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Number',
                                style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 40,
                                child: NumberSelector(),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(20.0),
                              child: Table(
                                border: TableBorder.all(color: Colors.black),
                                children: [
                                  TableRow(children: [
                                    Text('Día'),
                                    Text('Duración'),
                                    Text('Recompensa'),
                                  ]),
                                  TableRow(children: [
                                    Text('05 / 03 / 2020'),
                                    Text('2 horas'),
                                    Text('23 ladrillos + 20 ponchitos'),
                                  ])
                                  TableRow(children: [
                                    Text('06 / 03 / 2020'),
                                    Text('1 horas'),
                                    Text('20 ladrillos + 20 ponchitos'),
                                  ])
                                  TableRow(children: [
                                    Text('07 / 03 / 2020'),
                                    Text('2 horas'),
                                    Text('22 ladrillos + 23 ponchitos'),
                                  ])
                                ],
                              ),
                            )
                          ),
                          ParameterWidget(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              'Aquí puedes ver las estadísticas de los viajes en bici y las recompensas obtenidas.',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomContainer()
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 8.0,
            child: InkWell(
              child: RoundedButton(icon: Icons.arrow_back),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 30,
            right: 8.0,
            child: RoundedButton(icon: Icons.favorite),
          )
        ],
      ),
    );
  }
}
