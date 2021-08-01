import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/widgets/app_drawer.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: GoogleFonts.raleway(color: Colors.red),
        ),
        iconTheme: IconThemeData(color: Colors.red),
      ),
      drawer: AppDrawer(),
    );
  }
}
