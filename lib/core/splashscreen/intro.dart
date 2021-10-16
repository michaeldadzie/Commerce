import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/core/splashscreen/intro_content.dart';
import 'package:shop_app/core/widgets/custom_button.dart';
import 'package:shop_app/features/user_authentication/presentation/pages/auth_screen.dart';

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {
      "text": "Start your soulll shop journey now",
      "image": "assets/images/icon.png"
    },
    {
      "text":
          "Get started it's easy, create an account or login and start browsing through products",
      "image": "assets/images/product-loading.gif"
    },
    {
      "text": "Add products to your cart, check previous orders",
      "image": "assets/images/product-loading.gif"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: splashData.length,
                itemBuilder: (context, index) => IntroContent(
                  image: splashData[index]['image'],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    CustomButton(
                      title: 'Contnue',
                      bordersideColor: Colors.red,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      onPress: () {
                        // Navigator.of(context).pushReplacementNamed(
                        //     AuthScreen.routeName,
                        //     arguments: AuthMode);
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => AuthScreen(),
                          ),
                        );
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.red : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
