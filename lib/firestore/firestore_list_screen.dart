import 'package:firebase_crud/firestore/add_firestore_data.dart';
import 'package:firebase_crud/ui/auth/login_screen.dart';
import 'package:firebase_crud/ui/posts/add_posts.dart';
import 'package:firebase_crud/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final _auth = FirebaseAuth.instance;

  final _editFilter = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        SystemNavigator.pop();
        return true;
      }),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => AddFirestoreDataScreen());
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text('Firestore list screen'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      title: 'Log Out?',
                      content: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Cancel')),
                              TextButton(
                                  onPressed: () {
                                    //logout feature
                                    _auth.signOut().then((value) {
                                      toastUtil()
                                          .showToast('Successfully logged out');
                                      Get.to(LoginScreen());
                                    }).onError((error, stackTrace) {
                                      toastUtil().showToast(error.toString());
                                    });
                                  },
                                  child: Text('Log out'))
                            ],
                          )
                        ],
                      ));
                },
                icon: Icon(Icons.logout)),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
                //needs to be wrapped with expanded widget
                child: ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                title: Text('pranisha'),
              );
            })),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String title, String id) async {
    _editFilter.text = title;
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update'),
          content: Container(
            child: TextFormField(
              controller: _editFilter,
              decoration: InputDecoration(
                hintText: 'Update your message',
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Update'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
