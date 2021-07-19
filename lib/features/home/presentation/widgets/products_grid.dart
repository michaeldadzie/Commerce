import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shop_app/features/home/presentation/providers/products.dart';
import 'package:shop_app/features/home/presentation/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;
  ProductsGrid(this.showFavs);
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
//        create: (BuildContext context) => products[i],
        value: products[i],
        child: ProductItem(
//          products[i].id,
//          products[i].title,
//          products[i].imageUrl,
            ),
      ),
      gridDelegate: Platform.isWindows
          ? SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 2 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            )
          : SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.6 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
    );
  }
}
