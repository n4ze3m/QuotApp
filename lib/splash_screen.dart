import 'package:flutter/material.dart';
import 'dart:async';
import 'q_home.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  @override
void initState() { 
  super.initState();
  _myBoolCheckerforNav().then((value) => _navigateToHome());
}
  Future<bool> _myBoolCheckerforNav() async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    return true;
  }
  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context)=> QHomeScreen()
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Shimmer.fromColors(
                child: Container(
                  child: Text(
                    "Quotapp",
                    style: TextStyle(
                      fontSize: 80.0,
                      fontFamily: 'Pacifico'
                    ),
                  ),
                ), 
                baseColor: Color(0xff2980b9), 
                highlightColor: Color(0xff3498db))
            ],
          ),
        ),
      ),
    );
  }
}