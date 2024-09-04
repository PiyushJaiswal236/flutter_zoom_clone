import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/pages/home_page.dart';
import 'package:zoom_clone/resources/auth_service.dart';
import 'package:zoom_clone/widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static String routeName = "/loginpage";

  @override
  State<StatefulWidget> createState() => _loginPageState();
}

class _loginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Start Or Join A Meeting",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 38.0),
            child: Image.asset("assets/images/onBoarding.png"),
          ),
          CustomButton(
            text: "Login",
            onPressed: () async {
              bool result = await _authService.signInWithGoogle(context);
              if(result){
                if (kDebugMode) {
                  print('Result is True');
                }
                Navigator.pushNamed(context, HomePage.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
