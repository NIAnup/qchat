import 'package:flutter/material.dart';
import 'package:q_chat/screens/Auth_page/Login/login.dart';

// ignore: camel_case_types
class start_page extends StatelessWidget {
  const start_page({super.key});

  @override
  Widget build(BuildContext context) {
    void start_btn() {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(context as BuildContext,
          MaterialPageRoute(builder: (Context) => Login()));
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset(
              "assets/images/Illustration.png",
              fit: BoxFit.contain,
              height: 250,
              width: 400,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Connect easily \n with your family and friends \n over countries",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Terms & Privacy Policy',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                )),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(330, 50),
                    backgroundColor: const Color.fromARGB(255, 15, 91, 255),
                    elevation: 0,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
                onPressed: () {
                  start_btn();
                },
                child: const Text("Start Messaging",
                    style: TextStyle(color: Colors.white, fontSize: 15))),
          ],
        ),
      ),
    );
  }
}
