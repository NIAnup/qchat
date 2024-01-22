import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q_chat/screens/profile/profile.dart';
import 'package:q_chat/screens/search/search.dart';
import 'package:q_chat/screens/start_screen/start.dart';

import '../../../model/UserModel.dart';

class HomeAppbar extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;
  const HomeAppbar(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  Widget build(BuildContext context) {
    void logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context as BuildContext,
          MaterialPageRoute(builder: (context) => const start_page()));
      log('error');
    }

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0.8,

      // Appbar tittle
      title: Image.asset(
        "assets/images/a314a0164025781.63ef8933c13b5-removebg-preview.png",
        height: 110,
      ),
      centerTitle: true,

      // User profile Button
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Profile(userModel: userModel, firebaseUser: firebaseUser);
            }));
          },
          icon: const Icon(
            Icons.account_circle,
            size: 35,
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
        ),
        IconButton(
          onPressed: () {
            logout();
          },
          icon: const Icon(
            Icons.exit_to_app_outlined,
            size: 35,
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
        )
      ],
    );
  }
}
