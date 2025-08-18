
import 'package:exampleapp/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
      
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 241, 245),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 17, 146, 179),
          title : const Text('Login'),
        ),
        body : 
          FutureBuilder(
            future: Firebase.initializeApp(
                    options: DefaultFirebaseOptions.currentPlatform,
                  ),
            builder : (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                      return Column(
                        children: [
                          TextField(
                              controller : _email,
                              enableSuggestions: false,
                              autocorrect: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Enter your email",
                              ),
                      
                            ),
                          TextField(
                            controller: _password,
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: const InputDecoration(
                                hintText: "Enter your password"
                              ),
                            ),
                          TextButton(
                            onPressed: () async {
                              final email = _email.text.trim();
                              final password = _password.text.trim();
                              // Attempt to log in the user   

                              try {
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                                  email: email, 
                                  password: password);
                                // If successful, you can navigate to another screen or show a success message
                              } on FirebaseAuthException catch (e) {
                                // Handle login errors
                                if (e.code == 'user-not-found') {
                                  print('No user found for that email.');
                                } else if (e.code == 'wrong-password') {
                                  print('Wrong password provided for that user.');
                                } else {
                                  print('Login failed: ${e.message}');
                                  print(e.code);
                                }
                              }

                            }, child : const Text('Login'),
                          ),
                        ],
                      );
                  default:
                      return const Text("Loading... Please wait");
                }
            },
          ),
      );
    }
}