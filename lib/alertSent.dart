

import 'package:flutter/material.dart';

import 'accueil.dart';
import 'main.dart';

class AlertSent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShomeaHandAid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple[900], accentColor: Color(0xFF2A2A42), fontFamily: 'Poppins'),

      home: MyAlertSent(title: 'Flutter Demo Home Pagse'),
    );
  }
}
class MyAlertSent extends StatefulWidget {
  MyAlertSent({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyAlertSentState createState() => _MyAlertSentState();
}

class _MyAlertSentState extends State<MyAlertSent> {

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 245, 253, 1),
      body: Container(
        height: hauteur,
        width: largeur,
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              new Container(
                height: hauteur/8,
              ),
              new Center(
                child: Card(
                  elevation: 20,

                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(largeur/11),
                      topRight: Radius.circular(largeur/11),
                              topLeft: Radius.circular(largeur/11),
                      bottomLeft: Radius.circular(largeur/11))),
                  child: Column(
                    children: [
                      Container(
                        height: hauteur*1.3/4,
                        width: largeur*1.9/2,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage("images/imageDr.PNG", ),
                            fit: BoxFit.cover,
                          ),
                          border: new Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: new BorderRadius.only(
                            topLeft: Radius.circular(largeur/30),
                            topRight: Radius.circular(largeur/30),
                            bottomRight: Radius.circular(largeur/30),
                            bottomLeft: Radius.circular(largeur/30),
                          ),
                        ),

                      ),
                      Container(
                        child: Column(
                          children: [
                            Container(height: hauteur/50,),
                            Container(
                              child: Icon(Icons.add_outlined, color: Color.fromRGBO(61, 203, 143, 1),),
                              height: largeur/8,
                              width: largeur/8,
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                border: new Border.all(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                                borderRadius: new BorderRadius.circular(largeur/16),
                              ),
                            ),
                            Container(height: hauteur/50,),
                            Text("ALERT SEND", style: new TextStyle(
                                fontSize: largeur/15, color: Colors.white, fontWeight: FontWeight.bold),),
                            Container(height: hauteur/100,),
                            Text("Be patient please. Our medical team", style: new TextStyle(
                                fontSize: largeur/25, color: Color.fromRGBO(0, 25, 76, 1), fontWeight: FontWeight.bold),),
                            Text("and our volunteers will assist you in a ", style: new TextStyle(
                                fontSize: largeur/25, color: Color.fromRGBO(0, 25, 76, 1), fontWeight: FontWeight.bold),),
                            Text("short while", style: new TextStyle(
                                fontSize: largeur/25, color: Color.fromRGBO(0, 25, 76, 1), fontWeight: FontWeight.bold),),
                          ],
                        ),
                        height: hauteur*1.3/4,
                        width: largeur*1.9/2,
                        decoration: new BoxDecoration(
                          color: Color.fromRGBO(61, 203, 143, 1),
                          border: new Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: new BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),

                      ),
                    ],
                  ),
                ),
              ),
              new Container(
                height: hauteur/50,
              ),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonAccueil(title: '',)));
                },
                child: new Container(
                  height: hauteur/14,
                  width: largeur*2.8/3,
                  decoration: new BoxDecoration(
                    color: Color.fromRGBO(0, 25, 76, 1),
                    border: new Border.all(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  child: Center(

                      child: Row(
                        children: [
                          new Container(width: largeur/4,),
                          new Icon(Icons.home_outlined, color: Colors.white,),
                          new Container(width: largeur/50,),
                          new Text("GO TO HOMEPAGE", style: new TextStyle(
                              fontSize: largeur/25, color: Colors.white, fontWeight: FontWeight.bold),),
                        ],
                      )),
                ),
              ),
              new Container(
                height: hauteur/90,
              ),
              new Container(
                height: hauteur/14,
                width: largeur*2.8/3,
                decoration: new BoxDecoration(
                  color: Colors.grey,
                  border: new Border.all(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  borderRadius: new BorderRadius.circular(4.0),
                ),
                child: Center(

                    child: new Text("SEND AN ALERT", style: new TextStyle(
                        fontSize: largeur/25, color: Colors.white, fontWeight: FontWeight.bold),)),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
