import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socialmedia/baseComponents/custom_elevated_button.dart';
import 'package:socialmedia/baseComponents/formValidation.dart';
import 'package:socialmedia/baseComponents/sb.dart';
import 'package:socialmedia/baseComponents/textFieldWidget.dart';
import 'package:socialmedia/res/color.dart';
import 'package:socialmedia/view/forgotPassword/forgotScreen.dart';
import 'package:socialmedia/view/login/loginController.dart';
import 'package:socialmedia/view/signup/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
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
        Get.offAll;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: GetBuilder<Logincontroller>(
            init: Logincontroller(),
            builder: (controller) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Login to Your account',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(color: Colors.white),
                ),
                SB.h(20),
                Form(
                    key: _formKey,
                    child: AutofillGroup(
                      child: Column(
                        children: [
                          TextFieldWidget(
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
                          SB.h(10),
                          TextFieldWidget(
                            borderRadius: 12,
                            hintText: 'Password',
                            controller: passwordController,
                            autofillHints: const [AutofillHints.password],
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
                      ),
                    )),
                SB.h(10),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Get.to(() => Forgotscreen()),
                      child: Text(
                        "Forgot Password",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColors.primaryColor),
                      ),
                    )),
                SB.h(30),
                CustomElevatedButton(
                    loading: controller.loading,
                    text: 'Login',
                    textColor: Colors.black,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        controller.loading
                            ? null
                            : controller.login(emailController.text.trim(),
                                passwordController.text.trim());
                      }
                    },
                    width: screenWidth,
                    height: 50,
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
