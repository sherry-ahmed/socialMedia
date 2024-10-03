import  'package:flutter/material.dart';
import 'package:socialmedia/components/imports.dart';

class Editprofile extends StatelessWidget {
  Editprofile({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final UserController userController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    nameController.text = userController.currentUser.value.username;
    emailController.text = userController.currentUser.value.email;
    return SafeArea(
        child: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: GetBuilder<Editprofilecontroller>(
        init: Editprofilecontroller(),
        builder: (controller) => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.black,
            iconTheme: Theme.of(context).iconTheme,
          ),
          resizeToAvoidBottomInset: false,
          body: userController.currentUser.value.email == ''
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 5)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: userController
                                        .currentUser.value.profile.isEmpty
                                    ? Assets.images.womenPeekingOut.image(fit: BoxFit.cover)
                                    : Image.network(userController
                                        .currentUser.value.profile,fit: BoxFit.cover),
                              )),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                //controller.pickImage(ImageSource.camera);
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ImageSourceBottomSheet(
                                      onImageSourceSelected:
                                          (ImageSource source) {
                                        
                                        controller.pickImage(source);
                                        log('Selected source: $source');
                                      },
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.black, width: 2)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Icon(
                                      Icons.photo_camera,
                                      color: Colors.black,
                                      size: 20,
                                    ) // Your dummy image path
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFieldWidget(
                                hintText: 'Username Name',
                                keyboardType: TextInputType.name,
                                controller: nameController,
                                fillColor: Colors.white,
                                cursorColor: Colors.black,
                                maxLines: 1,
                                validator: Validation.validateName,
                                autofillHints: const [AutofillHints.name],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFieldWidget(
                                readOnly: true,
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                fillColor: Colors.white,
                                cursorColor: Colors.black,
                                maxLines: 1,
                                validator: Validation.validateEmail,
                                autofillHints: const [AutofillHints.email],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomElevatedButton(
                            loading: false,
                            text: 'Update Profile',
                            textColor: Colors.black,
                            onPressed: () async {
                              // Update the user's username and call updateUserData
                              UserModel updatedUser =
                                  userController.currentUser.value.copyWith(
                                username: nameController.text,
                              );
                              await userController.updateUserData(updatedUser);
                              Get.back(); // Go b Go back after updating
                            },
                            width: screenWidth,
                            height: 50,
                            shadowColor: false,
                            elevation: false,
                            color: Colors.white,
                            radius: 12),
                      )
                    ],
                  ),
                ),
        ),
      ),
    ));
  }
}
