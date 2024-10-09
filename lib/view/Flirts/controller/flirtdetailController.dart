import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseModel/requestedUserController.dart';
import 'package:url_launcher/url_launcher.dart';

class Flirtdetailcontroller extends GetxController{

  final requesteduser = Get.put(Requestedusercontroller());
  final controller = Get.find<Flirtcontroller>();

  Color dominantColor = Colors.red;
  


   Future<void> extractColors(String profile) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(profile),
       // Replace with your image URL
    );
    dominantColor = paletteGenerator.dominantColor!.color;


  }
    void launchURL(String? url) async {
    if (url != null) {
      final Uri uri = Uri.parse(url);

      if ( await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // log('Could not launch $url');
        Utils.toastMessage("Invalid Profile Link");
      }
    } else {
      log('URL is null');
    }
  }
  }