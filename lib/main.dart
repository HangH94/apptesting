
import 'package:exampleapp/firebase_options.dart';
import 'package:exampleapp/views/login_view.dart';
import 'package:exampleapp/views/register_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    )
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
    Widget build(BuildContext context) {
      
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 241, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 17, 146, 179),
          title : const Text('Home'),
        ),
        body : 
          FutureBuilder(
            future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  ),
            builder : (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    final user = FirebaseAuth.instance.currentUser;
                    if (user?.emailVerified ?? false) {
                      print("User is verified");
                    }
                    else {
                      print("User is not verified");
                    }
                      return Text("Done");
                  default:
                      return const Text("Loading... Please wait");
                }
            },
          ),
      );
    }
}



