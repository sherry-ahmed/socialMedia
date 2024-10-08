// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:socialmedia/baseComponents/imports.dart';
// import 'package:socialmedia/utils/custom_map_picker.dart';

// class CSCSection extends StatelessWidget {
//   CSCSection({super.key});

//   final cont = Get.find<Editprofilecontroller>();

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => CustomCSCPicker(
//         dropdownDecoration: const BoxDecoration(
//           borderRadius: BorderRadius.all(
//             Radius.circular(12),
//           ),
//           color: Colors.grey,
//         ),
//         disabledDropdownDecoration: BoxDecoration(
//           borderRadius: const BorderRadius.all(
//             Radius.circular(12),
//           ),
//           color: Colors.amber.withOpacity(.1),
//         ),
//         countryDropdownLabel: cont.countryValue.value,
//         stateDropdownLabel: cont.stateValue.value,
//         cityDropdownLabel: cont.cityValue.value,
//         dropdownHeadingStyle: const TextStyle(
//           color: Colors.black,
//           fontSize: 17,
//           fontWeight: FontWeight.bold,
//         ),
//         dropdownItemStyle: const TextStyle(
//           color: Colors.black,
//           fontSize: 14,
//         ),
//         dropdownDialogRadius: 15,
//         searchBarRadius: 12,
//         onCountryChanged: (value) {
//           log(value);

//           cont.countryValue.value = value;
//           cont.stateValue.value =
//               "State"; // Reset state value when country changes
//           cont.cityValue.value =
//               "City"; // Reset city value when country changes
//           Utils.toastMessage(Validation.validateCSCPicker(cont.countryValue.value) ?? "");

//         },
//         flagState: CountryFlag.DISABLE,
//         onStateChanged: (value) {
//           cont.stateValue.value = value ?? "State";
//           cont.cityValue.value = "City"; // Reset city value when state changes
//           Utils.toastMessage(Validation.validateCSCPicker(cont.countryValue.value) ?? "");
//         },
//         onCityChanged: (value) {
//           cont.cityValue.value = value ?? "City";
//           Utils.toastMessage(Validation.validateCSCPicker(cont.countryValue.value) ?? "");
//         },
//       ),
//     );
//   }
// }

// GetX Controller for managing selected country, state, and city
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';

import '../../../baseComponents/imports.dart';

// LocationPickerScreen - View
class CountryPicker extends StatelessWidget {
  final cont = Get.find<Editprofilecontroller>();

  CountryPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return CSCPicker(
      showStates: true,
      showCities: true,
      flagState: CountryFlag.ENABLE, // Show flags
      dropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.black,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      disabledDropdownDecoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.white38,
        border: Border.all(color: Colors.white, width: 1),
      ),
      countryDropdownLabel: cont.countryValue.value,
      stateDropdownLabel: cont.stateValue.value,
      cityDropdownLabel: cont.cityValue.value,
      selectedItemStyle: const TextStyle(color: Colors.white, fontSize: 14),
      dropdownHeadingStyle: const TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      dropdownItemStyle: const TextStyle(color: Colors.black, fontSize: 14),
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,

      onCountryChanged: (value) {
        log(value);

        cont.countryValue.value = value;
      },

      onStateChanged: (value) {
        cont.stateValue.value = value.toString();
      },
      onCityChanged: (value) {
        cont.cityValue.value = value.toString();
      },
    );
  }
}
