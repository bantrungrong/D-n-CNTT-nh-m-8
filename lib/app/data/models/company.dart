class Shop {
  int id;
  String name;
  String location;
  String loan;
  int phoneShop;

  Shop({required this.id, required this.name, required this.location, required this.loan, required this.phoneShop});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'loan': loan,
      'phoneShop': phoneShop,
    };
  }

  // Phương thức để chuyển đổi một Map thành một đối tượng Shop
  factory Shop.fromMap(Map<String, dynamic> map) {
    return Shop(
      id: map['id'],
      name: map['name'],
      location: map['location'],
      loan: map['loan'],
      phoneShop: map['phoneShop'],
    );
  }
}
