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
      "text": "Welcome to the Qfood checker App",
      "image": "assets/images/product-loading.gif"
    },
    {
      "text": "Welcome to the Qfood checker App",
      "image": "assets/images/product-loading.gif"
    },
    {
      "text": "Welcome to the Qfood checker App",
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
                  image: splashData[index]["image"],
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
                        Navigator.of(context).pushNamed(
                          AuthScreen.routeName,
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
