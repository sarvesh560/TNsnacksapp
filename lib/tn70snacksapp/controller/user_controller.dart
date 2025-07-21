import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_values.dart';
import '../model/user_model.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Observable user model
  Rxn<UserModel> user = Rxn<UserModel>();

  @override
  void onInit() {
    super.onInit();
    fetchUser(); // Automatically fetch on controller init
  }

  // 🔄 Fetch user from Firestore
  Future<void> fetchUser() async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        final doc = await _firestore.collection('users').doc(uid).get();
        if (doc.exists) {
          user.value = UserModel.fromMap(doc.data()!);
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch user: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(AppValues.paddingSmall),
        duration: const Duration(seconds: 2),
      );
    }
  }

  // 🔄 Update user in Firestore
  Future<void> updateUser({
    required String name,
    required String phone,
    required String address,
  }) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore.collection('users').doc(uid).update({
          'name': name,
          'phone': phone,
          'address': address,
        });
        fetchUser(); // Refresh locally after update
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update user: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(AppValues.paddingSmall),
        duration: const Duration(seconds: 2),
      );
    }
  }

  // 📷 Upload profile image and update Firestore
  Future<void> uploadProfileImage() async {
    // You can integrate image_picker and Firebase Storage here
    // For now, we'll assume a dummy image URL
    final dummyImageUrl = 'https://example.com/profile.png';
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      await _firestore.collection('users').doc(uid).update({
        'profileImage': dummyImageUrl,
      });
      fetchUser(); // Refresh after upload
    }
  }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

}
