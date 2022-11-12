import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/utils/utils.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            RoundButton(
                title: 'Recover',
                onTap: () {
                  _auth
                      .sendPasswordResetEmail(
                          email: _emailController.text.toString())
                      .then((value) {
                    toastUtil().showToast('Recovery mail sent...');
                  }).onError((error, stackTrace) {
                    toastUtil().showToast('Some error occured');
                  });
                })
          ],
        ),
      ),
    );
  }
}
