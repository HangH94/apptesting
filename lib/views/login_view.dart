
import 'package:firebase_auth/firebase_auth.dart';
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
      // LoginView에 Scaffold를 추가하여 SnackBar를 사용할 수 있게 합니다.
      appBar: AppBar(title: const Text('Login')),
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
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                // 로그인 성공 시 메시지
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('로그인에 성공했습니다!')),
                );
              } on FirebaseAuthException catch (e) {
                String errorMessage;
                if (e.code == 'user-not-found') {
                  errorMessage = '해당 이메일의 사용자를 찾을 수 없습니다.';
                } else if (e.code == 'wrong-password') {
                  errorMessage = '비밀번호가 틀렸습니다.';
                } else if (e.code == 'invalid-email') {
                  errorMessage = '이메일 주소 형식이 올바르지 않습니다.';
                } else {
                  errorMessage = '로그인에 실패했습니다: ${e.message}';
                }

                print(errorMessage);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(errorMessage)),
                );
              }
            },
            child: const Text('Login'),
          ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/register',
                (route) => false,
              );
            },
            child: const Text('Not registered yet? Register here!'),
          ),
        ],
      ),
    );
  }
}
