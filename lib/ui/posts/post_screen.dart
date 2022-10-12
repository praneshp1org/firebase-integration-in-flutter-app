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

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final _auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Test');

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
            Get.to(() => AddPostScreen());
          },
          child: Icon(Icons.add),
        ),
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
        body: Column(
          children: [
            // Expanded(
            //   child: StreamBuilder(
            //     stream: ref.onValue,
            //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //       if (!snapshot.hasData) {
            //         return CircularProgressIndicator();
            //       } else {
            //         Map<dynamic, dynamic> map =
            //             snapshot.data!.snapshot.value as dynamic;
            //         List<dynamic> list = [];
            //         list.clear();
            //         list = map.values.toList();
            //         return ListView.builder(
            //             itemCount: snapshot.data!.snapshot.children.length,
            //             itemBuilder: (context, index) {
            //               return ListTile(
            //                 title: Text(list[index]['title']),
            //               );
            //             });
            //       }
            //     },
            //   ),
            // ),
            Expanded(
              //needs to be wrapped with expanded widget
              child: FirebaseAnimatedList(
                  defaultChild: Center(
                    child: CircularProgressIndicator(),
                  ),
                  query: ref,
                  itemBuilder: ((context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }
}
