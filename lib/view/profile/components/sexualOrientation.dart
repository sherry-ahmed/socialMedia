import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/profile/model/data.dart';

class SexualOrientation extends StatelessWidget {
  SexualOrientation({super.key});
  final controller = Get.put(Editprofilecontroller());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Obx(
        () => Wrap(
          spacing: 8.0, // Add spacing between the items
          runSpacing: 8.0, // Add spacing between rows
          children: List.generate(
            EditProfileData.sexualOrientation.length,
            (index) => GestureDetector(
              onTap: () {
                // Update the selected sexual orientation
                controller.sexualOrientation.value =
                    EditProfileData.sexualOrientation[index].toString();
              },
              child: IntrinsicWidth(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color:
                        EditProfileData.sexualOrientation[index].toString() ==
                                controller.sexualOrientation.value
                            ? Colors.white
                            : Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: Center(
                      child: Text(
                        EditProfileData.sexualOrientation[index].toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: EditProfileData.sexualOrientation[index]
                                          .toString() ==
                                      controller.sexualOrientation.value
                                  ? Colors.black
                                  : Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}