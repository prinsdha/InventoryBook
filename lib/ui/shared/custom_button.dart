import 'package:flutter/material.dart';
import 'package:product/core/constant/app_colors.dart';
import 'package:product/core/extension/custom_button_extension.dart';

class ButtonProps {
  double? height;
  double? radius;
  EdgeInsets? margin;
  Widget? child;
  ButtonProps(
      {required this.height, required this.radius, this.margin, this.child});
}

class CustomButton extends StatefulWidget {
  final CustomButtonType type;
  final Function()? onTap;
  final double width;
  final ButtonProps props;
  final double padding;

  CustomButton(
      {Key? key,
      required this.type,
      required this.onTap,
      this.width = 0,
      props,
      this.padding = 0})
      : props = props ?? type.props,
        super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: widget.props.margin,
        width: widget.width == 0 ? double.infinity : widget.width,
        height: widget.props.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(widget.props.radius ?? 50),
          ),
          color: AppColor.kAppBarColor,
        ),
        alignment: Alignment.center,
        child: widget.props.child,
      ),
      // ),
    );
  }
}
