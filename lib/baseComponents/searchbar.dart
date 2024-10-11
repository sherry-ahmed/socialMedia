import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/home/controller/homeController.dart';

class Searchbar extends StatelessWidget {
  Searchbar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;
  final controller = Get.find<Homecontroller>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      autofocus: false,
      maxLines: 1,
      controller: searchController,
      cursorColor: Colors.black,
      onChanged: (value) {
        searchController.text = value;
        //controller.rebuild();
      },
      style: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        fillColor: Colors.white,
        hintText: 'search',
        filled: true,
        hintStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.white),
        ),
        prefixIcon: IconButton(
          onPressed: () {
            controller.searchbar(false); // Close search bar
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
    );
  }
}