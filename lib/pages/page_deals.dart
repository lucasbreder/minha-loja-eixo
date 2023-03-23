import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:minha_loja_eixo/widgets/lists/views/view_list_deals.dart';
import 'package:minha_loja_eixo/widgets/scaffold/views/base_scaffold.dart';

class PageSeals extends StatefulWidget {
  const PageSeals({super.key});

  @override
  State<PageSeals> createState() => _PageSealsState();
}

class _PageSealsState extends State<PageSeals> {
  bool isAdmin = false;

  void checkAdminRole() async {
    const storage = FlutterSecureStorage();
    String? role = await storage.read(key: 'role');
    setState(() {
      isAdmin = role == "4" ? true : false;
    });
  }

  @override
  void initState() {
    checkAdminRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: 'Vendas',
      children: [
        ListDeals(
          showFilters: isAdmin,
          showTotal: true,
        ),
      ],
    );
  }
}
