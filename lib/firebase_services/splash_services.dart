import 'dart:async';
import 'package:firebase_crud/firestore/firestore_list_screen.dart';
import 'package:firebase_crud/ui/auth/login_screen.dart';
import 'package:firebase_crud/ui/posts/post_screen.dart';
import 'package:firebase_crud/ui/upload_image.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashService {
  // void IsLogin(){
  //   Timer.periodic(Duration(seconds: 3), (timer){
  //     Get.to(LoginScreen());
  //   });
  // },
  void isLogin() {
    final _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    if (user != null) {
      Future.delayed(Duration(seconds: 3), () {
        Get.off(UploadImage());
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Get.off(LoginScreen());
      });
    }
  }
}
