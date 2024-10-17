import 'package:flutter/material.dart';
import '../../../services/imports.dart';

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
        cont.stateValue.value = 'state';
        cont.cityValue.value = 'city';
      },

      onStateChanged: (value) {
        cont.stateValue.value = value.toString();
        cont.cityValue.value='city';
      },
      onCityChanged: (value) {
        cont.cityValue.value = value.toString();
      },
    );
  }
}
