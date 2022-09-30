import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

final _phoneNumberController = TextEditingController();
bool _loading = false;
final _auth = FirebaseAuth.instance;

class _LoginWithPhoneState extends State<LoginWithPhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LOGIN WITH PHONE NUMBER',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone), hintText: '+1 234 5678 901'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(title: 'Login', onTap: () {})
          ],
        ),
      ),
    );
  }
}
