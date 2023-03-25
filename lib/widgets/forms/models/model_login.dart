class Login {
  final String token;
  final int role;
  final String storeBrand;

  const Login({
    required this.token,
    required this.role,
    required this.storeBrand,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      token: json['auth']['token'],
      role: json['role'],
      storeBrand: json['store_brand'],
    );
  }
}
