import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/core/widgets/app_drawer.dart';
import 'package:shop_app/features/account/presentation/pages/settings_screen.dart';
import 'package:shop_app/features/account/presentation/pages/setup_user_profile.dart';
import 'package:shop_app/features/account/presentation/pages/user_products_screen.dart';
import 'package:shop_app/features/account/presentation/widgets/custom_list_tile.dart';
import 'package:shop_app/features/account/presentation/widgets/user_product_item.dart';
import 'package:shop_app/features/user_authentication/presentation/pages/auth_screen.dart';
import 'package:shop_app/features/user_authentication/presentation/providers/auth.dart';
import 'package:shop_app/features/account/data/model/user.dart';
import 'about_screen.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final Box<UserInfoModel> _userInfoBox =
        Provider.of<Box<UserInfoModel>>(context);

    final UserInfoModel _userInfoModel = _userInfoBox.get('userInfoModel');

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'My Account',
          style: GoogleFonts.raleway(color: Colors.red),
        ),
        iconTheme: IconThemeData(color: Colors.red),
      ),
      key: scaffoldKey,
      // drawer: AppDrawer(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               _userInfoModel.fname ??
              //                   'Abs' + ' ' + _userInfoModel.lname ??
              //                   'Abs',
              //               style: GoogleFonts.raleway(
              //                   fontSize: 25, fontWeight: FontWeight.bold),
              //             ),
              //             // SizedBox(height: 5),
              //             // Text(
              //             //   'soulll@gmail.com',
              //             //   style: GoogleFonts.raleway(
              //             //     fontSize: 15,
              //             //     fontWeight: FontWeight.w400,
              //             //     color: Colors.grey[700],
              //             //   ),
              //             // ),
              //             SizedBox(height: 20),
              //           ],
              //         ),
              //       ],
              //     ),
              //     // Container(
              //     //   decoration: BoxDecoration(
              //     //     borderRadius: BorderRadius.circular(10),
              //     //     image: DecorationImage(
              //     //       image: AssetImage(_userInfoModel.photoUrl),
              //     //       fit: BoxFit.cover,
              //     //     ),
              //     //   ),
              //     //   height: 50,
              //     //   width: 50,
              //     // ),
              //   ],
              // ),
              CustomListTile(
                tap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => UserProfile(),
                    ),
                  );
                },
                name: 'Setup Profile',
                icon: AntDesign.user,
              ),
              SizedBox(height: 25),
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
                icon: Icons.edit,
              ),
              SizedBox(height: 25),
              CustomListTile(
                tap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SettingsScreen(),
                    ),
                  );
                },
                name: 'Settings',
                icon: Icons.settings_outlined,
              ),
              SizedBox(height: 25),
              CustomListTile(
                tap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AboutScreen(),
                    ),
                  );
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
                name: 'Privacy Policy',
                icon: Icons.privacy_tip_outlined,
              ),
              SizedBox(height: 25),
              CustomListTile(
                tap: () {
                  // Navigator.of(context).pop();
                  // Navigator.of(context).pushReplacementNamed('/');
                  Navigator.of(context)
                      .pushReplacementNamed(AuthScreen.routeName);
                  Provider.of<Auth>(context, listen: false).logout();
                },
                name: 'Log Out',
                icon: Icons.logout,
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
