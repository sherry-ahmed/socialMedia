import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/view/profile/model/data.dart';

import '../../../baseComponents/spacing.dart';

class Gender extends StatelessWidget {
  Gender({super.key});
  final controller = Get.put(Editprofilecontroller());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        direction: Axis.horizontal,
        children: [
          GestureDetector(
            onTap: () {
              controller.gender.value =
                  EditProfileData.gendersicons[0].toString();
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: EditProfileData.gendersicons[0].toString() ==
                          controller.gender.value
                      ? Colors.white
                      : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    EditProfileData.gendersicons[0].toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: EditProfileData.gendersicons[0].toString() ==
                                controller.gender.value
                            ? Colors.black
                            : Colors.white),
                  ),
                  Spacing.x(context, .01),
                  Assets.icons.malePng.image(width: 20, height: 20)
                ],
              ),
            ),
          ),
          SB.w(15),
          GestureDetector(
            onTap: () {
              controller.gender.value =
                  EditProfileData.gendersicons[1].toString();
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: EditProfileData.gendersicons[1].toString() ==
                          controller.gender.value
                      ? Colors.white
                      : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(EditProfileData.gendersicons[1].toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: EditProfileData.gendersicons[1].toString() ==
                                  controller.gender.value
                              ? Colors.black
                              : Colors.white)),
                  Spacing.x(context, .01),
                  Assets.icons.femalePng.image(width: 20, height: 20)
                ],
              ),
            ),
          ),
          SB.w(15),
          GestureDetector(
            onTap: () {
              controller.gender.value =
                  EditProfileData.gendersicons[2].toString();
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: EditProfileData.gendersicons[2].toString() ==
                          controller.gender.value
                      ? Colors.white
                      : Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(EditProfileData.gendersicons[2].toString(),
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: EditProfileData.gendersicons[2].toString() ==
                                  controller.gender.value
                              ? Colors.black
                              : Colors.white)),
                  Spacing.x(context, .01),
                  Assets.icons.otherPng.image(width: 20, height: 20)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}