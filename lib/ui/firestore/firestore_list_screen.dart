import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_master/firebase%20services/add_firestore_data.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../auth/login_screen.dart';
import '../posts/add_posts.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  final _auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Firestore",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: () {
                _auth
                    .signOut()
                    .then((value) => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen())))
                    .onError((error, stackTrace) =>
                        Utils().toastmsg(error.toString()));
              },
              icon: Icon(Icons.logout_outlined)),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
              stream: fireStore,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return Text("Some Error");
                }
                return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                                snapshot.data!.docs[index]['title'].toString()),
                            subtitle: Text(
                                snapshot.data!.docs[index]['id'].toString()),
                            trailing: PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showMyDialog(
                                          snapshot.data!.docs[index]['title']
                                              .toString(),
                                          snapshot.data!.docs[index].id
                                              .toString());
                                    },
                                    leading: Icon(Icons.edit),
                                    title: Text("Edit"),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      ref
                                          .doc(snapshot.data!.docs[index].id
                                              .toString())
                                          .delete();
                                    },
                                    leading: Icon(Icons.delete_outline),
                                    title: Text("Delete"),
                                  ),
                                )
                              ],
                            ),
                          );
                        }));
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFirestoreScreen()));
        },
        child: Icon(
          Icons.add,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Update"),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(hintText: "Edit"),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref
                        .doc(id)
                        .update({'title': editController.text.toString()}).then(
                            (value) {
                      Utils().toastmsg("Post Update");
                    }).onError((error, stackTrace) {
                      Utils().toastmsg(error.toString());
                    });
                  },
                  child: Text("Update"))
            ],
          );
        });
  }
}
