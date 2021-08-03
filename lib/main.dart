import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/widgets/bottom_nav.dart';
import 'features/orders/presentation/pages/orders_screen.dart';
import 'features/user_authentication/presentation/pages/auth_screen.dart';
import 'features/user_authentication/presentation/providers/auth.dart';
import 'features/home/presentation/providers/cart.dart';
import 'features/orders/presentation/providers/orders.dart';
import 'features/home/presentation/pages/cart_screen.dart';
import 'features/account/presentation/pages/edit_product_screen.dart';
import 'core/splashscreen/splash_screen.dart';
import 'features/account/presentation/pages/user_products_screen.dart';
import 'features/home/presentation/pages/product_detail_screen.dart';
import 'features/home/presentation/providers/products.dart';
import 'core/utils/theme.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token,
            auth.userId,
            previousProducts == null ? [] : previousProducts.items,
          ),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Orders>(
          update: (ctx, auth, previousOrders) => Orders(
            auth.token,
            auth.userId,
            previousOrders == null ? [] : previousOrders.orders,
          ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Constants.lightTheme,
          darkTheme: Constants.darkTheme,
          home: auth.isAuth
              ? BottomNavBar()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
