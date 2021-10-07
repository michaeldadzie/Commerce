import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/utils/screen_sizes.dart';
import 'package:shop_app/core/widgets/custom_button.dart';
import 'package:shop_app/features/home/presentation/providers/cart.dart';
import 'package:shop_app/features/home/presentation/providers/products.dart';
import 'package:shop_app/features/home/presentation/widgets/badge.dart';

import 'cart_screen.dart';

class ProductDetailScreen extends StatelessWidget {
//  final String title;
//  ProductDetailScreen(this.title);
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: Size(
        MyScreenSizes.screenWidth,
        MyScreenSizes.screenHeight,
      ),
      allowFontScaling: true,
    );
    final cart = Provider.of<Cart>(context, listen: false);
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
          style: GoogleFonts.raleway(color: Colors.red),
        ),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              color: Colors.red,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
        iconTheme: new IconThemeData(color: Colors.red),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 20.h, left: 20.h, right: 20.h),
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  SizedBox(height: 20.h),
                  Container(
                    height: 200.h,
                    width: MediaQuery.of(context).size.width.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          loadedProduct.imageUrl,
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        loadedProduct.title,
                        style: GoogleFonts.raleway(
                          color: Theme.of(context).accentColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    '\GH¢${loadedProduct.price.toString()}',
                    style: GoogleFonts.lato(
                      color: Colors.grey[500],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    loadedProduct.description,
                    style: GoogleFonts.raleway(
                        fontSize: 18, color: Theme.of(context).accentColor),
                  ),
                  SizedBox(height: 10.h),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 20.h, right: 20.h),
              child: Column(
                children: [
                  Builder(
                    builder: (context) => CustomButton(
                      title: 'Add to Cart',
                      bordersideColor: Colors.red,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      onPress: () {
                        cart.addItem(loadedProduct.id, loadedProduct.price,
                            loadedProduct.title);
                        // Scaffold.of(context).hideCurrentSnackBar();
                        // Scaffold.of(context).showSnackBar(SnackBar(
                        //   backgroundColor: Theme.of(context).accentColor,
                        //   content: Text(
                        //     'Added item to cart',
                        //     style: TextStyle(color: Colors.red),
                        //   ),
                        //   duration: Duration(milliseconds: 1500),
                        // action: SnackBarAction(
                        //   label: 'UNDO',
                        //   textColor: Colors.red,
                        //   onPressed: () {
                        //     cart.removeSingleItem(loadedProduct.id);
                        //   },
                        // ),
                        // ));
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Theme.of(context).primaryColor,
                            content: Text(
                              'Added Item to Cart',
                              style: GoogleFonts.raleway(
                                  color: Theme.of(context).accentColor),
                            ),
                            action: SnackBarAction(
                              label: 'UNDO',
                              textColor: Colors.red,
                              onPressed: () {
                                cart.removeSingleItem(loadedProduct.id);
                              },
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// appBar: AppBar(
//   backgroundColor: Theme.of(context).primaryColor,
//   iconTheme: new IconThemeData(color: Colors.red),
//   title: Text(
//     loadedProduct.title,
//     style: TextStyle(color: Colors.red),
//   ),
//   actions: [
//     Consumer<Cart>(
//       builder: (_, cart, ch) => Badge(
//         child: ch,
//         color: Colors.red,
//         value: cart.itemCount.toString(),
//       ),
//       child: IconButton(
//         icon: Icon(
//           Icons.shopping_cart,
//         ),
//         onPressed: () {
//           Navigator.of(context).pushNamed(CartScreen.routeName);
//         },
//       ),
//     ),
//   ],
// ),
// body: CustomScrollView(
//   slivers: [
//     SliverAppBar(
//       iconTheme: new IconThemeData(color: Colors.red),
//       expandedHeight: 300,
//       pinned: true,
//       flexibleSpace: FlexibleSpaceBar(
//         title: Text(
//           loadedProduct.title,
//           textAlign: TextAlign.left,
//           style: TextStyle(color: Colors.red),
//         ),
//         background: Hero(
//           tag: loadedProduct.id,
//           child: Image.network(
//             loadedProduct.imageUrl,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     ),
//     SliverList(
//       delegate: SliverChildListDelegate([
//         SizedBox(height: 10),
//         Text(
//           '\$${loadedProduct.price}',
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 10),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 10),
//           width: double.infinity,
//           child: Text(
//             loadedProduct.description,
//             textAlign: TextAlign.center,
//             softWrap: true,
//           ),
//         ),
//         SizedBox(
//           height: 800,
//         )
//       ]),
//     ),
//   ],
// ),
