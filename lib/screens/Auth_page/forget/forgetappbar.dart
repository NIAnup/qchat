import 'package:flutter/material.dart';

final AppBar ForgetAppbar = AppBar(
  leading: IconButton(
      onPressed: () {
        ;
      },
      icon: const Icon(Icons.arrow_back_ios)),
  backgroundColor: Colors.transparent,
  title: const Text(
    "Forget Password ",
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
  ),
  centerTitle: true,
  elevation: 0,
);
