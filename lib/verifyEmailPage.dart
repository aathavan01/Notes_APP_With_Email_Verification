import 'dart:async';

import 'package:crud1/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? HomePage()
      : Scaffold(
          appBar: AppBar(
            title: Text("Verify Email"),
            leading: IconButton(onPressed: (){Navigator.of(context).pop;}, icon: Icon(Icons.arrow_back_ios))
          ),
          body: Padding(padding: EdgeInsets.all(16)
          ,child: Column(
            children: [
              Text("A verfication email has been sent to your email",
              style: TextStyle(
                fontSize: 20
              ),
              textAlign: TextAlign.center,),
              SizedBox(height: 24,),
              ElevatedButton.icon(onPressed: sendVerificationEmail, icon: Icon(Icons.email), label: Text("Resent Email",style: TextStyle(fontSize: 24)),)
            ],
          ),),
        );
}
