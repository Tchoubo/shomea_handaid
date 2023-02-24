
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shomea_handaid/flow/flow.dart';
import 'accueil.dart';
import 'homePagePotentiel.dart';
import 'homePageVolontaire.dart';
import 'main.dart';

void main() {
  runApp(Acceuil());
}

class Acceuil extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white, accentColor: Color(0xFF2A2A42), fontFamily: 'Poppins'),
      home: MonAccueil(title: 'Flutter Demo Home Pa'),
    );
  }
}
class MonAccueil extends StatefulWidget {
  MonAccueil({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MonAccueilState createState() => _MonAccueilState();
}

class _MonAccueilState extends State<MonAccueil> {

  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 245, 253, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: largeur/100.0, right: largeur/100.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left: largeur/100.0, right: largeur/100.0),
                child: new Container(
                  height: hauteur/15,
                  width: largeur/2,

                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: largeur/100.0, right: largeur/100.0),
                child: new Container(
                  height: hauteur*2.24/6,
                  width: largeur,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/imageaccueil.PNG"),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: hauteur/50, left: largeur/100.0, right: largeur/100.0),
                child: new Container(
                  height: hauteur/25,
                  //width: MediaQuery.of(context).size.width-40,
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    border: new Border.all(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  child: Center(

                      child: Row(
                        children: [
                          new Container(width: largeur/8,),
                          new Text("Simplifying", style: new TextStyle(
                              fontSize: largeur/20, color: Colors.grey, fontWeight: FontWeight.bold),),
                          new Container(width: largeur/100,),
                          new Text("medical assistance", style: new TextStyle(
                              fontSize: largeur/20, color: Colors.red, fontWeight: FontWeight.bold),),
                        ],
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only( left: largeur/100.0, right: largeur/100.0),
                child: new Container(
                  height: hauteur/25,
                  //width: MediaQuery.of(context).size.width-40,
                  decoration: new BoxDecoration(
                    color: Colors.transparent,
                    border: new Border.all(
                      color: Colors.transparent,
                      width: 0.0,
                    ),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                  child: Center(

                      child: Row(
                        children: [
                          new Container(width: largeur/5,),
                          new Text("for people with", style: new TextStyle(
                              fontSize: largeur/20, color: Colors.grey, fontWeight: FontWeight.bold),),
                          new Container(width: largeur/100,),
                          new Text("disabilities", style: new TextStyle(
                              fontSize: largeur/20, color: Colors.red, fontWeight: FontWeight.bold),),
                        ],
                      )),
                ),
              ),



              Padding(
                padding: EdgeInsets.only(top: hauteur/20, bottom: 10, left: largeur/30.0, right: largeur/30.0),
                child: InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePage(title: '',)));
                  },
                  child: new Container(
                    height: hauteur/12,
                    //width: MediaQuery.of(context).size.width-40,
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      border: new Border.all(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    child: Center(

                        child: new Text("I HAVE A DISABILITY", style: new TextStyle(
                            fontSize: hauteur/40, color: Colors.white, fontWeight: FontWeight.bold),)),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: hauteur/100, bottom: 10, left: largeur/30.0, right: largeur/30.0),
                child: InkWell(
                  onTap: (){
                    //Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePagePotentiel(title: '',)));
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Flows()));
                  },
                  child: new Container(
                    height: hauteur/12,
                    //width: MediaQuery.of(context).size.width-40,
                    decoration: new BoxDecoration(
                      color: Color.fromRGBO(0, 25, 76, 1),
                      border: new Border.all(
                        color: Colors.transparent,
                        width: 0.0,
                      ),
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    child: Center(

                        child: new Text("I'M A (POTENTIAL) PARTENER", style: new TextStyle(
                            fontSize: hauteur/40, color: Colors.white, fontWeight: FontWeight.bold),)),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: hauteur/100, bottom: 20, left: largeur/30.0, right: largeur/30.0),
                child: new InkWell(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyHomePageVolontaire(title: '',)));
                  },
                  child: new Container(
                    height: hauteur/12,
                    //width: MediaQuery.of(context).size.width-40,
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      border: new Border.all(
                        color: Color.fromRGBO(0, 25, 76, 1),
                        width: 2.0,
                      ),
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    child: Center(

                        child: new Text("I'M A (POTENTIAL) VOLUNTEER", style: new TextStyle(
                            fontSize: hauteur/40, color: Color.fromRGBO(0, 25, 76, 1), fontWeight: FontWeight.bold),)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
