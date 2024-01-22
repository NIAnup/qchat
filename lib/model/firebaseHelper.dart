import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:q_chat/model/UserModel.dart';

class FirebaseHelper {
  Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;

    DocumentSnapshot document =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (document.data() != null) {
      userModel = UserModel.fromMap(document.data() as Map<String, dynamic>);
    }

    return userModel;
  }
}
