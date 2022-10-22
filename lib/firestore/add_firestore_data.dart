import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud/utils/utils.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';

class AddFirestoreDataScreen extends StatefulWidget {
  const AddFirestoreDataScreen({super.key});

  @override
  State<AddFirestoreDataScreen> createState() => _AddFirestoreDataScreenState();
}

bool _loading = false; //ref of table
//post wala table ma sabai save hunxa
final _postController = TextEditingController();
final fireStore = FirebaseFirestore.instance.collection('users');

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Firestore data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: _postController,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        _postController.clear();
                      },
                      icon: Icon(Icons.clear)),
                  hintText: 'Write something...',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                loading: _loading,
                title: 'Add',
                onTap: () {
                  setState(() {
                    _loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();

                  fireStore.doc(id).set({
                    'title': _postController.text.toString(),
                    'id': id
                  }).then((value) {
                    toastUtil().showToast('Data added!');
                    setState(() {
                      _loading = false;
                    });
                  }).onError((error, stackTrace) {
                    toastUtil().showToast('Some error occured!');
                  });
                })
          ],
        ),
      ),
    );
  }
}
