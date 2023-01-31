import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class StoredUserData {
  Future<String> getUsername() async {
    String userName = '';
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    userName = (snap.data() as Map<String, dynamic>)['username'];
    return userName;
  }
}
