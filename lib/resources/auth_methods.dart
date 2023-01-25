import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUserWithEmail({
    required String email,
    required String password,
    required String reEnterPassword,
    required String nickName,
  }) async {
    String signUpStatus = 'sign up failed';
    bool isPasswordMismatched =
        _isPasswordMismatched(password, reEnterPassword);
    try {
      if (email.isNotEmpty || password.isNotEmpty || nickName.isNotEmpty) {
        //Create new user with email and password.
        if (!isPasswordMismatched) {
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(email: email, password: password);
          // Store new user's data.
          await _firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'username': nickName,
            'uid': userCredential.user!.uid,
            'email': email,
          });
        } else {
          throw ('Password mismatch');
        }
      } else {
        throw ("Please Fill out all feilds");
      }
    } catch (signupError) {
      if (isPasswordMismatched) {
        signUpStatus = "Passwords do not match";
        print(signUpStatus);
        return signUpStatus;
      }
      signUpStatus = signupError.toString();
      print(signUpStatus);
      return signUpStatus;
    }
    signUpStatus = "Signup success!";
    print(signUpStatus);
    return signUpStatus;
  }

  Future<String> loginUser({
    required email,
    required password,
  }) async {
    String loginStatus = 'Login failed';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        loginStatus = 'Login Successful!';
      } else {
        throw ('enter both email and password');
      }
    } catch (error) {
      loginStatus = error.toString();
    }
    return loginStatus;
  }

  Future<void> logOutUser() async {
    String logOutStatus = "Failed to log out";
    await FirebaseAuth.instance.signOut();
    print("user logged Out");
  }

  bool _isPasswordMismatched(password, reEnterPassword) {
    if (password != reEnterPassword) {
      return true;
    }
    return false;
  }
}
