class Login {
  final String token;
  final int role;

  const Login({
    required this.token,
    required this.role,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(token: json['auth']['token'], role: json['role']);
  }
}
