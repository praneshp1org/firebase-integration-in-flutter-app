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
  final _searchFilter = TextEditingController();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _searchFilter,
                onChanged: (String? value) {
                  // setState(() {});
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: 'Search..',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(
              //needs to be wrapped with expanded widget
              child: FirebaseAnimatedList(
                  defaultChild: Center(
                    child: CircularProgressIndicator(),
                  ),
                  query: ref,
                  itemBuilder: ((context, snapshot, animation, index) {
                    final title = snapshot.child('title').value.toString();
                    if (_searchFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(
                          snapshot.child('title').value.toString(),
                          // style: TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: (() {
                                          Navigator.pop(context);
                                          _showMyDialog(
                                              title,
                                              snapshot
                                                  .child('id')
                                                  .value
                                                  .toString());
                                        }),
                                        leading: Icon(Icons.edit),
                                        title: Text('Edit'),
                                      )),
                                  PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: () {
                                          Navigator.pop(context);
                                          ref
                                              .child(snapshot
                                                  .child('id')
                                                  .value
                                                  .toString())
                                              .remove()
                                              .then((value) {
                                            toastUtil().showToast(
                                                'Successfully deleted!');
                                          }).onError((error, stackTrace) {
                                            toastUtil()
                                                .showToast('Error Occured!');
                                          });
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text('Delete'),
                                      )),
                                ]),
                      );
                    } else if (title
                        .toLowerCase()
                        .contains(_searchFilter.text.toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      );
                    } else {
                      return Container();
                    }
                  })),
            ),
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
                ref.child(id).update({'title': _editFilter.text}).then((value) {
                  toastUtil().showToast('Successfully updated!');
                }).onError((error, stackTrace) {
                  toastUtil().showToast('Error occured!');
                });
              },
            ),
          ],
        );
      },
    );
  }
}
