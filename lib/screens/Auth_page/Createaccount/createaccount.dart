// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:q_chat/screens/Auth_page/Createaccount/Create_acc_widget/CreateAccount_body.dart';
import 'package:q_chat/screens/Auth_page/Createaccount/Create_acc_widget/create_acc_appbar.dart';

class Create_Account extends StatelessWidget {
  const Create_Account({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70), child: Createaccount_Appbar()),
      body: Create_account_body(),
    );
  }
}
