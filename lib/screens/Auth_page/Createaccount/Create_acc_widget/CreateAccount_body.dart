import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:q_chat/model/UIhelper.dart';
import 'package:q_chat/model/UserModel.dart';
import '../../../profile/profile.dart';
import '../../Login/login_style/login_style_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Create_account_body extends StatefulWidget {
  const Create_account_body({super.key});

  @override
  State<Create_account_body> createState() => _Create_account_bodyState();
}

class _Create_account_bodyState extends State<Create_account_body> {
  bool _isObscure = true;
  TextEditingController emailcreate_Controller = TextEditingController();
  TextEditingController passwordcreate_Controller = TextEditingController();
  TextEditingController confirmpassword_Controller = TextEditingController();

  final _createAccountFormKey = GlobalKey<FormState>();

  void createAccount() async {
    String email = emailcreate_Controller.text.trim();
    String pass = passwordcreate_Controller.text.trim();
    String confirmPass = confirmpassword_Controller.text.trim();

    if (email.isEmpty || pass.isEmpty || confirmPass.isEmpty) {
      UIHelper.showAlertDialog(
          context, "Incomplete data", "fill all the detailes");
      log("Please fill all the details");
    } else if (pass != confirmPass) {
      UIHelper.showAlertDialog(
          context, "Password mismatch", "Password do not match!");
      log("Password do not match!");
    } else {
      sigup(email, pass);
    }
  }

  void sigup(String email, String passwords) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Creating new account..");
    try {
      credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: passwords);
    } on FirebaseAuthException catch (ex) {
      Navigator.pop(context);
      UIHelper.showAlertDialog(
          context, "An Error Occured", ex.message.toString());
      log(ex.code.toString());
    }
    if (credential != null) {
      String uid = credential.user!.uid;

      UserModel newUser =
          UserModel(uid: uid, email: email, name: "", profilepic: '');
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set(newUser.toMap());
      log("new user created");
      Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
              builder: (context) => Profile(
                  userModel: newUser, firebaseUser: credential!.user!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
        key: _createAccountFormKey,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // This is Email TextFormField

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    controller: emailcreate_Controller,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )),
              ),

              //This is password TextFormField

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    obscureText: _isObscure,
                    controller: passwordcreate_Controller,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            style: BorderStyle.solid),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    obscureText: _isObscure,
                    controller: confirmpassword_Controller,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            style: BorderStyle.solid),
                      ),
                    )),
              ),

              // Sign In Button

              ElevatedButton(
                  style: loginButton,
                  onPressed: () {
                    createAccount();
                  },
                  child: const Text(
                    "Create Account",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  )),
            ]),
      ),
    ));
  }
}
