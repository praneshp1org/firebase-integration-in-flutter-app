import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/utils/utils.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _phoneNumberController = TextEditingController();
  bool _loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CODE VERIFICATION',
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
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.verified), hintText: '6 digit code'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(title: 'Verify', loading: _loading, onTap: () {})
          ],
        ),
      ),
    );
  }
}
