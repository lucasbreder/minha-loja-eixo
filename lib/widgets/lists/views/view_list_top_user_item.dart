import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minha_loja_eixo/pages/page_user.dart';
import 'package:minha_loja_eixo/widgets/lists/controllers/controller_deals.dart';
import 'package:minha_loja_eixo/widgets/lists/models/model_user.dart';

class ListTopUserItem extends StatelessWidget {
  const ListTopUserItem({required this.data, super.key});

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    ControllerDeals controller = Get.put(ControllerDeals());

    User userData = User.fromJson(data);

    return Container(
      width: 418,
      padding: const EdgeInsets.only(top: 4, bottom: 4),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  controller.queryParams.addAll({'userId': userData.id});
                  controller.filterItemsByQuery(params: controller.queryParams);
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
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/profile.jpg',
                          width: 40,
                          height: 40,
                        ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    controller.queryParams.addAll({'userId': userData.id});
                    controller.filterItemsByQuery(
                        params: controller.queryParams);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageUser(
                                userId: userData.id,
                              )),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width < 900 ? 120 : 300,
                    child: Text(
                      maxLines: 3,
                      '${userData.firstName} ${userData.lastName}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(userData.balance != null
              ? '${userData.balance!.toInt()} pts'
              : ''),
        ],
      ),
    );
  }
}
