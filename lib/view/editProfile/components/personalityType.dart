import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class PersonalityType extends StatelessWidget {
  PersonalityType({super.key});
  final controller = Get.put(Editprofilecontroller());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Obx(
        () => Wrap(
          spacing: 8.0, 
          runSpacing: 8.0, 
          children: List.generate(
            EditProfileData.personalityType.length,
            (index) => GestureDetector(
              onTap: () {
               
                controller.personalityType.value =
                    EditProfileData.personalityType[index].toString();
              },
              child: IntrinsicWidth(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: EditProfileData.personalityType[index].toString() ==
                            controller.personalityType.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: Center(
                      child: Text(
                        EditProfileData.personalityType[index].toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: EditProfileData.personalityType[index]
                                          .toString() ==
                                      controller.personalityType.value
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