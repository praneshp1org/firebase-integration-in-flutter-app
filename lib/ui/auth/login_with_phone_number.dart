import 'package:firebase_crud/ui/auth/verify_code.dart';
import 'package:firebase_crud/utils/utils.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final _phoneNumberController = TextEditingController();
  bool _loading = false;
  final _auth = FirebaseAuth.instance;

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
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone), hintText: '+1 234 5678 901'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'Login',
                loading: _loading,
                onTap: () {
                  setState(() {
                    _loading = true;
                  });
                  _auth.verifyPhoneNumber(
                      phoneNumber: _phoneNumberController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          _loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        toastUtil().showToast(e.toString());
                        setState(() {
                          _loading = false;
                        });
                      },
                      codeSent: (String verificationId, int? token) {
                        Get.to(
                            VerifyCodeScreen(verificationId: verificationId));
                        setState(() {
                          _loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        toastUtil().showToast(e.toString());
                        setState(() {
                          _loading = false;
                        });
                      });
                })
          ],
        ),
      ),
    );
  }
}
