import 'package:flutter/material.dart';
import '../../../baseComponents/imports.dart';

class RelationshipType extends StatelessWidget {
  RelationshipType({super.key});
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
            EditProfileData.relationshipType.length,
            (index) => GestureDetector(
              onTap: () {
                // Update the selected sexual orientation
                controller.relationshipType.value =
                    EditProfileData.relationshipType[index].toString();
              },
              child: IntrinsicWidth(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(12),
                    color: EditProfileData.relationshipType[index].toString() ==
                            controller.relationshipType.value
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 12),
                    child: Center(
                      child: Text(
                        EditProfileData.relationshipType[index].toString(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: EditProfileData.relationshipType[index]
                                          .toString() ==
                                      controller.relationshipType.value
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