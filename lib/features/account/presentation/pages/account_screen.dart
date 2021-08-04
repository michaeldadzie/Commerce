import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/core/widgets/app_drawer.dart';
import 'package:shop_app/features/account/presentation/pages/user_products_screen.dart';
import 'package:shop_app/features/account/presentation/widgets/custom_list_tile.dart';
import 'package:shop_app/features/account/presentation/widgets/user_product_item.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: GoogleFonts.raleway(color: Colors.red),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            icon: menuButton,
            onPressed: () => scaffoldKey.currentState.openDrawer(),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.red),
      ),
      key: scaffoldKey,
      drawer: AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Michael Dadzie',
                        style: GoogleFonts.raleway(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'dadziemikke2@gmail.com',
                        style: GoogleFonts.raleway(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     image: DecorationImage(
                  //       image: AssetImage(_userInfoModel.photoUrl),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  //   height: 50,
                  //   width: 50,
                  // ),
                ],
              ),
              SizedBox(height: 40),
              CustomListTile(
                  tap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => UserProductsScreen(),
                      ),
                    );
                  },
                  name: 'Manage Products',
                  icon: Icons.edit),
              SizedBox(height: 25),
              CustomListTile(
                tap: () {
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(
                  //     builder: (context) => SettingsScreen(),
                  //   ),
                  // );
                },
                name: 'Settings',
                icon: Icons.settings_outlined,
              ),
              SizedBox(height: 25),
              CustomListTile(
                tap: () {
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(
                  //     builder: (context) => AboutScreen(),
                  //   ),
                  // );
                },
                name: 'About',
                icon: Icons.info_outlined,
              ),
              SizedBox(height: 25),
              CustomListTile(
                tap: () {
                  // Navigator.push(
                  //   context,
                  //   CupertinoPageRoute(
                  //     builder: (context) => HelpScreen(),
                  //   ),
                  // );
                },
                name: 'Help',
                icon: Icons.help_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

var scaffoldKey = GlobalKey<ScaffoldState>();
Widget get menuButton {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(height: 3, width: 24, color: Colors.red),
        SizedBox(height: 3),
        Container(height: 3, width: 12, color: Colors.red),
      ],
    ),
  );
}
