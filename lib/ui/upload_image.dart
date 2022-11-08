import 'dart:io';

import 'package:firebase_crud/utils/utils.dart';
import 'package:firebase_crud/widgets/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  bool _loading = false;

  final picker = ImagePicker();
  final databaseRef =
      FirebaseDatabase.instance.ref('Users'); //database reference
  firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future getGalleryImage() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No file picked!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getGalleryImage();
              },
              child: Container(
                height: 200,
                width: 200,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: (_image != null)
                    ? Image.file(_image!.absolute)
                    : Center(
                        child: Icon(
                          Icons.image,
                          size: 30,
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          RoundButton(
              title: 'Upload Image',
              loading: _loading,
              onTap: () async {
                setState(() {
                  _loading = true;
                });
                firebase_storage.Reference ref = firebase_storage
                    .FirebaseStorage.instance
                    .ref('/foldername' + '1224');
                firebase_storage.UploadTask uploadTask =
                    ref.putFile(_image!.absolute);

                Future.value(uploadTask).then((value) {
                  var newUrl = ref.getDownloadURL();

                  databaseRef.child('1').set(
                      {'id': '1212', 'title': newUrl.toString()}).then((value) {
                    setState(() {
                      _loading = false;
                    });
                  }).onError((error, stackTrace) {
                    setState(() {
                      _loading = false;
                    });
                  });

                  toastUtil().showToast('Photo Uploaded!');
                });
              })
        ],
      ),
    );
  }
}
