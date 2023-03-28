import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/pages/page_user.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_redeems.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_user.dart';

class ListUserItem extends StatelessWidget {
  const ListUserItem({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    ControllerDeals controller = Get.put(ControllerDeals());
    ControllerRedeem controllerRedeem = Get.put(ControllerRedeem());

    User userData = User.fromJson(data);
    bool isMobile = MediaQuery.of(context).size.width < 900;
    return Container(
      width: isMobile ? 320 : 250,
      height: 170,
      padding: isMobile
          ? const EdgeInsets.fromLTRB(8, 8, 8, 8)
          : const EdgeInsets.fromLTRB(10, 15, 10, 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              controller.queryParams.addAll({'userId': userData.id});
              controller.filterItemsByQuery(params: controller.queryParams);
              controllerRedeem
                  .filterItemsByQuery(params: {'userId': userData.id});
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PageUser(
                          userId: userData.id,
                        )),
              );
            },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(100)),
              child: userData.avatarUrl != null
                  ? Image.network(
                      userData.avatarUrl!,
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      'assets/images/profile.jpg',
                      width: 70,
                      height: 70,
                    ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: isMobile ? 200 : 120,
            padding: isMobile
                ? const EdgeInsets.fromLTRB(8, 8, 8, 8)
                : const EdgeInsets.fromLTRB(10, 15, 10, 15),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: isMobile
                      ? Colors.white
                      : Theme.of(context).colorScheme.tertiary,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(userData.balance != null
                    ? '${userData.balance!.toInt()} pts'
                    : ''),
                SizedBox(
                  width: isMobile ? 200 : 120,
                  child: Text(
                    maxLines: 3,
                    '${userData.firstName.trim()} ${userData.lastName.trim()}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Text(
                  userData.profession ?? '',
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
