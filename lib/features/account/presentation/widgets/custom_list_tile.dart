import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomListTile extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function tap;
  const CustomListTile({
    @required this.name,
    @required this.icon,
    @required this.tap,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            // color: Theme.of(context).focusColor,
          ),
          SizedBox(width: 15),
          Text(
            name,
            style: GoogleFonts.raleway(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              // color: Theme.of(context).focusColor,
            ),
          ),
        ],
      ),
    );
  }
}
