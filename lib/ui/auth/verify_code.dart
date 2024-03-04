import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_master/ui/posts/post_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../../widgets/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Verify",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "6 digits code"),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "Verify",
                loading: loading,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationCodeController.text.toString());
                  try {
                    await auth.signInWithCredential(credential);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostScreen()));
                  } catch (e) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastmsg(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
