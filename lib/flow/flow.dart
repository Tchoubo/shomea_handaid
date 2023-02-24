import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shomea_handaid/accueil.dart';
import 'package:shomea_handaid/flow/alerts.dart';
import 'package:shomea_handaid/flow/dashboard.dart';
import 'package:shomea_handaid/flow/users.dart';
import 'package:shomea_handaid/main.dart';

class Flows extends StatefulWidget {
  const Flows({Key? key}) : super(key: key);

  @override
  _FlowsState createState() => _FlowsState();
}

class _FlowsState extends State<Flows> with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState(){
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final largeur = MediaQuery.of(context).size.width;
    final hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        height: hauteur/12,
        padding: const EdgeInsets.only(
          top: 0.0,
          bottom: 0.0,
          left: 0.0,
          right: 0.0
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: new Border.all(
            color: Color.fromRGBO(0, 25, 76, 1),
            width: 2.0,
          ),
          borderRadius: BorderRadius.zero
        ),
        child: DefaultTabController(
          length: 4,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                    topLeft: Radius.circular(0.0),
                    bottomLeft: Radius.circular(0.0)
                ),
            ),
            child: TabBar(
                controller: _controller,
                unselectedLabelColor: Colors.white,
                indicatorColor: Colors.grey,

                indicatorWeight: 0.0,
                labelColor: Colors.white,
                indicator: BoxDecoration(
                  color: Color.fromRGBO(0, 25, 76, 1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(0.0),
                      topRight: Radius.circular(largeur/40),
                      topLeft: Radius.circular(largeur/40),
                      bottomLeft: Radius.circular(0.0)
                  ),
                ),
                tabs: [
                  Tab( icon: Icon(Icons.home_outlined, color: Colors.white,), text: "Acceuil",),
                  Tab( icon: Icon(Icons.add_alert_outlined, color: Colors.white,), text: "Alerts",),
                  Tab( icon: Icon(Icons.supervised_user_circle, color: Colors.white,), text: "Users",),
                  Tab( icon: Icon(Icons.dashboard_outlined, color: Colors.white,), text: "Dashboard",),
                ]),
          ),
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children:  [
          MonAccueil(title: ""),
          Alerts(),
          Users(),
          Dashboard()
        ],
      ),
    );
  }
}
