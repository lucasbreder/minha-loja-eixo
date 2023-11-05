class Deal {
  final int id;
  final String createdAt;
  final Map<String, dynamic> customer;
  final String? description;
  final double? value;
  final bool isConfirmed;
  final Map<String, dynamic>? store;

  Deal({
    required this.id,
    required this.createdAt,
    required this.customer,
    required this.isConfirmed,
    this.description,
    this.store,
    this.value,
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'],
      createdAt: json['created_at'],
      description: json['description'],
      value: json['value'],
      customer: json['customer'],
      isConfirmed: json['is_confirmed'],
      store: json['store'] ?? '',
    );
  }
}
