import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/core/exception/http_exception.dart';
import 'package:shop_app/features/user_authentication/presentation/constants/const.dart';
import 'package:shop_app/features/user_authentication/presentation/pages/auth_screen.dart';
import 'package:shop_app/features/user_authentication/presentation/providers/auth.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();
  AnimationController _controller;
  Animation<Size> _heighAnimation;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _heighAnimation = Tween<Size>(
      begin: Size(double.infinity, 260),
      end: Size(double.infinity, 320),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    // _heighAnimation.addListener(() => setState(() {}));
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An error occurred',
          style: GoogleFonts.raleway(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        content: Text(
          message,
          style: GoogleFonts.raleway(fontSize: 16),
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              'Okay',
              style: GoogleFonts.raleway(color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authMode == AuthMode.Login) {
        // Log user in
        await Provider.of<Auth>(context, listen: false).login(
          _authData['email'],
          _authData['password'],
        );
      } else {
        // Sign user up
        await Provider.of<Auth>(context, listen: false).signup(
          _authData['email'],
          _authData['password'],
        );
      }
    } on HttpException catch (error) {
      print(error);
      var errorMessage = 'Authenticate failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address already in use';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (errorMessage.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak';
      } else if (errorMessage.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find user with this email';
      } else if (errorMessage.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage = 'Could not authenticate try again later';
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 0,
      child: AnimatedBuilder(
        animation: _heighAnimation,
        builder: (ctx, ch) => Container(
            // height: _authMode == AuthMode.Signup ? 320 : 260,
            height: _heighAnimation.value.height,
            constraints: BoxConstraints(
              minHeight: _heighAnimation.value.height,
            ),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16.0),
            child: ch),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration:
                      textFormFieldDecoration.copyWith(hintText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                SizedBox(height: 8),
                TextFormField(
                  decoration:
                      textFormFieldDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                SizedBox(height: 8),
                // if (_authMode == AuthMode.Signup)
                AnimatedContainer(
                  constraints: BoxConstraints(
                    minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                    maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                  ),
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: TextFormField(
                        enabled: _authMode == AuthMode.Signup,
                        decoration: textFormFieldDecoration.copyWith(
                            hintText: 'Confirm Password'),
                        obscureText: true,
                        validator: _authMode == AuthMode.Signup
                            // ignore: missing_return
                            ? (value) {
                                if (value != _passwordController.text) {
                                  return 'Passwords do not match!';
                                }
                              }
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  )
                else
                  RaisedButton(
                    child: Text(
                      _authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP',
                      style: GoogleFonts.raleway(
                          color: Theme.of(context).accentColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                    onPressed: _submit,
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Colors.red,
                  ),
                FlatButton(
                  child: Text(
                    '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'}',
                    style: GoogleFonts.raleway(
                        color: Theme.of(context).accentColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: _switchAuthMode,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
