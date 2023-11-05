class Store {
  int id;
  String name;
  String? brand;

  Store({required this.id, required this.name, this.brand});

  @override
  String toString() {
    return name;
  }

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
    );
  }
}
