import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socialmedia/baseComponents/imports.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    // this.title,
    this.cont,
    this.isPasswordField = false,
    this.validator,
    this.readOnly = false,
    this.enabled = true,
    this.keyboardType,
    // this.hintTextColor = AppColors.gry,
    this.textColor = Colors.black,
    this.suffixIcon,
    this.onSuffixTap,
    this.textAlign,
    this.textFieldBorder,
    this.onChange,
    this.textCapitalization = TextCapitalization.sentences,
    this.fillColor = Colors.grey,
    this.borderColor = Colors.white,
    // this.showBorder = false,
    this.maxLines = 1,
    this.prefixIcon,
    this.onTap,
    this.isShadow = false,
    this.isRequiredField = true,
    this.hintText,
    this.titleSuffix,
    this.maxLength,
    this.isRemoveFocus = true,
    this.sufficIconBackgroundColor =Colors.black,
  });

  final String? hintText;
  final TextEditingController? cont;
  final bool isPasswordField;
  final FormFieldValidator? validator;
  final bool readOnly;
  final bool enabled;
  final bool isShadow;
  final TextInputType? keyboardType;
  final Color textColor, fillColor, borderColor;
  final Color sufficIconBackgroundColor;
  final Widget? prefixIcon;
  final String? suffixIcon;
  final Widget? titleSuffix;
  final VoidCallback? onSuffixTap, onTap;
  final TextAlign? textAlign;
  final InputBorder? textFieldBorder;
  final Function(String value)? onChange;
  final TextCapitalization? textCapitalization;
  // final bool showBorder;
  final int maxLines;
  final bool isRequiredField;
  final int? maxLength;
  final bool isRemoveFocus;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          onTap: widget.onTap,
          onTapOutside: widget.isRemoveFocus
              ? (e) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }
              : null,
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: widget.textColor,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          controller: widget.cont,
          onChanged: widget.onChange,
          maxLength: widget.maxLength,
          textCapitalization:
              widget.textCapitalization ?? TextCapitalization.sentences,
          textAlign: widget.textAlign ?? TextAlign.start,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          minLines: 1,
          validator: widget.validator ??
              (value) => value!.toString().trim().isEmpty
                  ? widget.isRequiredField
                      ? "${widget.hintText ?? ''} cannot be empty"
                      : null
                  : null,
          obscureText:
              widget.isPasswordField ? _hidePassword : widget.isPasswordField,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            isCollapsed: true,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.all(12),
                    child: widget.prefixIcon,
                  )
                : null,
            suffixIcon: widget.isPasswordField
                ? _hidePasswordIcon()
                : widget.suffixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.all(6),
                        child: InkWell(
                          onTap: widget.onSuffixTap,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 40,
                            width: 40,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: widget.sufficIconBackgroundColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: SvgPicture.asset(
                              widget.suffixIcon!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : null,
            hintText: widget.hintText,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            fillColor: Colors.black,
            filled: true,
            counter: const Offstage(),
            contentPadding: EdgeInsets.symmetric(
                horizontal: context.width * .04,
                vertical: context.height * .015),
            errorBorder: _inputBorder(),
            focusedErrorBorder: _inputBorder(),
            enabledBorder: _inputBorder(),
            disabledBorder: _inputBorder(),
            focusedBorder: _inputBorder(),
            border: _inputBorder(),
          ),
        ),
        // SB.h(10),
      ],
    );
  }

  InputBorder _inputBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: widget.borderColor),
      borderRadius: const BorderRadius.all(
        Radius.circular(12),
      ),
    );
  }

  void _toggleHidePassword() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  Widget _hidePasswordIcon() {
    return IconButton(
      onPressed: _toggleHidePassword,
      icon: Icon(
        _hidePassword ? Icons.visibility_off : Icons.visibility,
        color: Colors.amber,
      ),
    );
  }
}

class SimpleTextField extends StatelessWidget {
  final VoidCallback? onTap;
  final bool readOnly;
  final bool? enabled;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final TextInputType? keyboardType;
  final String? hint, prefixText;
  final Widget? suffixIcon;

  const SimpleTextField(
      {super.key,
      this.onTap,
      this.readOnly = false,
      this.enabled,
      this.controller,
      this.textCapitalization,
      this.keyboardType,
      this.hint,
      this.prefixText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      // width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly,
        enabled: enabled,
        controller: controller,
        // onChanged:onChange,
        textCapitalization: textCapitalization ?? TextCapitalization.sentences,
        // textAlign:textAlign ?? TextAlign.start,
        keyboardType: keyboardType,
        // maxLines:maxLines,
        // validator:validator ??
        //     (value) => value!.toString().trim().isEmpty
        //         ? "${widget.title ?? ''} required"
        //         : null,
        // obscureText:
        //    isPasswordField ? _hidePassword :isPasswordField,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          enabledBorder: _border(),
          disabledBorder: _border(),
          focusedBorder: _border(),
          border: _border(),
          // fillColor:fillColor,
          filled: true,
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          prefixIcon: prefixText != null
              ? SizedBox(
                  width: 0,
                  child: Center(
                    child: Text(
                      "${prefixText ?? ''}: ",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                )
              : null,
          suffixIcon: suffixIcon != null
              ? Padding(padding: const EdgeInsets.all(5), child: suffixIcon)
              : null,
          //   suffixIcon:isPasswordField
          //       ? _hidePasswordIcon()
          //       :suffixIcon != null
          //           ? Padding(
          //               padding: const EdgeInsets.all(6),
          //               child: InkWell(
          //                 onTap:onSuffixTap,
          //                 borderRadius: BorderRadius.circular(10),
          //                 child: Container(
          //                   padding: const EdgeInsets.all(10),
          //                   decoration: BoxDecoration(
          //                     color: context.primary,
          //                     borderRadius: BorderRadius.circular(10),
          //                   ),
          //                   child: SvgPicture.asset(
          //                    suffixIcon!,
          //                   ),
          //                 ),
          //               ),
          //             )
          //           : null,
        ),
      ),
    );
  }

  InputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}
