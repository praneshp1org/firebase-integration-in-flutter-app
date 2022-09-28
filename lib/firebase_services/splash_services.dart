import 'dart:async';

import 'package:firebase_crud/ui/auth/login_screen.dart';
import 'package:get/get.dart';

class SplashService {
  // void IsLogin(){
  //   Timer.periodic(Duration(seconds: 3), (timer){
  //     Get.to(LoginScreen());
  //   });
  // },
  void isLogin() {
    Future.delayed(Duration(seconds: 3), () {
      Get.off(LoginScreen());
    });
  }
}
