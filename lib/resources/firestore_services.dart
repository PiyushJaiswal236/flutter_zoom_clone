import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirestoreServices {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingHistory => _firebaseFirestore.collection("users")
      .doc(_auth.currentUser!.uid)
      .collection("meeting").snapshots();

  void addToMeetingHistory(String meetingName)async {
    try {
      await _firebaseFirestore
              .collection("users")
              .doc(_auth.currentUser!.uid)
              .collection("meeting")
              .add({
            'meetingName': meetingName,
            'createdAt': DateTime.now(),
          });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
