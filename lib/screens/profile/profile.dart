import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:q_chat/model/UIhelper.dart';
import 'package:q_chat/model/UserModel.dart';
import 'package:q_chat/screens/home_page/homepage.dart';
import 'package:q_chat/screens/profile/profile_widget/profile_appbar.dart';

class Profile extends StatefulWidget {
  final UserModel userModel;
  final User firebaseUser;
  const Profile(
      {super.key, required this.userModel, required this.firebaseUser});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? imageFile;
  TextEditingController fname = TextEditingController();
  TextEditingController fullbio = TextEditingController();

  final _profileFormKey = GlobalKey<FormState>();

  // This function for selectimage form gallery
  Future selectImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );

    if (pickedFile == null) return;
    setState(() {
      imageFile = File(pickedFile!.path);
      imageFile = File(pickedFile!.path);
    });
  }

// This function for cameraimage form camera
  Future cameraImage() async {
    final cameraFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 40);

    if (cameraFile == null) return;
    setState(() {
      imageFile = File(cameraFile.path);
      imageFile = File(cameraFile.path);
    });
  }

  void showPhotoOption() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Upload Profile Picture"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    selectImage();
                  },
                  title: const Text("select form Gallery"),
                  leading: const Icon(Icons.photo_album_outlined),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    cameraImage();
                  },
                  title: const Text("Take a photo"),
                  leading: const Icon(CupertinoIcons.camera),
                ),
              ],
            ),
          );
        });
  }

  void checkValues() {
    String fullname = fname.text.trim();
    String bio = fullbio.text.trim();

    if (fullname.isEmpty || bio.isEmpty) {
      UIHelper.showAlertDialog(
          context, "Incomplete data", "please fill all the feild ");
      print("please fill all the feild ");
    } else {
      log("uploading data..");
      uploadData();
    }
  }

  void uploadData() async {
    UIHelper.showLoadingDialog(context, "Uploading image..");
    UploadTask uploadTask = FirebaseStorage.instance
        .ref("profilepictures")
        .child(widget.userModel.uid.toString())
        .putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();
    String? fullname = fname.text.trim();
    String? bio = fullbio.text.trim();

    widget.userModel.name = fullname;
    widget.userModel.profilepic = imageUrl;
    widget.userModel.bio = bio;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userModel.uid)
        .set(widget.userModel.toMap())
        .then((value) {
      log("Data uploaded!");
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return Homepage(
              userModel: widget.userModel, firebaseUser: widget.firebaseUser);
        }),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CupertinoColors.tertiarySystemBackground,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70), child: Profileappbar()),
        body: SafeArea(

            ///
            ///
            ///
            // Profile image
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: Form(
                  key: _profileFormKey,
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CupertinoButton(
                        onPressed: () {
                          showPhotoOption();
                        },
                        child: CircleAvatar(
                          backgroundImage: (imageFile != null)
                              ? FileImage(imageFile!)
                              : null,
                          backgroundColor: Color.fromARGB(255, 202, 202, 202),
                          radius: 80,
                          child: (imageFile == null)
                              ? Icon(
                                  CupertinoIcons.person,
                                  color: Color.fromARGB(255, 30, 31, 32),
                                  size: 60,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///
                      ///
                      ///
                      ///
                      /// Fullname Textformfeild
                      TextFormField(
                        controller: fname,
                        decoration: const InputDecoration(
                            labelText: "Fullname",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black))),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      ///
                      ///
                      ///
                      ///
                      /// Bio  Textformfeild
                      TextFormField(
                        controller: fullbio,
                        decoration: const InputDecoration(
                            labelText: "Bio", border: OutlineInputBorder()),
                      ),

                      const SizedBox(
                        height: 50,
                      ),
                      ////
                      ///
                      ///
                      ///
                      /// this is Submit Btn
                      ///
                      ///
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 31, 15, 248),
                              minimumSize: Size(400, 60),
                              side: const BorderSide(
                                width: 3,
                                color: Color.fromARGB(255, 31, 15, 248),
                              ),
                              foregroundColor:
                                  const Color.fromARGB(255, 5, 36, 214)),
                          onPressed: () {
                            checkValues();
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ))
                    ],
                  ),
                ))));
  }
}
