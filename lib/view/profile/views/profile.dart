import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';
import 'package:socialmedia/baseComponents/timeGetter.dart';

class Profile extends StatelessWidget {
  Profile({super.key});
  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SB.h(context.width * 0.1),
            Container(
              //height: 750,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 12,
                  shadowColor: Colors.amber,
                  child: Container(
                    //height: 590,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: context.width * 0.05),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, bottom: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Obx(
                                    () => Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.white, width: 5)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: userController.currentUser.value
                                                  .profile.isEmpty
                                              ? Assets.images.womenPeekingOut
                                                  .image(fit: BoxFit.cover)
                                              : Image.network(
                                                  userController
                                                      .currentUser.value.profile,
                                                  fit: BoxFit.cover,
                                                ),
                                        )),
                                  ),
                                  Text(
                                      'Hi! ${userController.currentUser.value.username} \n${Timegetter.getGreeting()}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!.copyWith(fontSize: 16)),
                                ],
                              ),
                              Text('Account',
                                  style: Theme.of(context).textTheme.titleSmall),
                              Profilerow(
                                divider: true,
                                leadingIcon: Icons.edit_rounded,
                                trailingIcon: Icons.arrow_forward_ios,
                                text: 'Edit Profile',
                                onPressed: () {
                                  Get.to(() => Editprofile());
                                },
                              ),
                              Text('About',
                                  style: Theme.of(context).textTheme.titleSmall),
                              Profilerow(
                                divider: true,
                                leadingIcon: Icons.help,
                                trailingIcon: Icons.arrow_forward_ios,
                                text: 'Help & Support',
                                onPressed: () {
                                  Get.to(() => const HelpSupportPage());
                                },
                              ),
                              Profilerow(
                                  divider: true,
                                  leadingIcon: Icons.info,
                                  trailingIcon: Icons.arrow_forward_ios,
                                  text: 'About Us',
                                  onPressed: () {
                                    Get.to(() => const AboutUsPage());
                                  }),
                              Profilerow(
                                divider: true,
                                leadingIcon: Icons.privacy_tip,
                                trailingIcon: Icons.arrow_forward_ios,
                                text: 'Privacy Policy',
                                onPressed: () {
                                  Get.to(() => PrivacyPolicyPage());
                                },
                              ),
                              Text('General',
                                  style: Theme.of(context).textTheme.titleSmall),
                              Profilerow(
                                divider: true,
                                leadingIcon: Icons.shop,
                                trailingIcon: Icons.arrow_forward_ios,
                                text: 'Purchases',
                                onPressed: () {},
                              ),
                              Profilerow(
                                divider: false,
                                leadingIcon: Icons.check_circle,
                                trailingIcon: Icons.arrow_forward_ios,
                                text: 'Logout',
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Get.offAll(() => LoginScreen());
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
