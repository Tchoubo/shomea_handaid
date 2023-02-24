import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart';
import 'package:shomea_handaid/getPosition.dart';
import 'package:shomea_handaid/utils/component.dart';
import 'dart:convert';
import 'alertSent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SentAlert extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShomeaHandAid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple[900], accentColor: Color(0xFF2A2A42), fontFamily: 'Poppins'),

      home: MyAlert(title: 'Flutter Demo Home Pagse'),
    );
  }
}

class MyAlert extends StatefulWidget {
  MyAlert({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyAlertState createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> {
  String token = "";
  bool isLoading = false;
  var locationMessage = "";

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  Future<void> _ackAlertConnexion(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Oops!'),
          content: const Text('Vérifier votre connexion internet.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  void sentAlert() async{
    try{
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        setState(() {
          isLoading =true;
        });
        var position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        var lastPosition = await Geolocator().getCurrentPosition();
        var latitude = await position.latitude;
        var longitude = await position.longitude;
        print("la dernière position: $lastPosition");
        print("la latitude: $latitude");
        print("la latitude: $longitude");
        final msg = json.encode({"longitude": "45",
          "latitude": "45"});
        Response response = await post(
          //Uri.parse('$base_url_dev2/users_alerts'),
          Uri.parse('$base_url_online_mobile/users'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer 32|Fg2v8fM8fEbePvcKXsXF16O0BtjNAYB1ahi1h9Ea',
          },
          body: msg,
        );
        var responseJson = json.decode(response.body);
        if(response.statusCode == 200){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlertSent(title: '',)));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("successfully sent"),
                backgroundColor: Colors.greenAccent,
                elevation: 10, //shadow
              )
          );
          print('successfully sent');
          print(responseJson);
        }else{
          setState(() {
            isLoading =false;
          });
          print('failed');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("sending failed"),
                backgroundColor: Colors.redAccent,
                elevation: 10, //shadow
              )
          );
          print(response.body.toString());
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          isLoading =true;
        });
        var position = await Geolocator()
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        var lastPosition = await Geolocator().getCurrentPosition();
        var latitude = await position.latitude;
        var longitude = await position.longitude;
        print("la dernière position: $lastPosition");
        print("la latitude: $latitude");
        print("la latitude: $longitude");
        final msg = json.encode({"longitude": "45",
          "latitude": "45"});
        Response response = await post(
          //Uri.parse('$base_url_dev2/users_alerts'),
          Uri.parse('$base_url_online_mobile/users'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer 32|Fg2v8fM8fEbePvcKXsXF16O0BtjNAYB1ahi1h9Ea',
          },
          body: msg,
        );
        var responseJson = json.decode(response.body);
        if(response.statusCode == 200){
          Navigator.of(context).push(MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => MyAlertSent(title: '',)));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("successfully sent"),
                backgroundColor: Colors.greenAccent,
                elevation: 10, //shadow
              )
          );
          print('successfully sent');
          print(responseJson);
        }else{
          setState(() {
            isLoading =false;
          });
          print('failed');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("sending failed"),
                backgroundColor: Colors.redAccent,
                elevation: 10, //shadow
              )
          );
          print(response.body.toString());
        }
      } else {
        setState(() {
          isLoading =false;
        });
        print('service indisponible');
        _ackAlertConnexion(context);
      }

    }catch(e){
      setState(() {
        isLoading =false;
      });
      print('service indisponible');
      _ackAlertConnexion(context);
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: hauteur,
        width: largeur,
        color: Color.fromRGBO(0, 25, 76, 1),
        child: Center(
          child: Column(
            children: [
              new Container(
                height: hauteur/7,
              ),
              new Container(
                height: largeur*2.8/3.2,
                width: largeur*2.8/3.2,
                decoration: new BoxDecoration(
                  color: Colors.white,
                  border: new Border.all(
                    color: Colors.transparent,
                    width: 0.0,
                  ),
                  borderRadius: new BorderRadius.circular(largeur*2.8/6.4),
                ),
                child: Center(

                    child: new Container(
                      height: hauteur/3,
                      width: largeur*0.9/2,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("images/endicape.PNG"),
                            fit: BoxFit.cover,
                          )
                      ),
                    ),),
              ),
              new Container(
                height: hauteur/40,
              ),
              InkWell(
                onTap: () {
                  //sentAlert();
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyGetPosition(title: '',)));
                  },
                child: new Container(
                  height: hauteur/13,
                  width: largeur*2.0/3.2,
                  decoration: new BoxDecoration(
                    color: Colors.red,
                    border: new Border.all(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  child: Center(

                      child: isLoading == false?new Text("SEND AN ALERT", style: new TextStyle(
                          fontSize: hauteur/40, color: Colors.white, fontWeight: FontWeight.bold),):
                          CupertinoActivityIndicator(radius: hauteur/35,)),
                ),
              ),
              SizedBox(
                height: hauteur/5.2,
              ),
              Row(
                children: [
                  new SizedBox(width: largeur/1.3,),
                  new Text("MORE", style: new TextStyle(
                  fontSize: hauteur/40, color: Colors.white, fontWeight: FontWeight.bold),),
                  SizedBox(width: largeur/50,),
                  new Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: hauteur/35,),
                ],
              ),
            ],
          ),
        ),
      ),


      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      Timer.periodic(const Duration(seconds: 5), (timer) { });
      final largeur = MediaQuery.of(context).size.width;
      final hauteur = MediaQuery.of(context).size.height;
      return AlertDialog(

        content:  Container(
          height: hauteur,
          width: largeur,
          color: Colors.white,
        ),
        actions: <Widget>[
        ],
      );
    },
  );
}
