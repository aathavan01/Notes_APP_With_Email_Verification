import 'package:crud1/HomePage.dart';
import 'package:crud1/auth_page.dart';
import 'package:crud1/utils.dart';
import 'package:crud1/verifyEmailPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login_widget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    // scaffoldMessengerKey: Utils.messengerKey,
        // navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      );
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return VerifyEmailPage();
          } else
            return AuthPage();
        }),
      ),
    );
  }
}
