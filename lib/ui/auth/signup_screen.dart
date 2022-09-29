import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); //checks if empty or not
  /*
  form validator dlutter documentation ma ramro xa
  */

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _passwordController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          'SIGN UP',
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
              title: 'Sign Up',
              onTap: (() {
                if (_formKey.currentState!.validate()) {
                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data...')),
                  // );
                  _auth.createUserWithEmailAndPassword(
                      email: _emailController.text.toString(),
                      password: _passwordController.text.toString());
                }
              }),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account? '),
                // SizedBox(
                //   width: 5,
                // ),
                TextButton(
                    onPressed: () {
                      Get.offNamed('/login');
                    },
                    child: Text('Login')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
