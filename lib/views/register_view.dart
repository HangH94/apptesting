
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

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
        appBar: AppBar(title: const Text('Register')),
        body: Column(
          children: [
            TextField(
              controller: _email,
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
                hintText: "Enter your password",
              ),
            ),
            // 아래 TextButton을 이 코드로 교체하세요.
            TextButton(
              onPressed: () async {
                final email = _email.text.trim();
                final password = _password.text.trim();
        
                try {
                  // 회원가입 로직을 한 번만 실행합니다.
                  final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: email, 
                    password: password);
                  print(userCredential);
                } on FirebaseAuthException catch (e) {
                  // 예외 처리 로직은 그대로 둡니다.
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  } else if (e.code == 'invalid-email') {
                    print('The email address is not valid.');
                  } else {
                    print('Registration failed: ${e.message}');
                  }
                }
              },
              child: const Text('Register Now!'),
            ),

            TextButton(onPressed: () {Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (route) => false,
              );}, child: const Text("Already have an account? Login"))  
          ],
        ),
      );
    }
}