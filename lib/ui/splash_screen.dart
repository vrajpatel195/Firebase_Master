import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_master/ui/posts/post_screen.dart';
import 'package:firebase_master/ui/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth/login_screen.dart';
import 'firestore/firestore_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          statusBarColor: Colors.white));
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => PostScreen()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(
        "Firebase Master Class",
        style: TextStyle(fontSize: 30),
      ),
    ));
  }
}
