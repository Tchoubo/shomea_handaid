import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animator/animator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:shomea_handaid/utils/component.dart';
import 'dart:convert';
import 'alertSent.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class GetPosition extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShomeaHandAid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple[900], accentColor: Color(0xFF2A2A42), fontFamily: 'Poppins'),

      home: MyGetPosition(title: 'Flutter Demo Home Pagse'),
    );
  }
}

class MyGetPosition extends StatefulWidget {
  MyGetPosition({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyGetPositionState createState() => _MyGetPositionState();
}

class _MyGetPositionState extends State<MyGetPosition> {
  String token = "";
  bool isLoading = false;
  var locationMessage = "";

  @override
  void initState() {
    super.initState();
    isLoading = false;
    Timer(Duration(seconds: 8), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlertSent(title: '',)));
    });

  }

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    const durations = Duration(seconds: 7);
    return Scaffold(
      body: Container(
        height: hauteur,
        width: largeur,
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              new SizedBox(height: hauteur/10,),
              new Center(child: TypewriterAnimatedTextKit(
                  totalRepeatCount: 1,
                  pause: Duration(milliseconds:  5000),
                  text: ["FINDING", ""],
                  textStyle: TextStyle(
                      color: Color.fromRGBO(0, 25, 76, 1),
                      fontSize: largeur/13,
                      fontWeight: FontWeight.bold
                  ),
                  //speed: Duration(milliseconds:  1000),
                  //pause: Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true
              ),),
              new Center(
                child: TypewriterAnimatedTextKit(
                    totalRepeatCount: 1,
                    pause: Duration(milliseconds:  5000),
                    text: ["your location...", ""],
                    textStyle: TextStyle(
                        color: Color.fromRGBO(0, 25, 76, 1),
                        fontSize: largeur/13,
                        fontWeight: FontWeight.bold
                    ),
                    //speed: Duration(milliseconds:  1000),
                    //pause: Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true
                )
              ),
              new Center(
                child: TypewriterAnimatedTextKit(
                    totalRepeatCount: 1,
                    pause: Duration(milliseconds:  7000),
                    text: ["", "LOCATION FOUND"],
                    textStyle: TextStyle(
                        color: Colors.green,
                        fontSize: largeur/13,
                        fontWeight: FontWeight.bold
                    ),
                    //speed: Duration(milliseconds:  1000),
                    //pause: Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true
                )
              ),
              new Container(
                height: hauteur/10,
              ),
              Stack(children: [
                Center(
                  child: Container(
                    height: hauteur/2.9,
                    width: largeur*0.8,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/imageposition.PNG"),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                ),
                Container(child: AnimatedIcon(),)
              ],),
            ],
          ),
        ),
      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AnimatedIcon extends StatelessWidget {
  const AnimatedIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    const durations = Duration(seconds: 7);
    if (durations==true) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlertSent(title: '',)));
    }
    return Animator<double>(
      tween: Tween<double>(begin: 100, end: 50,),
      cycles: 4,
      duration: Duration(seconds: 1),

      builder: (context, animatorState, child)=>
          Container(
              margin: EdgeInsets.symmetric(vertical: hauteur/18, horizontal: largeur/1.7),
              height: animatorState.value,
              width: animatorState.value,
              child: Icon(Icons.location_on, color: Colors.red, size: animatorState.value,)),
    );
  }
}

