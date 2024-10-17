import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';




class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child:GetBuilder<SplashController>(
            init: SplashController(),
            builder: (controller) => 
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.images.appTextIcon
                      .image(width: MediaQuery.of(context).size.width * 0.75),
                 const Padding(
                  padding:  EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: Text('Social Media' , style: TextStyle(fontFamily: FontFamily.sFProDisplayRegular, color: Colors.white),)),
                )
              ],
            ),
          )
      ),
    );
  }
}
