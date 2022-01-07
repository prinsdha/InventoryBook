import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:product/core/constant/app_colors.dart';

import '../../../../global.dart';

class CustomDropDown2 extends StatefulWidget {
  final Function(dynamic val) onChanged;
  const CustomDropDown2({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<CustomDropDown2> createState() => _CustomDropDown2State();
}

class _CustomDropDown2State extends State<CustomDropDown2> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: const Text(
          'All',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        items: dayFilterList
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: selectedValue,
        onChanged: (value) {
          setState(() {
            widget.onChanged(value);
            selectedValue = value.toString();
          });
        },
        icon: const RotatedBox(
          quarterTurns: 1,
          child: Icon(
            Icons.arrow_forward_ios,
          ),
        ),
        iconSize: 14,
        buttonHeight: 40,
        iconEnabledColor: Colors.white,
        iconDisabledColor: Colors.white,
        buttonWidth: 70,
        itemWidth: 150,
        buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColor.kAppBarColor,
        ),
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        dropdownElevation: 8,
        offset: const Offset(-20, 0),
      ),
    );
  }
}
