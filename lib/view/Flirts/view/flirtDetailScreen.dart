import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/custom_appbar.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/Flirts/components/blockReport.dart';

class Flirtdetailscreen extends StatelessWidget {
  final UserModel data;

  const Flirtdetailscreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: data.username, onBackPressed: () => Get.back(), actions: [const Blockreport(),],),
      body: Center(child: Image.network(data.profile),),
    );
  }
}