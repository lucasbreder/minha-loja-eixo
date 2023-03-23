import 'package:flutter/material.dart';
import 'package:minha_loja_eixo/widgets/nav/views/view_nav.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailProfileSocial extends StatelessWidget {
  const DetailProfileSocial(
      {required this.title, this.user, this.showSeparator = true, super.key});

  final String title;
  final String? user;
  final bool showSeparator;

  @override
  Widget build(BuildContext context) {
    if (user != null && user!.isNotEmpty) {
      String socialLink = '';

      switch (title) {
        case 'Instagram':
          socialLink = 'https://www.instagram.com/${user!}';
          break;
        case 'Facebook':
          socialLink = 'https://www.facebook.com/${user!}';
          break;
        case 'LinkedIn':
          socialLink = 'https://www.linkedin.com/in/${user!}';
          break;
        default:
      }

      final url = Uri.parse(socialLink);

      return Row(
        children: [
          GestureDetector(
            onTap: () => launchUrl(url),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 14.0,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          showSeparator ? const NavSeparator() : const SizedBox()
        ],
      );
    }
    return const SizedBox();
  }
}
