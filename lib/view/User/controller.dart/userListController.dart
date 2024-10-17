import 'package:socialmedia/services/imports.dart';

class Userlistcontroller extends GetxController {
  List<String> friends = [];

  bool showsearchbar = false;
  searchbar(value) {
    showsearchbar = value;
    update();
  }

  rebuild() {
    update();
  }
}
