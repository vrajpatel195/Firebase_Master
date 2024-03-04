import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_master/ui/auth/verify_code.dart';
import 'package:firebase_master/utils/utils.dart';
import 'package:firebase_master/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final phonenumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          "Login",
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
              controller: phonenumberController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "+1 236 235 256"),
            ),
            SizedBox(
              height: 80,
            ),
            RoundButton(
                title: "Login",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });

                  auth.verifyPhoneNumber(
                    phoneNumber: phonenumberController.text,
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      Utils().toastmsg(e.toString());
                    },
                    codeSent: (String verificationId, int? token) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyCodeScreen(
                                    verificationId: verificationId,
                                  )));
                      setState(() {
                        loading = false;
                      });
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().toastmsg(e.toString());
                      setState(() {
                        loading = false;
                      });
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
