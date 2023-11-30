import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoblock_mobile_app/src/features/authentication/presentation/screens/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        ),
        child: Center(
          child: Text("Register"),
        ),
      ),
    );
  }
}
