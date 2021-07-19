import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/features/home/presentation/providers/products.dart';

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
    return Scaffold(
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            iconTheme: new IconThemeData(color: Colors.red),
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                loadedProduct.title,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.red),
              ),
              background: Hero(
                tag: loadedProduct.id,
                child: Image.network(
                  loadedProduct.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 10),
              Text(
                '\$${loadedProduct.price}',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  loadedProduct.description,
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
              SizedBox(
                height: 800,
              )
            ]),
          ),
        ],
      ),
    );
  }
}
