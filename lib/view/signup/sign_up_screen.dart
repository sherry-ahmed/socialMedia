import 'package:flutter/material.dart';
import 'package:socialmedia/baseComponents/imports.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final userNameController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final userNameFocusNode = FocusNode();
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
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: GetBuilder<Signupcontroller>(
            init: Signupcontroller(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create Your account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white),
                ),
                SB.h(20),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFieldWidget(
                          borderRadius: 12,
                          hintText: 'UserName',
                          controller: userNameController,
                          maxLines: 1,
                          focusNode: userNameFocusNode,
                          validator: Validation.validateName,
                          keyboardType: TextInputType.name,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.person),
                          cursorColor: Colors.black,
                          onFieldSubmittedValue: (value) {
                            Utils.fieldfocus(
                                context, userNameFocusNode, emailFocusNode);
                          },
                        ),
                        SB.h(10),
                        TextFieldWidget(
                          borderRadius: 12,
                          hintText: 'Email',
                          controller: emailController,
                          autofillHints: const [AutofillHints.email],
                          maxLines: 1,
                          focusNode: emailFocusNode,
                          validator: Validation.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.email),
                          cursorColor: Colors.black,
                          onFieldSubmittedValue: (value) {
                            Utils.fieldfocus(
                                context, emailFocusNode, passwordFocusNode);
                          },
                        ),
                        SB.h(10),
                        TextFieldWidget(
                          borderRadius: 12,
                          hintText: 'Password',
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          validator: Validation.validatePassword,
                          keyboardType: TextInputType.visiblePassword,
                          isPassword: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.key),
                          cursorColor: Colors.black,
                          maxLines: 1,
                        ),
                      ],
                    )),
                SB.h(30),
                CustomElevatedButton(
                    loading: controller.loading,
                    text: 'Signup',
                    textColor: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.loading
                            ? null
                            : controller.signup(
                                userNameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim());
                      }
                    },
                    width: screenWidth,
                    height: 50,
                    color: Colors.white,
                    radius: 12),
                SB.h(20),
                GestureDetector(
                  onTap: () => Get.off(() => LoginScreen()),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "Already have an account? ",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white)),
                    TextSpan(
                      text: 'Login Up',
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
