//  import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:q_chat/model/chatuser.dart';
// import 'package:q_chat/screens/profile/profile_widget/profile_detail_body.dart';

// class Apis{
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//    static FirebaseFirestore firebase =FirebaseFirestore.instance;
//  User get users => _auth.currentUser!; 
// Future<bool> creatinguser()async{
//     final chatuser =Chatuser(id: _auth.currentUser!.uid.toString(), email:  _auth.currentUser!.email.toString(), name:  _auth.currentUser!.displayName.toString(), bio: user.bio, image: _auth.currentUser!.photoURL.toString(), createdDate: createdDate, isOnline: isOnline, pushToken: pushToken, lastActive: lastActive)
//   return (await firebase 
//   .collection('users').doc(_auth.currentUser!.uid).get()).exists;
  
//   }
//} 
