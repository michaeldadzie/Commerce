import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/features/user_authentication/presentation/providers/auth.dart';
import 'package:shop_app/features/home/presentation/providers/product.dart';
import 'package:shop_app/features/home/presentation/pages/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;
//
//  ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailScreen.routeName,
          arguments: product.id,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      color: Colors.grey.withOpacity(0.2),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Hero(
                        tag: product.id,
                        child: FadeInImage(
                          placeholder:
                              AssetImage('assets/images/product-loading.gif'),
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 1,
                      right: 1,
                      child: Consumer<Product>(
                        builder: (ctx, product, _) => IconButton(
                          icon: Icon(product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border),
                          color: Colors.red,
                          onPressed: () {
                            product.toggleFavoriteStatus(
                              authData.token,
                              authData.userId,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                product.title,
                style: GoogleFonts.raleway(
                    fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: Text(
                '\GH¢${product.price.toString()}',
                style: GoogleFonts.lato(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[500]),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
    //   ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: GridTile(
    //     child: GestureDetector(
    //       onTap: () {
    //         Navigator.of(context).pushNamed(
    //           ProductDetailScreen.routeName,
    //           arguments: product.id,
    //         );
    //       },
    //       child: Hero(
    //         tag: product.id,
    //         child: FadeInImage(
    //           placeholder: AssetImage('assets/images/product-loading.gif'),
    //           image: NetworkImage(product.imageUrl),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //     footer: GridTileBar(
    //       backgroundColor: Colors.black87,
    //       leading: Consumer<Product>(
    //         builder: (ctx, product, _) => IconButton(
    //           icon: Icon(
    //               product.isFavorite ? Icons.favorite : Icons.favorite_border),
    //           color: Colors.red,
    //           onPressed: () {
    //             product.toggleFavoriteStatus(
    //               authData.token,
    //               authData.userId,
    //             );
    //           },
    //         ),
    //       ),
    //       title: Text(
    //         product.title,
    //         style: GoogleFonts.raleway(),
    //         textAlign: TextAlign.center,
    //       ),
    //       trailing: IconButton(
    //         icon: Icon(
    //           Icons.shopping_cart,
    //           color: Colors.red,
    //         ),
    //         color: Theme.of(context).accentColor,
    //         onPressed: () {
    //           cart.addItem(product.id, product.price, product.title);
    //           Scaffold.of(context).hideCurrentSnackBar();
    //           Scaffold.of(context).showSnackBar(SnackBar(
    //             backgroundColor: Theme.of(context).accentColor,
    //             content: Text(
    //               'Added item to cart',
    //               style: TextStyle(color: Colors.red),
    //             ),
    //             duration: Duration(milliseconds: 1500),
    //             action: SnackBarAction(
    //               label: 'UNDO',
    //               textColor: Colors.red,
    //               onPressed: () {
    //                 cart.removeSingleItem(product.id);
    //               },
    //             ),
    //           ));
    //         },
    //       ),
    //     ),
    //   ),
    // );
  }
}
