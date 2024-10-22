import 'dart:io';

import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';
import 'package:socialmedia/view/mapScreen/controller/checkInController.dart';

class AddCheckInDialog extends StatelessWidget {
  AddCheckInDialog({super.key});
  final Checkincontroller checkincontroller = Get.put(Checkincontroller());

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(alignment: Alignment.centerRight,child: IconButton(onPressed: (){Get.back();}, icon: const Icon(Icons.close))),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Text('Add Check-In Location', style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),),
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                checkincontroller.pickImage(ImageSource.camera);
              },
              child: Container(
                  clipBehavior: Clip.hardEdge,
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 1, color: Colors.white)),
                  child: checkincontroller.imagePath.value == ''
                      ? Center(
                          child: Assets.images.addImage
                              .image(width: 70, height: 70))
                      : Image.file(
                          File(checkincontroller.imagePath.value),
                          fit: BoxFit.cover,
                        )),
            ),
          ),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: TextFieldWidget(
              hintText: 'Add Place Name',
              controller: checkincontroller.placenameController,
              borderRadius: 12,
              textColor: Colors.black,
              cursorColor: Colors.black,
              fillColor: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: TextFieldWidget(
              hintText: 'Share Your Vibe',
              controller: checkincontroller.storylineController,
              borderRadius: 12,
              textColor: Colors.black,
              cursorColor: Colors.black,
              fillColor: Colors.white,
            ),
          ),
          

          Obx(
            () => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8),
              child: CustomElevatedButton(
                  color: Colors.white,
                  textColor: Colors.black,
                  loading: checkincontroller.isLoading.value,
                  text: "Save",
                  onPressed: () {
                    if (checkincontroller.imagePath.value == '' ||
                        checkincontroller.storylineController.text.isEmpty|| checkincontroller.placenameController.text.isEmpty) {
                      Utils.toastMessage('Add image and story line');
                    }else{
                      checkincontroller.saveData();
                    }
                  }),
            ),
          )
          // Additional fields for address, place name, etc.
        ],
      ),
    );
  }
}
