import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';


class DobSection extends StatelessWidget {
  DobSection({super.key});
  final cont = Get.put(Editprofilecontroller());


  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: context.width * 0.27,
                child: CustomTextField(
                  cont: TextEditingController(
                      text: cont.selectedTime.value?.month.toString() ?? ""),
                  textAlign: TextAlign.center,
                  hintText: "MM",
                  readOnly: true,
                  onTap: () {
                    cont.selectDate(context);
                    log(cont.selectedTime.value.toString());
                  },
                  fillColor: Colors.white,
                  validator: (value) => null,
                ),
              ),
              SizedBox(
                width: context.width * 0.27,
                child: CustomTextField(
                  cont: TextEditingController(
                      text: cont.selectedTime.value?.day.toString() ?? ""),
                  textAlign: TextAlign.center,
                  hintText: "DD",
                  readOnly: true,
                  onTap: () {
                    cont.selectDate(context);
                    log(cont.selectedTime.value.toString());
                  },
                  fillColor: Colors.white,
                  validator: (value) => null,
                ),
              ),
              SizedBox(
                width: context.width * 0.27,
                child: CustomTextField(
                  cont: TextEditingController(
                      text: cont.selectedTime.value?.year.toString() ?? ""),
                  textAlign: TextAlign.center,
                  hintText: "YYYY",
                  readOnly: true,
                  onTap: () {
                    cont.selectDate(context);
                    log(cont.selectedTime.value.toString());
                    
                  },
                  fillColor: Colors.white,
                  validator: (value) => null,
                ),
              ),
            ],
          ),
          // This is where you validate the date of birth
          // Padding(
          //   padding: const EdgeInsets.only(left: 12.0, top: 8.0),
          //   child: Text(
          //     cont.validateDateOfBirth() ?? '',
          //     style: context.bodySmall?.copyWith(color: context.error),
          //   ),
          // ),
        ],
      ),
    );
  }
}
