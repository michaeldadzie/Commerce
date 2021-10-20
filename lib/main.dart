import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/splashscreen/intro.dart';
import 'package:shop_app/core/splashscreen/splash_screen.dart';
import 'package:shop_app/core/widgets/bottom_nav.dart';
import 'features/orders/presentation/pages/orders_screen.dart';
import 'features/user_authentication/presentation/pages/auth_screen.dart';
import 'features/user_authentication/presentation/providers/auth.dart';
import 'features/home/presentation/providers/cart.dart';
import 'features/orders/presentation/providers/orders.dart';
import 'features/home/presentation/pages/cart_screen.dart';
import 'features/account/presentation/pages/edit_product_screen.dart';
import 'core/splashscreen/onboarding_screen.dart';
import 'features/account/presentation/pages/user_products_screen.dart';
import 'features/home/presentation/pages/product_detail_screen.dart';
import 'features/home/presentation/providers/products.dart';
import 'core/utils/theme.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'features/account/data/model/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // status bar color
    ),
  );
  final Box<UserInfoModel> _userInfoBox = await _userInfoSetup();
  runApp(MyApp(
    userInfoBox: _userInfoBox,
  ));
}

Future<Box<UserInfoModel>> _userInfoSetup() async {
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(UserInfoModelAdapter());
  final Box<UserInfoModel> _userInfoBox =
      await Hive.openBox<UserInfoModel>('userInfoModel');
  return _userInfoBox;
}

class MyApp extends StatelessWidget {
  final Box<UserInfoModel> userInfoBox;
  MyApp({this.userInfoBox});

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
        Provider(create: (_) => userInfoBox),
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
            AuthScreen.routeName: (ctx) => AuthScreen(),
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
