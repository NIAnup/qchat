import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q_chat/model/UserModel.dart';
import 'package:q_chat/model/firebaseHelper.dart';
import 'package:q_chat/screens/home_page/homepage.dart';
// ignore: unused_import
import 'package:q_chat/screens/profile/profile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:q_chat/screens/start_screen/start.dart';
import 'package:uuid/uuid.dart';
import 'firebase_options.dart';

var uuid = const Uuid();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    // logged in
    UserModel? thisuserModel =
        await FirebaseHelper().getUserModelById(currentUser.uid);

    if (thisuserModel != null) {
      runApp(MyAppLoggedIn(
        userModel: thisuserModel,
        firebaseUser: currentUser,
      ));
    }
  } else {
// not logged in
    runApp(const MyApp());
  }
// options: DefaultFirebaseOptions.currentPlatform
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: start_page());
  }
}

// Already Logged In
class MyAppLoggedIn extends StatelessWidget {
  final UserModel userModel;
  final User firebaseUser;

  const MyAppLoggedIn(
      {Key? key, required this.userModel, required this.firebaseUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(userModel: userModel, firebaseUser: firebaseUser),
    );
  }
}
