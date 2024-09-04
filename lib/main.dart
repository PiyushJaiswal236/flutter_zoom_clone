import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zoom_clone/pages/home_page.dart';
import 'package:zoom_clone/pages/join_call_page.dart';
import 'package:zoom_clone/pages/login_page.dart';
import 'package:zoom_clone/resources/auth_service.dart';
import 'package:zoom_clone/resources/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyC1k6sJIfAE0uevTEialaldbyVhTK03FZQ',
          appId: '1:389847290457:android:d906da1042dc403abdd748',
          messagingSenderId: '389847290457',
          projectId: 'zoom-clone-c781c'));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: backgroundColor),
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        LoginPage.routeName: (context) => const LoginPage(),
        JoinCallPage.routeName:(context)=>const JoinCallPage(),
      },
      home: StreamBuilder(
        stream: AuthService().authStateChangeStream,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          if(snapshot.hasData){
            return const HomePage();
          }
          return const LoginPage();
        },
      ),
    );
  }
}
