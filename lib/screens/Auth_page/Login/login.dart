import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q_chat/model/UIhelper.dart';
import 'package:q_chat/model/UserModel.dart';

import 'package:q_chat/screens/Auth_page/Createaccount/createaccount.dart';
import 'package:q_chat/screens/Auth_page/Login/login_style/login_style_page.dart';

import 'package:q_chat/screens/Auth_page/Login/widget/login_appbar.dart';
import 'package:q_chat/screens/Auth_page/forget/forget.dart';

import '../../profile/profile.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;

  /// Textfield controller
  TextEditingController email_Controller = TextEditingController();
  TextEditingController password_Controller = TextEditingController();

  final _loginFormKey = GlobalKey<FormState>();

// firebase  and firebaseFirestore
  void checkValue() async {
    String emaillogin = email_Controller.text.trim();
    String passlogin = password_Controller.text.trim();

    if (emaillogin.isEmpty || passlogin.isEmpty) {
      UIHelper.showAlertDialog(context, "Incomplete data", "fill all detailes");
      log("fill all detailes");
    } else {
      login(emaillogin, passlogin);
    }
  }

  void login(String email, String password) async {
    UserCredential? credential;

    UIHelper.showLoadingDialog(context, "Logging In..");

    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (ex) {
      // close the loading dialog
      Navigator.pop(context);
      UIHelper.showAlertDialog(
          context, "An error occured", ex.message.toString());
      log(ex.message.toString());
    }

    if (credential != null) {
      String uid = credential.user!.uid;
      UserModel newUser =
          UserModel(uid: uid, email: email, name: "", profilepic: '');
      DocumentSnapshot userdata =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      UserModel userModel =
          UserModel.fromMap(userdata.data() as Map<String, dynamic>);
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context as BuildContext,
          MaterialPageRoute(
              builder: (context) => Profile(
                  userModel: newUser, firebaseUser: credential!.user!)));
      print("login successful");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: loginAppbar,
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // This is Email TextFormField

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                    controller: email_Controller,
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
                    controller: password_Controller,
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

              // Forget password Button

              TextButton(
                  onPressed: () => const Forgetbutton(),
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  )),

              // Sign In Button

              ElevatedButton(
                  style: loginButton,
                  onPressed: () {
                    checkValue();
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  )),

              const Text(
                " ----- or -----",
                style: TextStyle(fontSize: 15),
              ),

              const SizedBox(
                height: 30,
              ),

              /// Create account Button
              ///
              ///
              OutlinedButton(
                style: facebookbuttonstyle,
                onPressed: () {
                  Navigator.push(
                      context as BuildContext,
                      MaterialPageRoute(
                          builder: (context) => const Create_Account()));
                },
                child: const Text("Create Account ",
                    style: TextStyle(
                        color: Color.fromARGB(255, 25, 0, 253), fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
