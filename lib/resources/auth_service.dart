import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get authStateChangeStream => firebaseAuth.authStateChanges();
  User get currentUser => firebaseAuth.currentUser!;


  Future<bool> signInWithGoogle(BuildContext context) async {
    bool result = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential = await firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if(user!=null){
        if(userCredential.additionalUserInfo!.isNewUser){
          await firestore.collection("users").doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            "profilePhoto":user.photoURL
          });
        }
        result = true;
      }
    }on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      showSnackBar(context, e.message.toString());
    }
      return result;
  }
}
