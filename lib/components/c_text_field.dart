import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_text_theme.dart';
import 'app_colors.dart';

class CTextField extends StatelessWidget {
  final bool readOnly;
  final double? height;
  final int? maxLength;
  final int? maxLine;
  final String labelText;
  final String? helperText;
  final Color? fillColor;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? suffixText;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool? obscureText;

  const CTextField(
      {Key? key,
      this.readOnly = false,
      required this.labelText,
      this.prefixIcon,
      this.helperText,
      this.focusNode,
      this.onTap,
      this.suffixText,
      this.suffixIcon,
      this.fillColor,
      this.inputFormatters,
      this.controller,
      this.validator,
      this.height,
      this.maxLength,
      this.maxLine,
      this.keyboardType,
      this.textInputAction,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: Fix the design
    return SizedBox(
      height: height,
      child: TextFormField(
        maxLines: maxLine,
        obscureText: obscureText ?? false,
        maxLength: maxLength,
        onTap: onTap,
        validator: validator,
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        keyboardType: keyboardType,
        scrollPhysics: const BouncingScrollPhysics(
          parent: FixedExtentScrollPhysics(),
        ),
        textInputAction: textInputAction,
        inputFormatters: inputFormatters,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          counterText: '',
          isDense: true,
          hintText: labelText,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15),
          hintStyle: TextThemeX.text14.copyWith(
            fontWeight: FontWeight.w400,
            fontFamily: getRobotoFontFamily,
            color: getHintColor,
          ),
          filled: true,
          fillColor: fillColor ?? getColor21,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            maxWidth: 40,
            minHeight: 40,
            minWidth: 40,
            maxHeight: 40,
          ),
          suffixText: suffixText,
          helperText: helperText,
          helperStyle: TextThemeX.text10.copyWith(color: getPrimaryColor),
          suffixStyle: TextThemeX.text17.copyWith(
            fontWeight: FontWeight.w600,
            fontFamily: getRobotoFontFamily,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: const Color(0xff505050).withOpacity(.33),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: getPrimaryColor.withOpacity(.67),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              width: 1,
              color: lightRed,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(
              width: 1,
              color: lightRed.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
