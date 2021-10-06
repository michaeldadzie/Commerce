import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/widgets/app_drawer.dart';
import 'package:shop_app/features/orders/presentation/providers/orders.dart'
    show Orders;
import 'package:shop_app/features/orders/presentation/widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Orders',
          style: GoogleFonts.raleway(color: Colors.red),
        ),
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 10),
        //   child: IconButton(
        //     splashColor: Colors.transparent,
        //     highlightColor: Colors.transparent,
        //     icon: menuButton,
        //     onPressed: () => scaffoldKey.currentState.openDrawer(),
        //   ),
        // ),
        iconTheme: IconThemeData(color: Colors.red),
      ),
      key: scaffoldKey,
      // drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            );
          } else {
            if (dataSnapshot.error != null) {
              //TODO: error handling stuff
              return Center(
                child: Text(
                  'An error occurred!',
                  style: GoogleFonts.raleway(),
                ),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (ctx, i) => OrderItem(
                    orderData.orders[i],
                  ),
                ),
              );
            }
          }
        },
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
