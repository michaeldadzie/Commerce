import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///D:/AndroidStudioProjects/shop_app/lib/features/home/presentation/providers/products.dart';
import 'file:///D:/AndroidStudioProjects/shop_app/lib/features/account/presentation/pages/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    return Card(
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditProductScreen.routeName, arguments: id);
                },
                color: Colors.redAccent,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text('Deleting failed'),
                      ),
                    );
                  }
                },
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
