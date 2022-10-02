import 'package:firebase_crud/ui/auth/login_screen.dart';
import 'package:firebase_crud/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        SystemNavigator.pop();
        return true;
      }),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Posts'),
          actions: [
            IconButton(
                onPressed: () {
                  //logout feature
                  _auth.signOut().then((value) {
                    Get.to(LoginScreen());
                  }).onError((error, stackTrace) {
                    toastUtil().showToast(error.toString());
                  });
                },
                icon: Icon(Icons.logout)),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
