import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geteat/models/user_model.dart';

class UserConnection {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Stream<UserModel> get userStream {
    return _auth
        .authStateChanges()
        .asyncMap((user) => UserModel(user?.email, '', user?.uid));
  }

  Future<bool> get ifUserConnected async {
    //
    return false;
  }

  Future<UserModel> get UserConnected async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel(user?.email, '', '', user?.uid);
    return userModel;
  }

  Future<UserModel> authentification(phone, password) async {
    try {
      UserCredential _userCredential;

      //get first the email associated with the phone nuber
      //get the user phone reference
      DocumentReference profilePhoneRef =
          fireStore.collection('phonemail').doc(phone);
      //get user data
      DocumentSnapshot phoneData = (await profilePhoneRef.get());
      //get the email address from the server
      String email = phoneData.get("email");
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      String userId = "";
      userId = _userCredential.user?.uid ?? '';

      UserModel _user = UserModel(email, password, userId);
      return _user;
    } catch (e) {
      //return a empty user
      print("error");
      return UserModel('', '', '', '');
    }
  }

  void pocessPhone(phone, Function(UserModel) CodeCallBack,
      Function(PhoneAuthCredential, UserModel) CredentialCallback) async {
    UserModel user = UserModel('', phone, '');

    ///_auth.setSettings(appVerificationDisabledForTesting: false);
    
    await _auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        CredentialCallback(credential, user);
      },
      codeSent: (String verificationId, int? resendToken) async {
        user.checkId = verificationId;
        CodeCallBack(user);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }

        // Handle other errors
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
    
  }

  Future<UserModel> createAccount(
      email, password, PhoneAuthCredential phoneCredential) async {
    try {
      UserCredential phoneUserCredential =
          await _auth.signInWithCredential(phoneCredential);
      //UserCredential userCredential;
      AuthCredential emailCredential =
          EmailAuthProvider.credential(email: email, password: password);
      //userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      await phoneUserCredential.user!.linkWithCredential(emailCredential);

      String userId = "";
      userId = phoneUserCredential.user?.uid ?? '';

      UserModel _user = UserModel(
          email, phoneUserCredential.user?.phoneNumber ?? '', password, userId);
      return _user;
    } catch (e) {
      return UserModel('', '', '');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
  }

  Future<bool> isEmailExists(String email) async {
    var methods = await _auth.fetchSignInMethodsForEmail(email);
    return methods.contains('password');
  }

  Future<bool> isPhoneExists(String phone) async {
    DocumentReference postRef = fireStore.collection('phonemail').doc(phone);
    //get user data
    try {
      DocumentSnapshot postSnapshot = (await postRef.get());
      return postSnapshot.exists;
    } catch (e) {
      return false;
    }
  }
}
