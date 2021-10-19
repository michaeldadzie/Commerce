import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunicationsPreference extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool _checked = true;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Communications Preferences',
          style: GoogleFonts.raleway(color: Theme.of(context).accentColor),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  'We occasionaly send you the latest dishes & promotional offeers. In order to benefit, tick the box below. If you don\'t wish to receive any newsletters or offers please untick this box. You can always adjust your prefernce here.',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: Colors.red,
                dense: true,
                title: Text(
                  'I want to receive Soulll Shop news and offers',
                  style: GoogleFonts.raleway(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: _checked,
                onChanged: (bool val) {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
