import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/app_values.dart';
import '../model/snacks_model.dart';
import 'auth_controller.dart';

class FavouriteController extends GetxController {
  RxList<snacksModel> favouriteList = <snacksModel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late final String _uid;
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();

    if (authController.isGuestUser) {
      _uid = 'guest';
      return;
    }

    final user = FirebaseAuth.instance.currentUser;
    _uid = user!.uid;
    fetchFavourites();
  }

  bool isFavourite(snacksModel snack) {
    return favouriteList.any((item) => item.id == snack.id);
  }

  void toggleFavourite(snacksModel snack) {
    if (isFavourite(snack)) {
      removeFromFavourite(snack);
    } else {
      addToFavourite(snack);
    }
  }

  Future<void> addToFavourite(snacksModel snack) async {
    if (authController.isGuestUser) {
      Get.snackbar("Guest Mode", "Please login to add to favourites",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin:  EdgeInsets.all(AppValues.paddingSmall),
        duration: const Duration(seconds: 2),);
      return;
    }

    favouriteList.add(snack);
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favourites')
        .doc(snack.id)
        .set(snack.toMap());
  }

  Future<void> removeFromFavourite(snacksModel snack) async {
    if (authController.isGuestUser) return;

    favouriteList.removeWhere((item) => item.id == snack.id);
    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favourites')
        .doc(snack.id)
        .delete();
  }

  Future<void> fetchFavourites() async {
    if (authController.isGuestUser) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('favourites')
        .get();

    favouriteList.value =
        snapshot.docs.map((doc) => snacksModel.fromMap(doc.data())).toList();
  }
}
