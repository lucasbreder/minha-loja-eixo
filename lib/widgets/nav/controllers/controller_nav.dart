import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class ControllerNav extends GetxController {
  // this is the list of items
  Rx<String> activeMenu = ''.obs;
  Rx<String> brand = ''.obs;

  getBrand() async {
    const storage = FlutterSecureStorage();
    brand.value = await storage.read(key: 'storeBrand') ?? '';
  }
}
