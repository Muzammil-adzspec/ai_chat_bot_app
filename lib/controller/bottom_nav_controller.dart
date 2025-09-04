import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final tab = 0.obs;

  void changeTab(int index) => tab.value = index;

  // Central FAB
  void newChat() {
    // route will be invoked by view via extension
    // (keep blank here if you want the view to own navigation)
  }
}