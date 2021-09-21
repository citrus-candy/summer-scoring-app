import 'package:get/get.dart';

class ChangeThemeController extends GetxController {
  final isSunTheme = false.obs;

  changeTheme(value) => isSunTheme.value = value;
}
