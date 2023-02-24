import 'package:flutter/material.dart';
import 'package:shomea_handaid/accueil.dart';
import 'package:shomea_handaid/main.dart';

class Users extends StatefulWidget {
  const Users({Key? key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> with TickerProviderStateMixin {

  List names = ["Patients", "Partners", "Volunteers", "Emergency Assistant", "Administrators", "Patients", "Partners", "Volunteers", "Emergency Assistant", "Administrators"];
  List destinations = ["288", "70", "364", "80", "3", "288", "70", "364", "80", "3"];
  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: hauteur/15,
          title: Text(''),
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          flexibleSpace: Column(
            children: [
              SizedBox(height: hauteur/15,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: largeur/20,),
                  Icon(Icons.line_weight_sharp),
                  SizedBox(width: largeur/20,),
                  Text("Users", style: TextStyle(
                      color: Colors.red, fontSize: 22.0, fontWeight: FontWeight.bold
                  )),
                  SizedBox(width: largeur/1.7,),
                  Center(child: Icon(Icons.search, size: 30.0,))
                ],
              )
              
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index)=>Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Container(
                  height: MediaQuery.of(context).size.height/10,
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /*Container(
                                width: 55.0,
                                height: 55.0,
                                //color: Colors.green,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/imageaccueil.PNG"),
                                      fit: BoxFit.cover),
                                ),
                              ),*/
                              Center(
                                child: Text(names[index], style: TextStyle(
                                    color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold
                                )),
                              ),
                              SizedBox(width: 25.0,),
                              Center(
                                child: Text(destinations[index], style: TextStyle(
                                  color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.normal
                                ),),
                              )
                            ],
                          ),
                          Center(child: Icon(Icons.arrow_forward_ios))
                        ],
                      ),
                    ),
                  ),
                ),
              ),),
        ),
    );
  }
}
