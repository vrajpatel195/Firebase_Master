import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_master/utils/utils.dart';
import 'package:firebase_master/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Add Post",
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
                  databaseRef.child(id).set({
                    'title': postController.text.toString(),
                    'id': id,
                  }).then((value) {
                    Utils().toastmsg("Post Added");
                    setState(() {
                      loading = false;
                    });
                  }).onError((error, stackTrace) {
                    Utils().toastmsg(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
