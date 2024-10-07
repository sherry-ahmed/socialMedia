import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({
    super.key,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    required this.controller,
    this.keyboardType,
    this.validator,
    this.fillColor,
    this.cursorColor,
    this.isPassword = false,
    this.maxLines,
    this.maxLength,
    this.counterText,
    this.readOnly,
    this.autofillHints,
    this.focusNode,
    this.onFieldSubmittedValue,
    this.onChanged,
    required this.borderRadius,
    this.textColor,
    this.expands
  });
  List<String>? autofillHints;
  String hintText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool? readOnly;
  int? maxLines = 1;
  int? maxLength = 100;
  String? counterText;
  TextEditingController controller;
  TextInputType? keyboardType;
  Color? fillColor = Colors.white;
  Color? cursorColor;
  bool isPassword;
  FormFieldValidator<String>? validator;
  FormFieldSetter? onFieldSubmittedValue;
  FocusNode? focusNode;
  ValueChanged<String>? onChanged;
  Color? textColor;
  bool? expands ;
  
  int borderRadius;
  @override
  Widget build(BuildContext context) {
      return TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        autofocus: false,
        readOnly: readOnly ?? false,
        maxLines: maxLines,
        maxLength: maxLength,
        controller: controller,
        obscureText: isPassword,
        validator: validator,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        autofillHints: autofillHints,
        onChanged: onChanged,
        
        expands: expands??false,
        textAlignVertical: TextAlignVertical.top,
        style:
             TextStyle(color: textColor??Colors.black, fontWeight: FontWeight.normal, fontSize: 18),
        decoration: InputDecoration(
          counterText: counterText,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
          fillColor: fillColor,
          hintText: hintText,
          filled: true,
          hintStyle:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.toDouble()),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.toDouble()),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.toDouble()),
            borderSide: const BorderSide(color: Colors.white),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius.toDouble()),
            borderSide: const BorderSide(color: Colors.red),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
      );
  }
}
