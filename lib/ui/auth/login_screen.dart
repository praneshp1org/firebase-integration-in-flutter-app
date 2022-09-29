import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
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
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.password),
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
                title: 'Login',
                onTap: (() {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data...')),
                    );
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
