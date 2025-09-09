import 'package:get/get.dart';

class InboxController extends GetxController {
  /// 0 = All, 1 = Starred
  final tab = 0.obs;
  void setTab(int i) => tab.value = i;
}