import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(
            EvilIcons.spinner,
            size: 80,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
