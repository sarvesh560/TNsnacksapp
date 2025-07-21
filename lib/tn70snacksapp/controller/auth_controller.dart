import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_values.dart';
import '../model/user_model.dart';
import 'user_controller.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxBool isremember = false.obs;
  RxBool isGuest = false.obs; //  Added for Guest Mode
  bool get isGuestUser => isGuest.value;
  bool get isLoggedIn => FirebaseAuth.instance.currentUser != null;



  // ✅ Check whether user is logged in (guest or authenticated)
  bool get isAuthenticated =>
      _auth.currentUser != null || isGuest.value;

  // ✅ Guest Login
  void loginAsGuest() {
    isGuest.value = true;
    Get.offAllNamed('/home');
  }

  // Email/Password Login
  Future<void> login(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = result.user?.uid;

      // Ensure Firestore doc exists
      final userDoc = await _firestore.collection('users').doc(uid).get();
      if (!userDoc.exists) {
        await _firestore.collection('users').doc(uid).set({
          'email': email,
          'name': '',
          'phone': '',
          'address': '',
          'profileImage': null,
        });
      }

      // Fetch user to controller
      final userController = Get.put(UserController());
      await userController.fetchUser();

      isGuest.value = false; // just to be safe
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Login Failed", e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(AppValues.paddingSmall),
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Signup
  Future<void> signup(String name, String email, String password) async {
    try {
      final userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final uid = userCred.user!.uid;

      final userModel = UserModel(
        uid: uid,
        email: email,
        name: name,
        phone: '',
        address: '',
        profileImage: null,
      );

      await _firestore.collection('users').doc(uid).set(userModel.toMap());

      final userController = Get.put(UserController());
      userController.user.value = userModel;

      isGuest.value = false;
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Signup Failed", e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(AppValues.paddingSmall),
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Logout
  Future<void> logout() async {
    isGuest.value = false;
    await _auth.signOut();
    Get.offAllNamed('/login');
  }
}
