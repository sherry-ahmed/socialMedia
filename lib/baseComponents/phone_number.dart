import 'package:flutter/material.dart';
import 'package:socialmedia/services/imports.dart';



// ignore: must_be_immutable
class AppPhoneInputField extends StatefulWidget {
  String? title;
  String? desc;
  PhoneController? controller;
  Function(PhoneNumber?)? phoneNumber;
  String? Function(PhoneNumber?)? validate;
  bool enabled;

  AppPhoneInputField(
      {super.key,
      this.title,
      this.controller,
      this.desc,
      this.phoneNumber,
      this.enabled = true,
      this.validate});

  @override
  State<AppPhoneInputField> createState() => _AppPhoneInputFieldState();
}

class _AppPhoneInputFieldState extends State<AppPhoneInputField> {
  // final countyPickerLayer = LayerLink();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Text(
            "${widget.title}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        if (widget.title != null) SB.h(5),
        if (widget.desc != null)
          Text(
            "${widget.desc}",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        if (widget.desc != null) SB.h(10),
        PhoneInput(
          enabled: widget.enabled,
          style: Theme.of(context).textTheme.bodyLarge,
          controller: widget.controller,
          countrySelectorNavigator:
              CountrySelectorNavigator.draggableBottomSheet(
            // layerLink: countyPickerLayer,
            // listHeight: context.height * 0.75,
            showSearchInput: true, borderRadius: BorderRadius.circular(15),
            bottomSheetDragHandlerColor: Colors.white,

            countryNameStyle:
                Theme.of(context).textTheme.bodyLarge,
            countryCodeStyle:
                Theme.of(context).textTheme.bodyLarge,
            flagSize: 30,
          ),
          onChanged: widget.phoneNumber,
          validator: widget.validate,
          decoration: InputDecoration(
            enabled: widget.enabled,
            fillColor: widget.enabled ? Colors.amber : Colors.grey.shade300,
            filled: true,
            border: InputBorder.none,
            hintText: 'PHone',
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.transparent)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.transparent)),
          ),
        ),
      ],
    );
  }
}
