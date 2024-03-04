import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_master/utils/utils.dart';
import 'package:firebase_master/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? _image;
  final picker = ImagePicker();
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Post');
  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Upload Image",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Colors.black,
                    )),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Center(child: Icon(Icons.image)),
                  ),
                ),
              ),
              SizedBox(
                height: 39,
              ),
              RoundButton(
                  title: 'Upload',
                  onTap: () async {
                    firebase_storage.Reference ref = firebase_storage
                        .FirebaseStorage.instance
                        .ref('/foldername/' +
                            DateTime.now().microsecondsSinceEpoch.toString());
                    firebase_storage.UploadTask uploadTask =
                        ref.putFile(_image!.absolute);

                    Future.value(uploadTask).then((value) async {
                      var newUrl = await ref.getDownloadURL();
                      databaseRef
                          .child('1')
                          .set({'id': '1212', 'title': newUrl.toString()});
                      Utils().toastmsg("sucessfully");
                    }).onError((error, stackTrace) {
                      Utils().toastmsg(error.toString());
                    });
                  })
            ]),
      ),
    );
  }
}
