import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_master/utils/utils.dart';
import 'package:firebase_master/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddFirestoreScreen extends StatefulWidget {
  const AddFirestoreScreen({super.key});

  @override
  State<AddFirestoreScreen> createState() => _AddFirestoreScreenState();
}

class _AddFirestoreScreenState extends State<AddFirestoreScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final fireStore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Add Firestore data",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                  hintText: "What is in your mind ?",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            RoundButton(
                title: "Add",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc().set({
                    'title': postController.text.toString(),
                    'id': id
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastmsg("Stored");
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastmsg(error.toString());
                  });
                })
          ],
        ),
      ),
    );
  }
}
