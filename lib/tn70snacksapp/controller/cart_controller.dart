import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/app_values.dart';
import '../model/snacks_model.dart';
import 'auth_controller.dart';

class CartController extends GetxController {
  var cartList = <snacksModel>[].obs;
  var totalAmount = 0.0.obs;
  var orders = [].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _uid;
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
    fetchCartItems();
    fetchOrders();
  }

  int get count => cartList.length;

  void toggleCart(snacksModel snack) {
    if (isAdded(snack)) {
      removeFromCart(snack);
    } else {
      addToCart(snack);
    }

  }

  bool isAdded(snacksModel snack) {
    return cartList.any((item) => item.id == snack.id);
  }

  Future<void> addToCart(snacksModel snack) async {
    if (authController.isGuestUser) {
      Get.snackbar("Guest Mode", "Please login to add items to cart",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin:  EdgeInsets.all(AppValues.paddingSmall),
        duration: const Duration(seconds: 2),
      );
      return;
    }

    cartList.add(snack);
    calculateTotal();

    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .doc(snack.id)
        .set(snack.toMap());
  }

  Future<void> removeFromCart(snacksModel snack) async {
    if (authController.isGuestUser) return;

    cartList.removeWhere((item) => item.id == snack.id);
    calculateTotal();

    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .doc(snack.id)
        .delete();
  }

  void calculateTotal() {
    totalAmount.value = cartList.fold(
      0.0,
          (sum, item) => sum + (item.Price is num ? item.Price.toDouble() : 0),
    );
  }

  Future<void> fetchCartItems() async {
    if (authController.isGuestUser) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .get();

    cartList.value =
        snapshot.docs.map((doc) => snacksModel.fromMap(doc.data())).toList();
    calculateTotal();
  }

  Future<void> placeOrder() async {
    if (authController.isGuestUser || cartList.isEmpty) {
      Get.snackbar("Guest Mode", "Login to place an order",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin:  EdgeInsets.all(AppValues.paddingSmall),
        duration: const Duration(seconds: 2),
      );
      return;
    }

    final orderId = 'ORD${DateTime.now().millisecondsSinceEpoch}';
    final orderData = {
      'id': orderId,
      'items': cartList.map((item) => item.toMap()).toList(),
      'total': totalAmount.value,
      'date': DateTime.now().toIso8601String(),
      'status': 'Pending',
    };

    await _firestore
        .collection('users')
        .doc(_uid)
        .collection('orders')
        .doc(orderId)
        .set(orderData);

    orders.add(orderData);
    cartList.clear();
    totalAmount.value = 0.0;

    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('cart')
        .get();

    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> fetchOrders() async {
    if (authController.isGuestUser) return;

    final snapshot = await _firestore
        .collection('users')
        .doc(_uid)
        .collection('orders')
        .orderBy('date', descending: true)
        .get();

    orders.value = snapshot.docs.map((doc) => doc.data()).toList();
  }
}
