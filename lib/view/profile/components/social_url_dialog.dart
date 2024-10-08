import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseComponents/spacing.dart';

class ConnectSocialDialog extends StatelessWidget {
   ConnectSocialDialog(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller});
  final String title;
  final String hintText;
  final TextEditingController controller ;
  final moreCont = Get.find<Editprofilecontroller>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      //backgroundColor: Colors.black,
      shadowColor: Colors.amber,
      elevation: 12,
      child: SingleChildScrollView(
        child: Container(
          width: context.width * .80,
          padding: EdgeInsets.only(
            top: context.height * .03,
            bottom: context.height * .02,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * .04,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style:
                      Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 20),
                ),
              ),
              Spacing.y(context, .02),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * .04,
                ),
                child: TextFieldWidget(hintText: hintText, controller: controller, borderRadius: 12, fillColor: Colors.black,cursorColor: Colors.white, textColor: Colors.white,)
              ),
              Spacing.y(context, .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Cancel",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      moreCont.checkLink(title: title, controller: controller);
                      
                    },
                    child: Text(
                      "Done",
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
