import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:shop_app/core/widgets/bottom_nav.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_app/features/account/data/model/user.dart';
import 'package:shop_app/features/account/presentation/widgets/custom_textfield_container.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final firestoreInstance = FirebaseFirestore.instance;
  File _image;
  bool _validate = false;
  final fname = TextEditingController();
  final lname = TextEditingController();
  final tnumber = TextEditingController();
  final dob = TextEditingController();
  final ccode = TextEditingController();

  void _saveUserInfoToHive(Box<UserInfoModel> _userInfobox) {
    final UserInfoModel userInfoModel = UserInfoModel(
      fname: fname.text,
      lname: lname.text,
      photoUrl: _image.path,
      tnumber: tnumber.text,
      ccode: ccode.text,
    );
    print('Saving User Info ${userInfoModel.fname}');
    _userInfobox.add(userInfoModel);
  }

  @override
  void dispose() {
    fname.dispose();
    lname.dispose();
    tnumber.dispose();
    ccode.dispose();
    super.dispose();
  }

  //Select image from camera
  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  //Select image from gallery
  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: [
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text(
                      'Photo Library',
                      style: GoogleFonts.raleway(
                          color: Theme.of(context).accentColor),
                    ),
                    onTap: () {
                      _imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text(
                    'Camera',
                    style: GoogleFonts.raleway(
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Box<UserInfoModel> _userInfoBox =
        Provider.of<Box<UserInfoModel>>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Set up your account',
            style: GoogleFonts.raleway(color: Colors.red),
          ),
          iconTheme: IconThemeData(color: Colors.red),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          child: _image != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    child: Image.file(
                                      _image,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    //First Name
                    CustomTextFieldContainer(
                      title: 'First Name',
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: fname,
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                          decoration: InputDecoration(
                            errorText:
                                _validate ? 'Value can\'t be empty' : null,
                            errorStyle: GoogleFonts.raleway(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.red,
                            ),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15), //margin
                    //Last Name
                    CustomTextFieldContainer(
                      title: 'Last Name',
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          controller: lname,
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).accentColor,
                          ),
                          decoration: InputDecoration(
                            errorText:
                                _validate ? 'Value can\'t be empty' : null,
                            errorStyle: GoogleFonts.raleway(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.red,
                            ),
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.w100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Telephone Number',
                      style: GoogleFonts.lato(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: TextField(
                                controller: tnumber,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.lato(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).accentColor),
                                decoration: InputDecoration(
                                  errorText: _validate
                                      ? 'Value can\'t be empty'
                                      : null,
                                  errorStyle: GoogleFonts.raleway(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.red,
                                  ),
                                  border: InputBorder.none,
                                  hintStyle: GoogleFonts.raleway(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w100,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 40,
                              height: 40,
                              child: CountryCodePicker(
                                //flutter package on pub.dev
                                onChanged: (country) {
                                  ccode.text = country.code;
                                },
                                initialSelection: 'GH',
                                favorite: ['+233', 'GH'],
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: false,
                                showFlag: true,
                                flagWidth: 25,
                                alignLeft: false,
                                dialogSize: Size(500, 400),
                                boxDecoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 6,
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                  color: Theme.of(context).primaryColor,
                                ),
                                showDropDownButton: true,
                                closeIcon: Icon(
                                  Icons.close,
                                  color: Theme.of(context).accentColor,
                                ),
                                dialogTextStyle: GoogleFonts.raleway(
                                    color: Theme.of(context).accentColor),
                                dialogBackgroundColor:
                                    Theme.of(context).focusColor,
                                hideSearch: true,
                                textStyle: GoogleFonts.raleway(
                                    fontSize: 15,
                                    color: Theme.of(context).accentColor),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            fname.text.isEmpty && lname.text.isEmpty
                                ? _validate = true
                                : _validate = false;
                          });
                          //alert users to fill every field
                          _saveUserInfoToHive(_userInfoBox);
                          firestoreInstance.collection("users").add({
                            "fname": fname.text,
                            "lname": lname.text,
                            "telephone": {
                              "ccode": ccode.text == null ? '+233' : ccode.text,
                              "tnumber": tnumber.text
                            }
                          }).then((value) {
                            print(value.id);
                          });
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()),
                              (Route<dynamic> route) => false);
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.only(
                              left: 30,
                              right: 30,
                              top: 20,
                              bottom: 20,
                            ),
                          ),
                          elevation: MaterialStateProperty.all(0),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
