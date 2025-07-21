class UserModel {
  String uid;
  String name;
  String email;
  String? phone;
  String? address;
  String? profileImage;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      profileImage: map['profileImage'],
    );
  }
}
