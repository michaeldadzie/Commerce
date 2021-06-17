import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';

class ProductDetailScreen extends StatelessWidget {
//  final String title;
//  ProductDetailScreen(this.title);
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    final authData = Provider.of<Auth>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          iconTheme: new IconThemeData(color: Theme.of(context).accentColor),
          // title: Text(
          //   loadedProduct.title,
          //   style: TextStyle(color: Colors.red),
          // ),
          actions: [
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch,
                color: Colors.grey.withOpacity(0.2),
                value: cart.itemCount.toString(),
              ),
              child: IconButton(
                icon: Icon(Icons.shopping_bag_outlined,
                    color: Theme.of(context).accentColor),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
            // Consumer<Product>(
            //   builder: (ctx, product, _) => IconButton(
            //     icon: Icon(loadedProduct.isFavorite
            //         ? Icons.favorite
            //         : Icons.favorite_border),
            //     color: Colors.black,
            //     onPressed: () {
            //       loadedProduct.toggleFavoriteStatus(
            //         authData.token,
            //         authData.userId,
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 65,
              child: Container(
                child: SingleChildScrollView(
                  // physics: BouncingScrollPhysics(
                  //     parent: AlwaysScrollableScrollPhysics()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                loadedProduct.title,
                                style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Expanded(
                              flex: 0,
                              child: Text(
                                '\$${loadedProduct.price.toString()}',
                                style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 230,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey.withOpacity(0.2),
                        child: Hero(
                          tag: loadedProduct.id,
                          child: Image.network(
                            loadedProduct.imageUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          'Description',
                          style: GoogleFonts.raleway(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          loadedProduct.description,
                          style: GoogleFonts.raleway(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).accentColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Builder(
                  builder: (context) => GestureDetector(
                    onTap: () {
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
                          backgroundColor: Colors.black,
                          content: Text(
                            'Added Item to Cart',
                            style: GoogleFonts.raleway(
                                color: Theme.of(context).primaryColor),
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
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).accentColor,
                      child: Center(
                        child: Text(
                          'ADD TO CART',
                          style: GoogleFonts.raleway(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        )

        // CustomScrollView(
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
        );
  }
}
