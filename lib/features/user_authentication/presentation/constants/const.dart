import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final textFormFieldDecoration = InputDecoration(
  hintText: 'Email',
  filled: true,
  hintStyle: GoogleFonts.raleway(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color.fromRGBO(136, 147, 164, 1),
  ),
  errorStyle: GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.red,
  ),
  errorBorder: new OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10),
    borderSide: new BorderSide(color: Colors.red[900]),
  ),
  focusedBorder: new OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10),
    borderSide: new BorderSide(
      color: Colors.red,
    ),
  ),
  enabledBorder: new OutlineInputBorder(
    borderRadius: new BorderRadius.circular(10),
    borderSide: new BorderSide(color: Colors.red[300]),
  ),
);
