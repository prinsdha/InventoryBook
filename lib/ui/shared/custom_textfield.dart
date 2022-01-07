import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      obscureText: getObSecureText,
      focusNode: _focusNode,
      validator: widget.validator ?? getValidation,
      keyboardType: getKeyboardType,
      maxLines: maxLine,
      style: inputTextStyle,
      enabled: getEnabled,
      maxLength: getMaxLength,
      onChanged: widget.onEditing,
      textCapitalization: getTextCapitalization,
      textInputAction: widget.textInputAction,
      inputFormatters: getTextInputFormatter,
      buildCounter: (BuildContext context,
              {required int currentLength,
              required bool isFocused,
              required int? maxLength}) =>
          null,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.zero.copyWith(left: 10, right: 10, top: 7, bottom: 7),
        label: Text(
          getLabelText,
        ),
        errorMaxLines: 3,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
        labelStyle: inputTextStyle,
        border: inputBorder,
        focusedBorder: inputBorder,
      ),
    );
  }

  List<TextInputFormatter>? get getTextInputFormatter {
    switch (widget.textFieldType) {
      case TextFieldType.stockUnit:
      case TextFieldType.unit:
      case TextFieldType.quantity:
      case TextFieldType.price:
      case TextFieldType.discountedPrice:
        return [FilteringTextInputFormatter.digitsOnly];
      default:
        return null;
    }
  }

  int? get getMaxLength {
    switch (widget.textFieldType) {
      case TextFieldType.unit:
      case TextFieldType.stockUnit:
      case TextFieldType.quantity:
        return 3;
      case TextFieldType.price:
      case TextFieldType.discountedPrice:
        return 5;
      default:
        return null;
    }
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
        textCapitalization: getTextCapitalization,
        onChanged: widget.onEditing,
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
            hintText: getLabelText),
      ),
    );
  }

  bool get getEnabled {
    switch (widget.textFieldType) {
      case TextFieldType.category:
        return false;
      default:
        return true;
    }
  }

  TextStyle get inputTextStyle {
    return TextStyle(color: Colors.black, fontSize: getWidth(14));
  }

  InputBorder get inputBorder {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(7),
        borderSide: const BorderSide(color: Colors.black, width: 1));
  }

  int? get maxLine {
    switch (widget.textFieldType) {
      case TextFieldType.description:
        return null;
      default:
        return 1;
    }
  }

  bool get getObSecureText {
    return false;
  }

  String get getLabelText {
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

  TextInputType get getKeyboardType {
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

  TextCapitalization get getTextCapitalization {
    return TextCapitalization.sentences;
  }

  String? Function(String?)? get getValidation {
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
