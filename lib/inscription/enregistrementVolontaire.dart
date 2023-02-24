import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shomea_handaid/homePageVolontaire.dart';
import 'package:connectivity/connectivity.dart';
import 'package:shomea_handaid/utils/component.dart';
import 'dart:convert';
import '../sentAlert.dart';

class EnregistrementVolontaire extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShomeaHandAid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.deepPurple[900], accentColor: Color(0xFF2A2A42), fontFamily: 'Poppins'),

      home: MyRegisterVolontaire(title: 'Flutter Demo Home Pagse'),
    );
  }
}



class MyRegisterVolontaire extends StatefulWidget {
  MyRegisterVolontaire({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyRegisterVolontaireState createState() => _MyRegisterVolontaireState();
}

class _MyRegisterVolontaireState extends State<MyRegisterVolontaire> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController nameOfCompanyController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String _birthday="";
  bool _isObscure = true, isLoading = false;
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
  void registerVolontaire(String phoneNumber, String nameOfCompany, String password, String email) async{
    try{
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile) {
        setState(() {
          isLoading =true;
        });
        Response response = await post(
          //Uri.parse('$base_url_dev1/auth/register'),
            Uri.parse('$base_url_online/auth/register'),
            body: jsonEncode({
              'phone': phoneNumber,
              'name_person_contact': 'nameOfCompany',
              'password': password,
              'email': email,
              'full_name': nameOfCompany,
              'date_birth': "$_val",
              'status': "DISABLE",
              'type': "DISABILITY",
            })

        );
        print(phoneNumber);
        print(nameOfCompany);
        print(password);
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
          print(response.body);
        }
      } else if (connectivityResult == ConnectivityResult.wifi) {
        setState(() {
          isLoading =true;
        });
        Response response = await post(
          //Uri.parse('$base_url_dev1/auth/register'),
            Uri.parse('$base_url_online/auth/register'),
            body: jsonEncode({
              'phone': phoneNumber,
              'name_person_contact': 'nameOfCompany',
              'password': password,
              'email': email,
              'full_name': nameOfCompany,
              'date_birth': "$_val",
              'status': "DISABLE",
              'type': "DISABILITY",
            })

        );
        print(phoneNumber);
        print(nameOfCompany);
        print(password);
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
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new MyHomePageVolontaire(title: '')));
                          });
                        },
                        child: Icon(Icons.arrow_back_ios_sharp, color: Colors.white,)),
                    Container(width: largeur/5,),
                    InkWell(
                      onTap: (){
                        setState(() {
                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => new MyHomePageVolontaire(title: "")));
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
                      Text("Register to help simplify medical ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: largeur/17,
                            fontWeight: FontWeight.normal
                        ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("assistance for people with",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: largeur/17,
                            fontWeight: FontWeight.normal
                        ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text("disabilities ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: largeur/17,
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
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: largeur/20,
                          fontWeight: FontWeight.bold
                      ),
                      controller: nameOfCompanyController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.person_outline, color: Colors.black, size: largeur/19,),
                        labelText: 'Company or organization name',
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
                        prefixIcon: Icon(Icons.phone_android_sharp, color: Colors.black, size: largeur/20,),
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
                      controller: emailController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          //borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.grey, width: 1.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        prefixIcon: Icon(Icons.mail_outline, color: Colors.black, size: largeur/20,),
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



                  /*Padding(
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
                        child: Column(
                          children: [
                            new Text("Tell us a title about your organization", style: new TextStyle(
                                fontSize: hauteur/40, color: Colors.grey, fontWeight: FontWeight.normal),),
                          ],
                        ),
                      ),
                    ),
                  ),*/

                  Padding(
                    padding: EdgeInsets.only(top: hauteur/30, bottom: 20),
                    child: new InkWell(
                      onTap: (){
                        /*registerVolontaire(
                          nameOfCompanyController.text.toString(),
                          phoneNumberController.text.toString(),
                          passwordController.text.toString(),
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