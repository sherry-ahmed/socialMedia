import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';


class AddSocials extends StatelessWidget {
  AddSocials({super.key});
  final controller = Get.find<Editprofilecontroller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'My Socials'),
      bottomSheet: Container(
            height: context.height * .1,
            width: context.width,
            color: Colors.black,
            child: Center(
                child: CustomElevatedButton(
                    loading: false,
                    text: 'Save',
                    textColor: Colors.black,
                    onPressed: () {
                     controller.updateSocials();
                    },
                    width: context.width * .85,
                    height: context.height * .057,
                    color: Colors.white,
                    radius: 10)),
          ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Get.dialog(ConnectSocialDialog(
                    title: 'facebook',
                    hintText: 'Facebook Link',
                    controller: controller.facebookController));
              },
              child: Card(
                color: Colors.black,
                elevation: 10,
                shadowColor: Colors.amber,
                child: ListTile(
                  leading: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Assets.icons.facebookPng.image(),
                      )),
                  title: Text('connect Facebook',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15)),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.dialog(ConnectSocialDialog(
                    title: 'instagram',
                    hintText: 'Instagram Link',
                    controller: controller.instaController));
              },
              child: Card(
                color: Colors.black,
                elevation: 10,
                shadowColor: Colors.amber,
                child: ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Assets.icons.instaColoured.image(),
                      )),
                  title: Text('connect Instagram',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15)),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white70),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.dialog(ConnectSocialDialog(
                    title: 'twitter',
                    hintText: 'Twitter Link',
                    controller: controller.twitterController));
              },
              child: Card(
                color: Colors.black,
                elevation: 10,
                shadowColor: Colors.amber,
                child: ListTile(
                  leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.amber.withOpacity(0.2)),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Assets.icons.twitterColoured.image(),
                      )),
                  title: Text('connect Twitter',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15)),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.white70),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}