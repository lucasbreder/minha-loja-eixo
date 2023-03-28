import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/pages/page_create_deals.dart';
import 'package:minha_loja_eixo/pages/page_dashboard.dart';
import 'package:minha_loja_eixo/pages/page_login.dart';
import 'package:minha_loja_eixo/pages/page_reedems.dart';
import 'package:minha_loja_eixo/pages/page_deals.dart';
import 'package:minha_loja_eixo/pages/page_users.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      () async {
        Future.delayed(Duration.zero, () async {
          String? token = await storage.read(key: 'token');
          if (token == null) {
            Navigator.pushNamed(context, '/');
          }
        });
      };
    });

    return GetMaterialApp(
      title: 'Minha Loja Eixo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Bahnschrift',
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            fillColor: Color.fromARGB(255, 191, 191, 191),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 35, 180, 115),
                )),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 191, 191, 191),
              ),
            ),
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.resolveWith(
              (states) => const Color.fromARGB(255, 35, 180, 115),
            ),
          ),
          colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: Color.fromARGB(255, 35, 180, 115),
            onPrimary: Color.fromARGB(255, 35, 180, 115),
            secondary: Color.fromARGB(255, 98, 98, 98),
            onSecondary: Color.fromARGB(255, 35, 180, 115),
            tertiary: Color.fromARGB(255, 191, 191, 191),
            error: Color.fromARGB(255, 35, 180, 115),
            onError: Color.fromARGB(255, 35, 180, 115),
            background: Color.fromARGB(255, 35, 180, 115),
            onBackground: Color.fromARGB(255, 35, 180, 115),
            surface: Color.fromARGB(255, 35, 180, 115),
            onSurface: Color.fromARGB(255, 35, 180, 115),
          )),
      routes: {
        '/': (context) => const PageLogin(),
        'dashboard': (context) => const PageDashboard(),
        'cadastrar-venda': (context) => const PageCreateDeals(),
        'profissionais': (context) => const PageUsers(),
        'vendas': (context) => const PageSeals(),
        'resgates': (context) => const PageReedems(),
      },
    );
  }
}
