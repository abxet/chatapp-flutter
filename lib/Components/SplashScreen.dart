import 'package:app/Components/checkUser.dart';
import 'package:flutter/material.dart';
// import 'package:app/Components/HomePage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CheckUser()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.5, end: 2), 
          duration: const Duration(seconds: 3),
          curve: Curves.easeOutBack,
          builder: (context, scale, child) {
            return Transform.scale(scale: scale, child: child);
          },
          child: Image.asset("assets/Images/Logo.png", height: 250, width: 250,),
          
        ),
        
      ),  
    );
  }

  
}
