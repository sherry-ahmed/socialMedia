import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';

class Editprofile extends StatelessWidget {
  Editprofile({super.key});

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    //final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetBuilder<Editprofilecontroller>(
        init: Editprofilecontroller(),
        builder: (controller) => Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: const CustomAppBar(title: "Edit Profile"),
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
                      controller.updateData();
                    },
                    width: context.width * .85,
                    height: context.height * .057,
                    color: Colors.white,
                    radius: 10)),
          ),
          body: userController.currentUser.value.email == ''
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return ImageSourceBottomSheet(
                                  onImageSourceSelected: (ImageSource source) {
                                    controller.pickImage(source);
                                    log('Selected source: $source');
                                  },
                                );
                              },
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            elevation: 20,
                            shadowColor: Colors.amber,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                userController.currentUser.value.profile.isEmpty
                                    ? Assets.images.womenPeekingOut.image(
                                        fit: BoxFit.cover,
                                        height: 150,
                                        width: 150)
                                    : profileImage(
                                        profile: userController
                                            .currentUser.value.profile,
                                            
                                        height: 150,
                                        width: 150),
                                Positioned(
                                  right: 3,
                                  bottom: 3,
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black, width: 2)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: const Icon(
                                          Icons.photo_camera,
                                          color: Colors.black,
                                          size: 20,
                                        ) // Your dummy image path
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Form(
                          key: controller.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Details",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Spacing.y(context, .01),
                              Text(
                                "Name",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextFieldWidget(
                                borderRadius: 12,
                                hintText: 'Username Name',
                                keyboardType: TextInputType.name,
                                controller: controller.nameController,
                                fillColor: Colors.black,
                                cursorColor: Colors.black,
                                textColor: Colors.white,
                                maxLines: 1,
                                validator: Validation.validateName,
                                autofillHints: const [AutofillHints.name],
                              ),
                              Spacing.y(context, .01),
                              Text(
                                "Phone Number",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextFieldWidget(
                                borderRadius: 12,
                                readOnly: false,
                                hintText: 'Enter Phone',
                                keyboardType: TextInputType.number,
                                controller: controller.phoneController,
                                fillColor: Colors.black,
                                textColor: Colors.white,
                                cursorColor: Colors.white,
                                maxLines: 1,
                                validator: Validation.validatePhoneNumber,
                              ),
                              Spacing.y(context, .01),
                              Text(
                                "Email",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextFieldWidget(
                                borderRadius: 12,
                                readOnly: true,
                                hintText: 'Email',
                                controller: controller.emailController,
                                fillColor: Colors.black,
                                textColor: Colors.white,
                                cursorColor: Colors.black,
                                maxLines: 1,
                              ),
                              Spacing.y(context, .01),
                              Text(
                                "About",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(
                                height: 100,
                                child: TextFieldWidget(
                                  borderRadius: 12,
                                  readOnly: false,
                                  hintText: 'Add lines in your bio',
                                  //keyboardType: TextInputType.name,
                                  controller: controller.bioController,
                                  fillColor: Colors.black,
                                  textColor: Colors.white,
                                  cursorColor: Colors.white,
                                  maxLines: null,
                                  expands: true,
                                  //validator: Validation.vali,
                                ),
                              ),
                              Spacing.y(context, .01),
                              Text(
                                "Date of Birth",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              DobSection(),
                              Spacing.y(context, .01),
                              Text(
                                "Gender",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              Gender(),
                              Spacing.y(context, .01),
                              Text(
                                "Sexual Orientation",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SexualOrientation(),
                              Spacing.y(context, .01),
                              Text(
                                "Relationship Type",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              RelationshipType(),
                              Spacing.y(context, .01),
                              Text(
                                "Personality Type",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              PersonalityType(),
                              Spacing.y(context, .01),
                              Text(
                                "Edit Location",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              CountryPicker(),
                              Spacing.y(context, .01),
                              Text(
                                "Social Media",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => AddSocials());
                                },
                                child: const Card(
                                  color: Colors.black,
                                  elevation: 10,
                                  shadowColor: Colors.amber,
                                  child: SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text('Add Socials'),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white70,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Spacing.y(context, .01),
                              Text(
                                "Interests",
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => Interests());
                                },
                                child: const Card(
                                  color: Colors.black,
                                  elevation: 10,
                                  shadowColor: Colors.amber,
                                  child: SizedBox(
                                    height: 50,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: Row(
                                        children: [
                                          Text('Change Interests'),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white70,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SB.h(100)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    ));
  }
}
