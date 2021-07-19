import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/features/orders/presentation/pages/orders_screen.dart';
import 'package:shop_app/features/home/presentation/pages/product_overview_screen.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = '/bottom-nav';
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
    _pages = [
      {'page': ProductsOverviewScreen()},
      {'page': OrdersScreen()},
      {'page': Container()} //TODO: Replace with Account Screen
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Colors.white,
          unselectedItemColor: Color.fromRGBO(161, 172, 189, 1),
          selectedItemColor: Colors.red,
          currentIndex: _selectedPageIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          iconSize: 20,
          selectedLabelStyle: GoogleFonts.raleway(
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: GoogleFonts.raleway(
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.home),
                label: 'Dashboard'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.shopping_cart),
                label: 'Orders'),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.person),
                label: 'Account'),
          ],
        ),
      ),
    );
  }
}
