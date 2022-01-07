import 'package:flutter/material.dart';
import 'package:product/core/utils/app_function.dart';
import 'package:product/core/utils/config.dart';

import 'custom_textfield.dart';

class CustomDropDownFiled extends StatefulWidget {
  const CustomDropDownFiled(
      {Key? key,
      required this.textFieldType,
      required this.textEditingController,
      required this.list,
      this.labelToHint = false,
      this.selectedValue,
      this.hint,
      this.onChanged})
      : super(key: key);
  final TextFieldType textFieldType;
  final TextEditingController textEditingController;
  final List<String> list;
  final bool labelToHint;
  final String? selectedValue;
  final String? hint;
  final Function(dynamic value)? onChanged;

  @override
  State<CustomDropDownFiled> createState() => _CustomDropDownFiledState();
}

class _CustomDropDownFiledState extends State<CustomDropDownFiled> {
  String? currentSelectedValue;
  @override
  void initState() {
    if (widget.selectedValue != null) {
      currentSelectedValue = widget.selectedValue;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero
                .copyWith(left: 10, right: 10, top: 7, bottom: 7),
            labelText: widget.labelToHint ? null : getLabelText(),
            enabledBorder: inputBorder(),
            disabledBorder: inputBorder(),
            labelStyle: inputTextStyle(),
            border: inputBorder(),
            focusedBorder: inputBorder(),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                widget.hint ?? widget.list[0],
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              value: currentSelectedValue,
              icon: const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: RotatedBox(
                    quarterTurns: 3, child: Icon(Icons.arrow_back_ios)),
              ),
              style: inputTextStyle(),
              isDense: true,
              onTap: () {
                disposeKeyboard();
              },
              onChanged: (newValue) {
                setState(() {
                  currentSelectedValue = newValue;
                  widget.textEditingController.text = newValue!;
                });
              },
              items: widget.list.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  TextStyle inputTextStyle() {
    return TextStyle(color: Colors.black, fontSize: getWidth(14));
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Colors.black, width: 1));
  }

  String getLabelText() {
    switch (widget.textFieldType) {
      case TextFieldType.quantity:
        return "Quantity";

      default:
        return "";
    }
  }
}
