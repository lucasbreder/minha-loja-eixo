class Redeem {
  int id;
  int score;
  bool active;
  Map<String, dynamic> user;
  Map<String, dynamic> prize;
  String createdAt;
  String refundUntil;

  Redeem({
    required this.id,
    required this.score,
    required this.active,
    required this.user,
    required this.prize,
    required this.createdAt,
    required this.refundUntil,
  });

  factory Redeem.fromJson(Map<String, dynamic> json) {
    final redeem = Redeem(
      id: json['id'],
      score: json['score'],
      active: json['active'],
      user: json['user'],
      prize: json['prize'],
      createdAt: json['created_at'],
      refundUntil: json['refund_until'],
    );
    return redeem;
  }
}
