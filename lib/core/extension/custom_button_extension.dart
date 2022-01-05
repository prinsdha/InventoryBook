import 'package:flutter/material.dart';
import 'package:product/core/utils/config.dart';
import 'package:product/ui/shared/custom_button.dart';

enum CustomButtonType { addItem, shareButton, addProduct, update }

extension CustomButtonExtension on CustomButtonType {
  ButtonProps get props {
    Widget buttonCommonChild(String text, IconData iconData) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: Colors.white,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: getWidth(14)))
        ],
      );
    }

    switch (this) {
      case CustomButtonType.addItem:
        return ButtonProps(
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          radius: 50,
          child: const Text(
            "Add Item",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );
      case CustomButtonType.update:
        return ButtonProps(
          height: 45,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          radius: 10,
          child: const Text(
            "Update",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        );

      case CustomButtonType.shareButton:
        return ButtonProps(
            height: 45,
            radius: 50,
            child: buttonCommonChild("Share Store", Icons.share));
      case CustomButtonType.addProduct:
        return ButtonProps(
            height: 45,
            radius: 50,
            child: buttonCommonChild("Add Product", Icons.add_circle));
    }
  }
}
