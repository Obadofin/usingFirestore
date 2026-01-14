/*
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/usingFirestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
*/
import 'package:flutter/material.dart';
import 'package:my_firebase/usingFIrestore.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Demo',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: UsingFirestore(),
    );
  }
}
