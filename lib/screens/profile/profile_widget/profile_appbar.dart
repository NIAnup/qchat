import 'package:flutter/material.dart';

class Profileappbar extends StatefulWidget {
  const Profileappbar({super.key});

  @override
  State<Profileappbar> createState() => _ProfileappbarState();
}

class _ProfileappbarState extends State<Profileappbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Profile',
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }
}
