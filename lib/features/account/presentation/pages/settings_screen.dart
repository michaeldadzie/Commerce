import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'communications_preference.dart';
import 'language_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Settings',
          style: GoogleFonts.raleway(color: Theme.of(context).accentColor),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).accentColor),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                focusColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LanguageScreen(),
                    ),
                  );
                },
                title: Text(
                  'Language',
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Theme.of(context).accentColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).accentColor,
                  size: 17,
                ),
              ),
              Divider(
                color: Colors.grey[200],
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                focusColor: Colors.transparent,
                selectedTileColor: Colors.transparent,
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => CommunicationsPreference(),
                    ),
                  );
                },
                title: Text(
                  'Communication Preferences',
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: Theme.of(context).accentColor),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Theme.of(context).accentColor,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
