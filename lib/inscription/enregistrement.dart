import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shomea_handaid/main.dart';
import 'package:shomea_handaid/utils/component.dart';
import 'dart:async';
import '../accueil.dart';
import '../sentAlert.dart';

class Enregistrement extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShomeaHandAid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple[900], accentColor: Color.fromRGBO(0, 25, 76, 1), scaffoldBackgroundColor: Color.fromRGBO(0, 25, 76, 1), fontFamily: 'Poppins'),
      home: MyRegister(title: 'Flutter Demo Home Pagse'),
    );
  }
}



class MyRegister extends StatefulWidget {
  MyRegister({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController namePersonContactController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool _isObscure = true, isLoading = false;
  bool _check1=false, _check2=false, _check3=false, _check4=false,  isClicked = false;
  String _birthday="";

  String _val = '';
  Future _select_full_date () async{
     DateTime? picker = await showDatePicker
       (context: context, 
         initialDate: DateTime.now(), firstDate: DateTime(2018), lastDate: DateTime(2030)
     );
     if(picker!=null) setState(() {
       _val = picker.toString();
     });
  }
  void register(String phoneNumber, String namePersonContact, String password, String fullName, String email) async{
    try{
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        setState(() {
          isLoading =true;
        });
        var dio = Dio();
        var response = await dio.post(
          //Uri.parse('$base_url_dev2/users'),
            '$base_url_online_mobile/users',
            data: json.encode({
            "phone": "$phoneNumber",
            "name_person_contact": "$namePersonContact",
            "password": "$password",
            "email": "$email",
            "full_name": "$fullName",
            "date_birth": "$_val",
            "status": "DISABLE",
            "type": "DISABILITY",
            "disabilities": _check1==true?[1]:_check2==true?[1,2]:[1,2,3],
            }),
            //encoding: Encoding.getByName("utf-8")
        );
        print(phoneNumber);
        print(namePersonContact);
        print(password);
        print(fullName);
        print(email);
        print("$_val");
        var responseJson = json.decode(response.data);
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
          print(responseJson);
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
          //showInSnackBar("Merci");
          print(response.data);
        }

      } else if (connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          isLoading =true;
        });
        var response = await post(
          //Uri.parse('$base_url_dev2/users'),
            Uri.parse('$base_url_online_mobile/users'),
            body: json.encode({
            'phone': "$phoneNumber",
            'name_person_contact': "$namePersonContact",
            'password': "$password",
            'email': "$email",
            'full_name': "$fullName",
            'date_birth': "$_val",
            'status': "DISABLE",
            'type': "DISABILITY",
            "disabilities": _check1==true?[1]:_check2==true?[1,2]:[1,2,3],
            })

        );
        print(phoneNumber);
        print(namePersonContact);
        print(password);
        print(fullName);
        print(email);
        var responseJson = json.decode(response.body);
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
          print(responseJson);
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
          //showInSnackBar("Merci");
          print(response.body);
        }
      } else {
        setState(() {
          isLoading =false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("service indisponible"),
              backgroundColor: Colors.greenAccent,
              elevation: 10, //shadow
            )
        );
      }

    }catch(e){
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.grey;
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 245, 253, 1),
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new MyHomePage(title: "")));
                          });
                        },
                        child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white,)),
                    Container(width: largeur/5,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new MyHomePage(title: "")));
                        });
                      },
                      child: Text('LOGIN',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: largeur/20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(width: largeur/80,),
                    Text('REGISTER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
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
                  Text("Welcome to Shomea          ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: largeur/13,
                        fontWeight: FontWeight.bold
                    ),),

                  Row(
                    children: [
                      Text("account to get ",
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
                  Row(
                    children: [
                      Text("Health Assistance ",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: largeur/16,
                            fontWeight: FontWeight.normal
                        ),),
                      Text("from around ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: largeur/16,
                            fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("you ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: largeur/16,
                            fontWeight: FontWeight.normal
                        ),),
                    ],
                  ),

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
                        fillColor: Colors.white,
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
                    padding: EdgeInsets.only(top: hauteur/15),
                    child: new TextFormField(
                      //controller: _controller,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
                      ),
                      controller: namePersonContactController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.phone_android_sharp, color: Colors.black, size: largeur/20,),
                        labelText: 'Non disabled person to contact',
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
                    padding: EdgeInsets.only(top: hauteur/15),
                    child: new TextFormField(
                      //controller: _controller,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
                      ),

                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.phone_android_sharp, color: Colors.black, size: largeur/20,),
                        labelText: 'Email',
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
                    padding: EdgeInsets.only(top: hauteur/15),
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
                        prefixIcon: Icon(Icons.work_outline_sharp, color: Colors.black, size: largeur/20,),
                        suffixIcon: IconButton(
                            icon: Icon(
                                _isObscure ? Icons.visibility : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            }),
                        labelText: 'Password',
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
                    padding: EdgeInsets.only(top: hauteur/15),
                    child: new TextFormField(
                      //controller: _controller,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
                      ),
                      /*validator: (String value){
                        if(value.isEmpty){
                          return null;
                        }else{
                          setState(() {
                            name = value;
                          });
                          return null;
                        }
                      },*/
                      controller: fullNameController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.black, size: largeur/20,),
                        labelText: 'Full name',
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
                    padding: EdgeInsets.only(top: hauteur/20),
                    child: _val.isEmpty?InkWell(
                      onTap: _select_full_date,
                      child: Container(
                        margin: EdgeInsets.only(top: 0.0),
                        decoration: new BoxDecoration(
                          borderRadius: new BorderRadius.only(
                            bottomRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                            topLeft: Radius.circular(5.0),
                          ),
                          color: Colors.transparent,
                          border: Border.all(
                            width: 2,
                            color: Colors.grey,
                          ),
                        ),
                        height: hauteur/13,
                        width: largeur/1.1,
                        child: Container(
                            margin: EdgeInsets.only(top: 0.0),
                            decoration: new BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(
                                width: 2,
                                color: Colors.transparent,
                              ),
                            ),
                            height: hauteur/10,
                            width: largeur/4,
                            child: Row(
                              children: [
                                SizedBox(width: largeur/40,),
                                Icon(Icons.calendar_today, color: Colors.black, size: largeur/20,),
                                SizedBox(width: largeur/40,),
                                Container(
                                  child: Center(
                                    child: Text("Date of birth",style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: largeur/20,
                                        fontWeight: FontWeight.normal
                                    )),
                                  ),
                                ),

                              ],
                            )
                        ),
                      ),
                    ):Container(
                      margin: EdgeInsets.only(top: 0.0),
                      decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          bottomRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                        color: Colors.transparent,
                        border: Border.all(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      height: hauteur/13,
                      child: Container(
                          margin: EdgeInsets.only(top: 0.0),
                          decoration: new BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              width: 2,
                              color: Colors.transparent,
                            ),
                          ),
                          height: hauteur/10,
                          child: Row(
                            children: [
                              SizedBox(width: largeur/40,),
                              Icon(Icons.calendar_today, color: Colors.black, size: largeur/20,),
                              SizedBox(width: largeur/40,),
                              Container(
                                child: Center(
                                  child: Text("$_val",style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: largeur/20,
                                      fontWeight: FontWeight.normal
                                  )),
                                ),
                              ),

                            ],
                          )
                      ),
                    ),
                  ),


                  Padding(
                    padding: EdgeInsets.only(top: hauteur/30, bottom: 20),
                    child: new InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MonAccueil(title: '',)));
                      },
                      child: new Container(
                        height: hauteur/3,
                        width: MediaQuery.of(context).size.width-40,
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          border: new Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Center(

                            child: Column(
                              children: [
                                Container(
                                  child: new Text("Select your disability or disabilities", style: new TextStyle(
                                      fontSize: hauteur/40, color: Colors.grey, fontWeight: FontWeight.bold),),
                                ),
                                Row(
                                  children: [
                                  Checkbox(
                                  checkColor: Colors.white, fillColor: MaterialStateProperty.resolveWith(getColor),
                                  value: _check1,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _check1 = value!;
                                    });
                                  },
                                ),
                                    new Text("Can't see  ", style: new TextStyle(
                                        fontSize: hauteur/40, color: Colors.black, fontWeight: FontWeight.bold),),

                                    new Icon(Icons.visibility_off_outlined, color: Colors.red, size: hauteur/20,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white, fillColor: MaterialStateProperty.resolveWith(getColor),
                                      value: _check2,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _check2 = value!;
                                        });
                                      },
                                    ),
                                    new Text("Can't talk  ", style: new TextStyle(
                                        fontSize: hauteur/40, color: Colors.black, fontWeight: FontWeight.bold),),

                                    new Icon(Icons.volume_off_sharp, color: Colors.red, size: hauteur/20,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white, fillColor: MaterialStateProperty.resolveWith(getColor),
                                      value: _check3,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _check3 = value!;
                                        });
                                      },
                                    ),
                                    new Text("Can't hear  ", style: new TextStyle(
                                        fontSize: hauteur/40, color: Colors.black, fontWeight: FontWeight.bold),),

                                    new Icon(Icons.hearing_disabled, color: Colors.red, size: hauteur/20,),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white, fillColor: MaterialStateProperty.resolveWith(getColor),
                                      value: _check4,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _check4 = value!;
                                        });
                                      },
                                    ),
                                    new Text("Can't talk  ", style: new TextStyle(
                                        fontSize: hauteur/40, color: Colors.black, fontWeight: FontWeight.bold),),

                                    new Icon(Icons.wheelchair_pickup, color: Colors.red, size: hauteur/20,),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: hauteur/30, bottom: 20),
                    child: new InkWell(
                      onTap: (){
                        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlert(title: '',)));
                        /*register(
                            phoneNumberController.text.toString(),
                            namePersonContactController.text.toString(),
                            passwordController.text.toString(),
                            fullNameController.text.toString(),
                            emailController.text.toString(),
                         );*/
                        _ackAlert(context);
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

                            child: isLoading == false?new Text("SIGN UP", style: new TextStyle(
                                fontSize: hauteur/40, color: Colors.white, fontWeight: FontWeight.bold),):
                                CupertinoActivityIndicator(radius: hauteur/35,)),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Future<void> _ackAlert(BuildContext context) {
  return showDialog<void>(
    
    context: context,
    builder: (BuildContext context) {
      final largeur = MediaQuery.of(context).size.width;
      final hauteur = MediaQuery.of(context).size.height;
      return AlertDialog(
        //title: Text('Not in stock'),
        content:  Row(
          children: [
            new Icon(Icons.add_location_outlined, color: Colors.green, size: hauteur/20,),
            new Text('Allow Shomea App to \n this divices location'),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Denay', style: new TextStyle(
                fontSize: hauteur/40, color: Colors.green, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          FlatButton(
            child: Text('Allow', style: new TextStyle(
                fontSize: hauteur/40, color: Colors.green, fontWeight: FontWeight.bold)),
            onPressed: () {
              //Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyAlert(title: '',)));
            },
          ),
        ],
      );
    },
  );
}
