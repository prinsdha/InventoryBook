import 'package:flutter/material.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/constant/app_settings.dart';
import 'package:product/core/utils/config.dart';

class CustomAppTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextFieldType textFieldType;
  final TextInputAction textInputAction;
  final Function(String? value)? onEditing;
  final String? Function(String?)? validator;
  final bool wantBorder;
  final Widget? foot;

  const CustomAppTextField(
      {Key? key,
      required this.textEditingController,
      required this.textFieldType,
      this.validator,
      this.textInputAction = TextInputAction.next,
      this.wantBorder = true,
      this.foot,
      this.onEditing})
      : super(key: key);

  @override
  State<CustomAppTextField> createState() => _CustomAppTextFieldState();
}

class _CustomAppTextFieldState extends State<CustomAppTextField> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.removeListener(_onFocusChange);

    _focusNode.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.textFieldType) {
      case TextFieldType.searchField:
        return searchField();
      default:
        if (widget.wantBorder) {
          return Container(
            decoration: BoxDecoration(
                color: AppColor.kFieldFillColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.40),
                      offset: const Offset(-2, 2),
                      blurRadius: 5)
                ]),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [buildTextFormField(), widget.foot ?? const SizedBox()],
            ),
          );
        }
        return buildTextFormField();
    }
  }

  TextFormField buildTextFormField() {
    return TextFormField(
      controller: widget.textEditingController,
      obscureText: getObSecureText(),
      focusNode: _focusNode,
      validator: getValidation(),
      keyboardType: getKeyboardType(),
      maxLines: maxLine(),
      style: inputTextStyle(),
      enabled: getEnabled(),
      onChanged: widget.onEditing,
      textCapitalization: getTextCapitalization(),
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.zero.copyWith(left: 10, right: 10, top: 7, bottom: 7),
        label: Text(
          getLabelText(),
        ),
        enabledBorder: inputBorder(),
        disabledBorder: inputBorder(),
        labelStyle: inputTextStyle(),
        border: inputBorder(),
        focusedBorder: inputBorder(),
      ),
    );
  }

  Widget searchField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            )
          ]),
      child: TextField(
        controller: widget.textEditingController,
        textCapitalization: getTextCapitalization(),
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
            suffixIcon: const Icon(
              Icons.mic,
              color: Colors.black,
            ),
            border: InputBorder.none,
            hintText: getLabelText()),
      ),
    );
  }

  bool getEnabled() {
    switch (widget.textFieldType) {
      case TextFieldType.category:
        return false;
      default:
        return true;
    }
  }

  TextStyle inputTextStyle() {
    return TextStyle(color: Colors.black, fontSize: getWidth(14));
  }

  InputBorder inputBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Colors.black, width: 1));
  }

  int? maxLine() {
    switch (widget.textFieldType) {
      case TextFieldType.description:
        return null;
      default:
        return 1;
    }
  }

  bool getObSecureText() {
    return false;
  }

  String getLabelText() {
    switch (widget.textFieldType) {
      case TextFieldType.itemName:
        return "Product Name";
      case TextFieldType.price:
        return "Actual Price";
      case TextFieldType.discountedPrice:
        return "Discounted Price";
      case TextFieldType.category:
        return "Category";
      case TextFieldType.stockUnit:
        return "Stock Units";
      case TextFieldType.description:
        return "Description";
      case TextFieldType.unit:
        return "Unit";
      case TextFieldType.searchField:
        return "Search Products...";
      default:
        return "";
    }
  }

  TextInputType getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.price:
      case TextFieldType.discountedPrice:
      case TextFieldType.stockUnit:
      case TextFieldType.unit:
        return TextInputType.number;
      case TextFieldType.itemName:

      case TextFieldType.category:
        return TextInputType.name;
      case TextFieldType.description:
        return TextInputType.multiline;
      default:
        return TextInputType.none;
    }
  }

  TextCapitalization getTextCapitalization() {
    return TextCapitalization.sentences;
  }

  getValidation() {
    return (val) => val!.trim().isEmpty ? "Field is required" : null;
  }
}

enum TextFieldType {
  itemName,
  price,
  discountedPrice,
  quantity,
  unit,
  category,
  description,
  stockUnit,
  searchField
}
