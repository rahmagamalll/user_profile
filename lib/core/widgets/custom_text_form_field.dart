import 'package:flutter/material.dart';
import 'package:user_profile/core/theming/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final bool readOnly;
  final IconButton? prefixIcon;
  final Widget? suffixIcon;
  final BorderRadius borderRadius;
  final TextStyle? hintStyle;
  final int? maxLines;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final Widget? helper;

  const CustomTextFormField({
    super.key,
    this.hintText = '',
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.borderRadius,
    this.hintStyle,
    this.contentPadding,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.readOnly = false,
    this.helper,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        readOnly ? ColorsManager.midLighterGrey : ColorsManager.mediumGrey;

    final focusedBorderColor =
        readOnly ? ColorsManager.midLighterGrey : ColorsManager.primaryColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color:
            readOnly
                ? ColorsManager.midLighterGrey.withOpacity(0.5)
                : Colors.transparent,
      ),
      child: TextFormField(
        maxLines: obscureText ? 1 : maxLines,
        readOnly: readOnly,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        validator: validator,
        cursorColor: ColorsManager.primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(color: ColorsManager.midLighterGrey),
          contentPadding: contentPadding,
          enabledBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: focusedBorderColor, width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: ColorsManager.red, width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: borderRadius,
            borderSide: BorderSide(color: ColorsManager.red, width: 1.2),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          helper: helper,
        ),
      ),
    );
  }
}
