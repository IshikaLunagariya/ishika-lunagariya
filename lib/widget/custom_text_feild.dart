import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/app_color.dart';
import '../utils/size_utils.dart';

class CustomTextFormField extends StatelessWidget {
  final bool password;
  final String? label;
  final Color? labelColor;
  final String? hint;
  final Color? hintColor;
  final String? initialValue;
  final Color? textColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColorBorder;
  final Color? errorBorderColor;
  final Color? errorTextColor;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle style;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final Function? onChanged;
  final InputDecoration? decoration;
  final bool autoFocus;
  final Widget? suffix;
  final Widget? prefix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function? onFieldSubmitted;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final double symetricHorizontalPadding;
  final double symetricVerticalPadding;
  final double labelFontSize;
  final double? radius;
  final Function? onTap;
  final EdgeInsets? contentPadding;
  final bool noBorder;
  final Function()? onEditingComplete;
  final int? maxLines;
  final int? minLines;
  final double? textSize;
  final FontWeight labelFontWeight;
  final bool enabled;
  final int? maxLength;
  final MaxLengthEnforcement maxLengthEnforcement;
  final AutovalidateMode autovalidateMode;
  final bool readOnly;
  final bool showPrefixAlways;
  final bool onlyDigits;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final BoxConstraints? prefixIconConstraints;
  final TextStyle counterStyle;
  final bool enableSuggestions;
  final bool autocorrect;
  static const double borderWidth = 1;
  final bool isEnableToolbarOptions;
  final EdgeInsets? padding;
  final FontWeight? fontWeight;
  final EdgeInsets? scrollPadding;

  const CustomTextFormField({
    this.labelFontSize = 16.0,
    this.label,
    this.labelColor,
    this.hint,
    this.hintColor,
    this.initialValue,
    this.textColor,
    this.enabledBorderColor,
    this.focusedBorderColorBorder,
    this.errorBorderColor,
    this.errorTextColor,
    this.borderColor,
    this.password = false,
    this.inputFormatters,
    this.style = const TextStyle(
      color: Color.fromARGB(255, 60, 60, 60),
      fontWeight: FontWeight.w700,
    ),
    this.controller,
    this.validator,
    this.onChanged,
    this.decoration,
    this.autoFocus = false,
    this.suffix,
    this.radius,
    this.prefix,
    this.keyboardType = TextInputType.multiline,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.textAlign = TextAlign.left,
    this.symetricHorizontalPadding = 30.0,
    this.symetricVerticalPadding = 7.0,
    this.onTap,
    this.contentPadding,
    this.noBorder = false,
    this.onEditingComplete,
    this.maxLines = 1,
    this.minLines,
    this.textSize,
    this.labelFontWeight = FontWeight.normal,
    this.enabled = true,
    this.maxLength,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.readOnly = false,
    this.showPrefixAlways = false,
    this.onlyDigits = false,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    key,
    this.counterStyle = const TextStyle(),
    this.enableSuggestions = true,
    this.autocorrect = true,
    this.isEnableToolbarOptions = true,
    this.padding,
    this.fontWeight,
    this.scrollPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: scrollPadding ?? const EdgeInsets.all(20.0),
      textAlignVertical: TextAlignVertical.center,
      enabled: enabled,
      toolbarOptions: ToolbarOptions(
        selectAll: isEnableToolbarOptions,
        cut: isEnableToolbarOptions,
        copy: isEnableToolbarOptions,
        paste: isEnableToolbarOptions,
      ),
      cursorColor: AppColor.whiteColor,
      textAlign: textAlign,
      focusNode: focusNode,
      autofocus: autoFocus,
      initialValue: initialValue,
      keyboardType: keyboardType,
      autovalidateMode: autovalidateMode,
      inputFormatters: onlyDigits ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))] : inputFormatters,
      style: TextStyle(
        color: textColor ?? Theme.of(context).textTheme.titleLarge!.color,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: textSize ?? SizeUtils.horizontalBlockSize * 3.8,
      ),
      controller: controller,
      validator: validator,
      onChanged: onChanged as void Function(String)?,
      obscureText: password,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted as void Function(String)?,
      onTap: onTap as void Function()?,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        suffix: suffix,
        suffixIcon: suffixIcon,
        suffixIconConstraints: suffixIconConstraints,
        // prefix: showPrefixAlways ? null : prefix,
        prefixIcon: prefix,
        prefixIconConstraints: prefixIconConstraints,
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: SizeUtils.horizontalBlockSize * 3.6,
          color: hintColor ?? const Color(0xFFAAAAAA),
          fontWeight: FontWeight.w400,
        ),
        hintMaxLines: 1,
        focusedErrorBorder: noBorder
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.whiteColor,
                ),
              ),
        enabledBorder: noBorder
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.whiteColor,
                ),
              ),
        focusedBorder: noBorder
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.whiteColor,
                ),
              ),
        errorBorder: noBorder
            ? InputBorder.none
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.whiteColor,
                ),
              ),
        errorStyle: TextStyle(
          color: errorTextColor,
          fontWeight: FontWeight.w500,
        ),
        errorMaxLines: 4,
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColor.whiteColor,
          ),
        ),
      ),
      onEditingComplete: onEditingComplete,
      enableSuggestions: enableSuggestions,
      autocorrect: autocorrect,
    );
  }
}
