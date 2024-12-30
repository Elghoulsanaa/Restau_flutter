import 'package:firebase_auth/firebase_auth.dart'
    as firebase_auth; // Prefix this import
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:restaubook/pages/WelcomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Import the generated Firebase options

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Use the EmailAuthProvider from firebase_ui_auth
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(), // This one is from firebase_ui_auth
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
          const Welcomepage(), // Ensure WelcomePage is defined and correctly imported
    );
  }
}
