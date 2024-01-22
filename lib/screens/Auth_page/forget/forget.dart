import 'package:flutter/material.dart';

class Forgetbutton extends StatelessWidget {
  const Forgetbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)),
      backgroundColor: Colors.transparent,
      title: const Text(
        "Forget Password ",
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
      ),
      centerTitle: true,
      elevation: 0,
    ));
  }
}
