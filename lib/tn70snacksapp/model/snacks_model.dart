class snacksModel {
  final String id;
  final String Image;
  final String Snackname;
  final num Price;
  final String Quantity;

  snacksModel({
    required this.id,
    required this.Image,
    required this.Snackname,
    required this.Price,
    required this.Quantity,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'Image': Image,
    'Snackname': Snackname,
    'Price': Price,
    'Quantity': Quantity,
  };

  factory snacksModel.fromMap(Map<String, dynamic> map) => snacksModel(
    id: map['id'] ?? '',
    Image: map['Image'] ?? '',
    Snackname: map['Snackname'] ?? '',
    Price: map['Price'] ?? 0,
    Quantity: map['Quantity'] ?? '',
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is snacksModel && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
