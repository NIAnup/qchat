// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Createaccount_Appbar extends StatefulWidget {
  const Createaccount_Appbar({super.key});

  @override
  State<Createaccount_Appbar> createState() => _Createaccount_AppbarState();
}

class _Createaccount_AppbarState extends State<Createaccount_Appbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Create Account',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
