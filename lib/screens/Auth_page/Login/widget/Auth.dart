import 'package:flutter/material.dart';
import 'package:q_chat/screens/Auth_page/Login/login_style/login_style_page.dart';

// Google login button
final OutlinedButton Googlelogin = OutlinedButton(
  style: googlebuttonstyle,
  onPressed: () {},
  child: Image.asset(
    "assets/images/googlevector.png",
    fit: BoxFit.cover,
    height: 40,
  ),
);

// Facebook login button
final OutlinedButton Create_Acoount_Btn = OutlinedButton(
  style: facebookbuttonstyle,
  onPressed: () {},
  child: Text("Create Account ",
      style: TextStyle(color: Color.fromARGB(255, 25, 0, 253), fontSize: 20)),
);
