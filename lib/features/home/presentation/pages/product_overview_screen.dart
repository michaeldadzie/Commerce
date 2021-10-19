import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/utils/screen_sizes.dart';
import 'package:shop_app/features/home/presentation/providers/cart.dart';
import 'package:shop_app/features/home/presentation/providers/products.dart';
import 'package:shop_app/features/home/presentation/pages/cart_screen.dart';
import 'package:shop_app/core/widgets/app_drawer.dart';
import 'package:shop_app/features/home/presentation/widgets/badge.dart';
import 'package:shop_app/features/home/presentation/widgets/products_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
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

  @override
  void initState() {
//    Provider.of<Products>(context).fetchAndSetProducts();
//    Future.delayed(Duration.zero).then((value) {
//      Provider.of<Products>(context).fetchAndSetProducts();
//    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final node = FocusScope.of(context);
    ScreenUtil.init(
      context,
      designSize: Size(
        MyScreenSizes.screenWidth,
        MyScreenSizes.screenHeight,
      ),
      allowFontScaling: true,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
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
        title: Text(
          'Soulll Shop',
          style: GoogleFonts.raleway(color: Colors.red),
        ),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              color: Colors.red,
            ),
            child: IconButton(
              icon: Icon(
                FontAwesome.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only Favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      key: scaffoldKey,
      // drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            )
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
