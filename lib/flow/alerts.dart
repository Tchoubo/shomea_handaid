import 'package:flutter/material.dart';
import 'package:shomea_handaid/accueil.dart';
import 'package:shomea_handaid/main.dart';

class Alerts extends StatefulWidget {
  const Alerts({Key? key}) : super(key: key);

  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> with TickerProviderStateMixin {
  List names = ["Nicolas Hegmann", "Jerome LAMDA", "Ronaldo jacobi", "Terrell Alexandre", "Arthur Wellder", "Patients", "Partners", "Volunteers", "Emergency Assistant", "Administrators"];
  List nombre = ["12", "2", "4", "10", "2", "1", "1", "3", "3", "5"];
  List heures = ["15:29", "03:08", "14:20", "10:01", "02:25", "16:15", "18:55", "13:11", "13:11", "15:22"];
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
                Column(
                  children: [
                    Center(
                      child: Text("ALL ALERTS", style: TextStyle(
                          color: Color.fromRGBO(0, 25, 76, 1), fontSize: largeur/20, fontWeight: FontWeight.bold
                      )),
                    ),
                    Center(child: Container(
                      color: Colors.red,
                      height: 2.0,
                    ),)
                  ],
                ),
                SizedBox(width: largeur/30.7,),
                Text("ACTIVITE ALERTS", style: TextStyle(
                    color: Colors.grey, fontSize: largeur/20, fontWeight: FontWeight.bold
                )),
              ],
            )

          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.only(top: hauteur/50, left: largeur/25, right: largeur/25.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(hauteur/35),
          ),
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index)=>Column(
              children: [
                Container(
                  color: Colors.white,
                  width: largeur/1.3,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height/9.0,
                    width: largeur/1.8,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                Center(
                                    child: Container(
                                      //color: Colors.red,
                                      height: hauteur/13,
                                      width: hauteur/13,
                                      child: Center(
                                        child: Icon(Icons.person_outline, color: Colors.white, size: largeur/10,),
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(10.0),
                                            topRight: Radius.circular(10.0),
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0)
                                        ),
                                      ),
                                    )
                                ),
                                  Positioned(
                                    top: hauteur/90,
                                    left: largeur/9.50,
                                    child: Center(
                                        child: Container(
                                          height: hauteur/40,
                                          width: hauteur/40,
                                          decoration: BoxDecoration(
                                            color: Colors.green,
                                            border: new Border.all(
                                              color: Colors.white,
                                              width: 3.0,
                                            ),

                                            borderRadius: BorderRadius.only(
                                                bottomRight: Radius.circular(hauteur/20),
                                                topRight: Radius.circular(hauteur/20),
                                                topLeft: Radius.circular(hauteur/20),
                                                bottomLeft: Radius.circular(hauteur/20)
                                            ),
                                          ),
                                        )
                                    ),
                                  ),
                                ]
                              ),
                              SizedBox(width: largeur/30,),
                              Center(
                                child: Text(names[index], style: TextStyle(
                                    color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold
                                ),),
                              )
                            ],
                          ),
                          Center(
                              child: Column(
                                children: [
                                  SizedBox(height: hauteur/26,),
                                  Container(
                                    //color: Colors.red,
                                    height: hauteur/30,
                                    width: hauteur/30,
                                    child: Center(
                                      child: Text(nombre[index], style: TextStyle(
                                          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(hauteur/10.0),
                                          topRight: Radius.circular(hauteur/10.0),
                                          topLeft: Radius.circular(hauteur/10.0),
                                          bottomLeft: Radius.circular(hauteur/10.0)
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: hauteur/80,),
                                  Center(
                                    child: Text(heures[index], style: TextStyle(
                                        color: Colors.red, fontSize: 12.0, fontWeight: FontWeight.normal
                                    ),),
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(height: 1.0, color: Color.fromRGBO(0, 25, 76, 1),)
              ],
            ),),
        ),
      ),
    );
  }
}
