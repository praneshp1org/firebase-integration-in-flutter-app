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

bool _loading = false;
final _databaseRef = FirebaseDatabase.instance.ref('Test'); //ref of table
//post wala table ma sabai save hunxa
final _postController = TextEditingController();

class _AddFirestoreDataScreenState extends State<AddFirestoreDataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Post'),
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

                  ///
                  _databaseRef.child(id).set({
                    'title': _postController.text.toString(),
                    'id': id,
                  }).then((value) {
                    setState(() {
                      _loading = false;
                    });
                    toastUtil().showToast('Post added!');
                  }).onError((error, stackTrace) {
                    toastUtil().showToast(error.toString());
                    _loading = false;
                  });
                })
          ],
        ),
      ),
    );
  }
}
