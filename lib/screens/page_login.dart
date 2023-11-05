import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minha_loja_eixo/components/forms/data/data_form_login.dart';
import 'package:minha_loja_eixo/components/forms/views/base_form.dart';
import 'package:minha_loja_eixo/components/scaffold/views/login_scaffold.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({super.key});

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  void checkToken(context) async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    if (token != null && token.isNotEmpty) {
      Navigator.pushNamed(context, 'cadastrar-venda');
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      checkToken(context);
    });

    return LoginScaffold(
      showNav: false,
      children: [
        SvgPicture.asset(
          'assets/images/eixo_brand.svg',
          semanticsLabel: 'Eixo',
          width: 200,
        ),
        const SizedBox(
          height: 50,
        ),
        BaseForm(
          formInputs: loginInputs,
          apiRoute: 'https://api.eixo.site/loginMyStore/',
          redirectRoute: 'dashboard',
          successMessage: 'Você logou!',
          isLogin: true,
          formTheme: 'light',
        ),
      ],
    );
  }
}
