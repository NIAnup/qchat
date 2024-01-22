import 'package:flutter/material.dart';

final ButtonStyle loginButton = ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 0, 61, 228),
    minimumSize: const Size(320, 50),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50))));

final ButtonStyle googlebuttonstyle = OutlinedButton.styleFrom(
    minimumSize: const Size(320, 50),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        side: BorderSide(color: Colors.black)));

final ButtonStyle facebookbuttonstyle = OutlinedButton.styleFrom(
    minimumSize: const Size(320, 50),
    elevation: 0,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        side: BorderSide(color: Colors.black)));
