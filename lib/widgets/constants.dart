import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final kTextFieldDecoration = InputDecoration(
  fillColor: Colors.grey.withOpacity(0.9),
  filled: true,
  hintText: '',
  hintStyle: const TextStyle(
    color: Colors.white,
  ),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
  ),
  enabled: true,
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black, width: 1.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueGrey, width: 3.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
  ),
  errorBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red, width: 3.0),
    borderRadius: BorderRadius.all(
      Radius.circular(32),
    ),
  ),
);

TextStyle heading = GoogleFonts.ibarraRealNova(
  textStyle: const TextStyle(
    fontSize: 35,
    fontWeight: FontWeight.w900,
  ),
);

TextStyle smallHeading = GoogleFonts.ibarraRealNova(
  textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  ),
);

TextStyle normalText = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontSize: 14,
  ),
);

TextStyle buttonText = GoogleFonts.poppins(
  textStyle: const TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
  ),
);

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplacement(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
