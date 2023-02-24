

import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shomea_handaid/inscription/enregistrement.dart';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shomea_handaid/sentAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shomea_handaid/utils/component.dart';
import 'main.dart';

class ShomeaHandAid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShomeaHandAid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple[900], accentColor: Color(0xFF2A2A42), fontFamily: 'Poppins'),
      home: MyHomePage(title: 'Flutter Demo Home Pagse'),
    );
  }
}



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true, isLoading = false;


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

  void login(String phoneNumber, password) async{
    try{
      var connectivityResult = await (Connectivity().checkConnectivity());
      var wifiIp = await (Connectivity().getWifiIP());
      var wifiName = await (Connectivity().getWifiName());
      if (connectivityResult == ConnectivityResult.mobile) {
        setState(() {
          isLoading =true;
        });
        var response = await Dio().post(
          //Uri.parse('$base_url_dev1/auth/login'),
            '$base_url_online/auth/login',
            data: {
              'phone': phoneNumber,
              'password': password
            }
        );
        print(phoneNumber);
        print(password);
        if(response.statusCode == 200){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlert(title: '',)));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Connection succefull-----"),
                backgroundColor: Colors.greenAccent,
                elevation: 10, //shadow
              )
          );
          print('connect succesfully');
          print(response.data);
        }else{
          setState(() {
            isLoading =false;
          });
          print('failed');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed connection-----"),
                backgroundColor: Colors.redAccent,
                elevation: 10, //shadow
              )
          );
          print(response.data);
        }


      } else if (connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          isLoading =true;
        });
        var response = await Dio().post(
          //Uri.parse('$base_url_dev1/auth/login'),
            '$base_url_online/auth/login',
            data: {
              'phone': phoneNumber,
              'password': password
            }
        );
        print(phoneNumber);
        print(password);
        print(wifiName);
        if(response.statusCode == 200){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlert(title: '',)));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Connection succefull"),
                backgroundColor: Colors.greenAccent,
                elevation: 10, //shadow
              )
          );
          print('connect succesfully');
          print(response.data);
        }else{
          setState(() {
            isLoading =false;
          });
          print('failed');
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Failed connection"),
                backgroundColor: Colors.redAccent,
                elevation: 10, //shadow
              )
          );
          print(response.data);
        }
      } else  {
        setState(() {
          isLoading =false;
        });
        print('service indisponible');
        _ackAlertConnexion(context);
      }

    }catch(e){
      print("il y a une erreur");
      //print("Ip dans catch: $wifiIp");
      _ackAlertConnexion(context);
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: hauteur/3,
        title: Text(''),
        backgroundColor: Color.fromRGBO(0, 25, 76, 1),
        flexibleSpace: Column(
          children: [
            Container(height: hauteur/20,),
            Container(
                color: Color.fromRGBO(0, 25, 76, 1),
                height: hauteur/15,
                width: largeur-largeur/10,
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new MonAccueil(title:"")));
                          });
                        },
                        child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white,)),
                    Container(width: largeur/5,),
                    Text('LOGIN',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Container(width: largeur/80,),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyRegister(title: '',)));
                      },
                      child: Text('REGISTER',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: largeur/20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                )
            ),
            Spacer(flex: 10,),
            Container(
              color: Colors.transparent,
              height: hauteur/4.5,
              width: largeur-largeur/10,
              child: Column(
                children: [
                  Text("Welcome back to Shomea          ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: largeur/13,
                        fontWeight: FontWeight.bold
                    ),),
                  Text("Login if you already have an              ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: largeur/16,
                        fontWeight: FontWeight.normal
                    ),),
                  Row(
                    children: [
                      Text("account and get ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: largeur/16,
                            fontWeight: FontWeight.normal
                        ),),
                      Text("Emergency",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: largeur/16,
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                  Text("Health Assistance                                    ",
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: largeur/16,
                        fontWeight: FontWeight.bold
                    ),),

                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Form(
            //key: _formKey,
            child: Padding(
              padding: EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: hauteur/15),
                    child: new TextFormField(
                      //controller: _controller,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
                      ),
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.phone_android_sharp, color: Colors.black, size: largeur/20,),
                        labelText: 'Phone number',
                        labelStyle: new TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: largeur/20,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: hauteur/20,
                        ),
                        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hauteur/17),
                    child: new TextFormField(
                      obscureText: _isObscure,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
                      ),
                      controller: passwordController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        prefixIcon: Icon(Icons.assignment_late_outlined, color: Colors.black, size: largeur/20,),
                        labelText: 'Password',
                        labelStyle: new TextStyle(
                            color: Colors.grey,
                            fontSize: largeur/20,
                            fontWeight: FontWeight.normal
                        ),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: hauteur/20,
                        ),
                        //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hauteur/100, bottom: 10),
                    child: new Text("Click here if you have forgotten your password",
                      style: TextStyle(
                          color: Colors.deepPurple[900],
                          fontSize: hauteur/65,
                          fontWeight: FontWeight.bold
                      ),),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hauteur/30, bottom: 20),
                    child: new InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlert(title: '',)));
                        print("---------------connexion test");
                        //login(phoneNumberController.text.toString(), passwordController.text.toString());
                      },
                      child: new Container(
                        height: hauteur/15,
                        width: MediaQuery.of(context).size.width-40,
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          border: new Border.all(
                            color: Colors.transparent,
                            width: 0.0,
                          ),
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Center(
                            child: isLoading == false?
                                    new Text("LOGIN", style: new TextStyle(
                                    fontSize: hauteur/40, color: Colors.white, fontWeight: FontWeight.bold),)
                                    :CupertinoActivityIndicator(radius: hauteur/35,)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

