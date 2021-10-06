import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/features/home/presentation/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  CartItem(this.id, this.productId, this.price, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      // ignore: missing_return
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text(
                    'Are you sure?',
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  content: Text(
                    'Do you want to remove item from the cart?',
                    style: GoogleFonts.raleway(),
                  ),
                  actions: [
                    FlatButton(
                        child: Text(
                          'No',
                          style: GoogleFonts.raleway(),
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        }),
                    FlatButton(
                        child: Text(
                          'Yes',
                          style: GoogleFonts.raleway(),
                        ),
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                        })
                  ],
                ));
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    '\GH¢$price',
                    style: GoogleFonts.lato(
                        color: Theme.of(context).accentColor, fontSize: 15),
                  ),
                ),
              ),
            ),
            title: Text(
              title,
              style: GoogleFonts.raleway(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Text(
              'Total: \GH¢${(price * quantity)}',
              style: GoogleFonts.lato(fontSize: 15),
            ),
            trailing: Text(
              '$quantity x',
              style: GoogleFonts.lato(),
            ),
          ),
        ),
      ),
    );
  }
}
