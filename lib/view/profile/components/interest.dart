import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';


class Interests extends StatelessWidget {
  Interests({super.key});
  final controller = Get.put(Editprofilecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Edit Interests'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Select Your Interests',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                )),
            SizedBox(
              width: context.width,
              child: Obx(
                () => Wrap(
                  spacing: 8.0, // Add spacing between the items
                  runSpacing: 8.0, // Add spacing between rows
                  children: List.generate(
                    EditProfileData.interests.length,
                    (index) => GestureDetector(
                      onTap: () {
                        if (controller.Interests.contains(
                            EditProfileData.interests[index])) {
                          controller.Interests.remove(
                              EditProfileData.interests[index]);
                        } else {
                          controller.Interests.add(
                              EditProfileData.interests[index]);
                        }
                      },
                      child: IntrinsicWidth(
                        child: Card(
                          elevation: 12,
                          shadowColor: Colors.amber,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(12),
                              color: controller.Interests.contains(
                                      EditProfileData.interests[index])
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 12),
                              child: Center(
                                child: Text(
                                  EditProfileData.interests[index].toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: controller.Interests.contains(
                                                EditProfileData
                                                    .interests[index])
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
              ),
            )
          ],
        ),
      ),
    );
  }
}