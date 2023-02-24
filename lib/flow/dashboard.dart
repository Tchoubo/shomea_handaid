import 'package:flutter/material.dart';
import 'package:shomea_handaid/accueil.dart';
import 'package:shomea_handaid/main.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
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
    return Scaffold(

        body: Container(child: Text(""),)
    );
  }
}
