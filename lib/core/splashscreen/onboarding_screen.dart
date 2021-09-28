import 'package:flutter/material.dart';
import 'package:shop_app/core/splashscreen/intro.dart';
import 'package:shop_app/core/splashscreen/intro_content.dart';

class OnboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Intro(),
    );
  }
}
