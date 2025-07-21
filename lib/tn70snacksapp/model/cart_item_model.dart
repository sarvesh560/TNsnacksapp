import 'package:get/get_rx/src/rx_types/rx_types.dart';

class cartModel {
  final String id;
  final String Snackname;
  final String Image;
  final double Price;
  RxInt Quantity;

  cartModel({
    required this.id,
    required this.Snackname,
    required this.Image,
    required this.Price,
    int quantity = 1,
  }) : Quantity = quantity.obs;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is cartModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
