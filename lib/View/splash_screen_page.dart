import 'dart:async';

import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;




class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  //TickerProviderStateMixin this help to build animation
  late final AnimationController _controller=AnimationController(
    duration: Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //now allowing animation or splash screen to stay for some time and than 
    //shift to other page
    Timer(Duration(seconds: 5),
            () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldStats()));
            });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _controller,
                  child:Container(
                    height: 200,
                    width:200,
                    child: Center(
                      child: Image(image: AssetImage("assets/virus.png"),),
                    ),
                  ) ,
                  builder:(BuildContext context ,Widget? child){//do not provide comma between BuildContext and context
                    return Transform.rotate(
                        angle:_controller.value*2.0*math.pi,
                      child:child ,
                    );
                  }
              ),
              SizedBox(height: MediaQuery.of(context).size.height*.08,),
              Align(
                alignment: Alignment.center,
                child: Text("Covid-19\n Tracker",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
                ),
              )
              ],
          )
      ),
    );
  }
}
