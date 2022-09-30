import 'package:firebase_crud/ui/auth/login_with_phone_number.dart';
import 'package:firebase_crud/ui/posts/post_screen.dart';
import 'package:firebase_crud/utils/utils.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //checks if empty or not
  /*
  form validator dlutter documentation ma ramro xa
  */
  bool _showText = false;
  final _auth = FirebaseAuth.instance;
  toastUtil _util = toastUtil();
  bool _loading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  void login() {
    setState(() {
      _loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text.toString(),
            password: _passwordController.text.toString())
        .then((value) {
      _util.showToast('The user is successfully logged in!');
      Get.to(() => PostScreen());
      setState(() {
        _loading = false;
      });
    }).onError((error, stackTrace) {
      _util.showToast(error.toString());
      debugPrint(error.toString());
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        //hardware exit
        SystemNavigator.pop();
        return true;
      }),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'LOGIN',
            style: TextStyle(fontSize: 15),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email),
                            helperText: 'E.g. abcd@gmail.com',
                            hintText: 'Email'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        obscureText: _showText,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showText = !_showText;
                                  });
                                },
                                icon: _showText
                                    ? Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.purple,
                                      )
                                    : Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.red,
                                      )),
                            // helperText: 'stronm',
                            hintText: 'Password'),
                        validator: ((value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        }),
                      ),
                    ],
                  )),
              SizedBox(
                height: 50,
              ),
              RoundButton(
                loading: _loading,
                title: 'Login',
                onTap: (() {
                  if (_formKey.currentState!.validate()) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data...')),
                    // );
                    login();
                  }
                }),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('No account? '),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  TextButton(
                      onPressed: () {
                        Get.toNamed('/signup');
                      },
                      child: Text('Sign Up')),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(LoginWithPhone());
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      border: Border.all(color: Colors.black)),
                  height: 50,
                  child: Center(child: Text('Login with phone number')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
