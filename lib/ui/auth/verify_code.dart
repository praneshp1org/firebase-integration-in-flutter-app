import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud/ui/posts/post_screen.dart';
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
  final _codeNumberController = TextEditingController();
  bool _loading = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
              controller: _codeNumberController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.verified), hintText: '6 digit code'),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: 'Verify',
                loading: _loading,
                onTap: () async {
                  setState(() {
                    _loading = true;
                  });
                  final _credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: _codeNumberController.text.toString());

                  try {
                    _auth.signInWithCredential(_credential);
                    Get.off(PostScreen());
                  } catch (e) {
                    setState(() {
                      _loading = false;
                    });
                    toastUtil().showToast('Error in verification');
                  }
                })
          ],
        ),
      ),
    );
  }
}
