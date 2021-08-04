import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/features/account/presentation/pages/user_products_screen.dart';
import 'package:shop_app/features/user_authentication/presentation/providers/auth.dart';
import 'package:shop_app/features/orders/presentation/pages/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String greetingMessage() {
      var timeNow = DateTime.now().hour;

      if (timeNow <= 12) {
        return 'Good Morning ';
      } else if ((timeNow > 12) && (timeNow <= 16)) {
        return 'Good Afternoon ';
      } else if ((timeNow > 16) && (timeNow < 23)) {
        return 'Good Evening ';
      } else {
        return 'Good Night ';
      }
    }

    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text(
              greetingMessage(),
              style: GoogleFonts.raleway(),
            ),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.store),
            title: Text(
              'Shop',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(EvilIcons.credit_card),
            title: Text(
              'Orders',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (ctx) => OrdersScreen(),
              //   ),
              // );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text(
              'Manage Products',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: GoogleFonts.raleway(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              // Navigator.of(context)
              //     .pushReplacementNamed(UserProductsScreen.routeName);
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
