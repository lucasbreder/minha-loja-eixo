class Prize {
  int id;
  String name;
  String? description;

  Prize({required this.id, required this.name, this.description});

  @override
  String toString() {
    return name;
  }

  factory Prize.fromJson(Map<String, dynamic> json) {
    return Prize(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
