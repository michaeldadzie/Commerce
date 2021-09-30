import 'package:flutter/material.dart';
import 'package:shop_app/core/splashscreen/intro.dart';
import 'package:shop_app/core/splashscreen/intro_content.dart' as ic;

// enum AuthMode { Signup, Login }

class OnboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ic.SizeConfig().init(context);
    return Scaffold(
      body: Intro(),
    );
  }
}
