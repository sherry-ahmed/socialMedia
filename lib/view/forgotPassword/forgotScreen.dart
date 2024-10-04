import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class Forgotscreen extends StatelessWidget {
  Forgotscreen({super.key});
  final emailController = TextEditingController();
  final emailFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        Get.back();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
          backgroundColor: Colors.black,
        ),
        resizeToAvoidBottomInset: false,
        //backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: GetBuilder<Forgotcontroller>(
            init: Forgotcontroller(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter Your account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white),
                ),
                SB.h(20),
                Form(
                    key: _formKey,
                    child: AutofillGroup(
                      child: TextFieldWidget(
                        borderRadius: 12,
                        hintText: 'Email',
                        maxLines: 1,
                        autofillHints: const [AutofillHints.email],
                        controller: emailController,
                        focusNode: emailFocusNode,
                        validator: Validation.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.email),
                        cursorColor: Colors.black,
                      ),
                    )),
                //SB.h(10),

                SB.h(30),
                CustomElevatedButton(
                    loading: controller.loading,
                    text: 'Login',
                    textColor: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.loading
                            ? null
                            : controller.forgotPassword(
                                emailController.text.trim(),
                              );
                      }
                    },
                    width: screenWidth,
                    height: 50,
                    shadowColor: false,
                    elevation: false,
                    color: Colors.white,
                    radius: 12),
                SB.h(20),
                GestureDetector(
                  onTap: () => Get.to(() => SignUpScreen()),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Don't have an account ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white)),
                    TextSpan(
                      text: 'Sign Up',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.primaryColor),
                    )
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
