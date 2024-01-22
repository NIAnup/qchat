import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q_chat/model/UserModel.dart';
import 'package:q_chat/model/chatRoomModel.dart';
import 'package:q_chat/screens/ChatRoom/chatroom.dart';

import '../../main.dart';

class SearchPage extends StatefulWidget {
  final UserModel userModel;
  final User firebaseuser;
  const SearchPage(
      {super.key, required this.userModel, required this.firebaseuser});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();

  Future<ChatRoomModel?> getchatroomModel(UserModel tragetUser) async {
    ChatRoomModel? chatRoom;

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${widget.firebaseuser.uid}", isEqualTo: true)
        .where("participants.${tragetUser.uid}", isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      //fetch the existing one

      var docdata = snapshot.docs[0].data();
      ChatRoomModel existingChatroom =
          ChatRoomModel.fromMap(docdata as Map<String, dynamic>);

      chatRoom = existingChatroom;
      log("chatroom already created");
    } else {
      // create a new one
      ChatRoomModel newChatRoom =
          ChatRoomModel(chatroomid: uuid.v1(), lastMessage: "", participants: {
        widget.userModel.uid.toString(): true,
        tragetUser.uid.toString(): true,
      });
      await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(newChatRoom.chatroomid)
          .set(newChatRoom.toMap());

      chatRoom = newChatRoom;
      log("new chat room create");
    }
    return chatRoom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Search",
            style: TextStyle(color: Color.fromARGB(255, 4, 0, 255)),
          ),
        ),
        body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 15,
              ),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12)),
                                hintText: "Enter Email"),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .where("email", isEqualTo: searchController.text)
                          .where("email", isNotEqualTo: widget.userModel.name)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData) {
                            QuerySnapshot dataSnapshot =
                                snapshot.data as QuerySnapshot;

                            if (dataSnapshot.docs.length > 0) {
                              Map<String, dynamic> userMap =
                                  dataSnapshot.docs[0].data()
                                      as Map<String, dynamic>;

                              UserModel searchUser = UserModel.fromMap(userMap);

                              return ListTile(
                                onTap: () async {
                                  ChatRoomModel? chatroomModel =
                                      await getchatroomModel(searchUser);
                                  if (chatroomModel != null) {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                ChatRoomPage(
                                                  targetUser: searchUser,
                                                  chatroom: chatroomModel,
                                                  firebaseUser:
                                                      widget.firebaseuser,
                                                  userModel: widget.userModel,
                                                )));
                                  }
                                },
                                leading: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(searchUser.profilepic!),
                                  backgroundColor: Colors.grey[500],
                                ),
                                title: Text(searchUser.name!),
                                subtitle: Text(searchUser.email!),
                                trailing:
                                    Icon(Icons.keyboard_arrow_right_outlined),
                              );
                            } else {
                              return Text("No results found!");
                            }
                          } else if (snapshot.hasError) {
                            return Text("An error occured!");
                          } else {
                            return Text("No results found!");
                          }
                        } else {
                          return CircularProgressIndicator();
                        }
                      })
                ],
              )),
        ));
  }
}
