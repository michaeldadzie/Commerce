import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'About',
          style: GoogleFonts.raleway(color: Theme.of(context).accentColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Version 1.2.2',
                style: GoogleFonts.raleway(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              SizedBox(height: 20),
              Text(
                'Build version 1.2.2(1001)',
                style: GoogleFonts.raleway(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700]),
              ),
              SizedBox(height: 5),
              Text(
                'Codepush version v1.2.2',
                style: GoogleFonts.raleway(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
