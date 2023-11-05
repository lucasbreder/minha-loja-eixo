import 'package:intl/intl.dart';

class User {
  int id;
  String firstName;
  String lastName;
  String cpf;
  String? avatarUrl;
  String? profession;
  double? balance;
  String? address;
  String? postalCode;
  String? instagramUser;
  String? facebookUser;
  String? linkedInUser;
  String? phone;
  String? birthDate;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.cpf,
    this.balance,
    this.profession,
    this.avatarUrl,
    this.address,
    this.postalCode,
    this.instagramUser,
    this.facebookUser,
    this.linkedInUser,
    this.phone,
    this.birthDate,
  });

  @override
  String toString() {
    return '$firstName $lastName';
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final DateFormat formatterDate = DateFormat('dd/MM/yyyy');

    final birthDate = json['profile']['birth_date'] != null
        ? DateTime.parse(json['profile']['birth_date'])
        : null;

    final user = User(
      id: json['id'],
      firstName: json['profile']['first_name'],
      lastName: json['profile']['last_name'],
      cpf: json['profile']['cpf'],
      avatarUrl: json['profile']['avatar_url'],
      profession: json['profile']['profession'],
      balance: json['account'] != null ? json['account']['balance'] : null,
      address: json['profile']['address'] != null
          ? '${json['profile']['address']['street'] ?? ''} ${json['profile']['address']['complement'] ?? ''} ${json['profile']['address']['district'] ?? ''} ${json['profile']['address']['city'] ?? ''} ${json['profile']['address']['state'] ?? ''} ${json['profile']['address']['country'] ?? ''}'
          : '',
      instagramUser: json['profile']['instagram_user'] ?? '',
      facebookUser: json['profile']['facebook_user'] ?? '',
      linkedInUser: json['profile']['linkedin_user'] ?? '',
      phone: json['profile']['phone'] ?? '',
      birthDate: birthDate != null ? formatterDate.format(birthDate) : '',
      postalCode: json['profile']['address'] != null
          ? json['profile']['address']['postal_code']
          : '',
    );
    return user;
  }
}
