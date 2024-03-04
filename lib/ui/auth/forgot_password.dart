import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_master/utils/utils.dart';
import 'package:firebase_master/widgets/round_button.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Forgor Password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: "Email"),
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                  title: "Forgot",
                  onTap: () {
                    auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      Utils().toastmsg(
                          "We have sent you email to recover password, please check email");
                    }).onError((error, stackTrace) {
                      Utils().toastmsg(error.toString());
                    });
                  })
            ]),
      ),
    );
  }
}
