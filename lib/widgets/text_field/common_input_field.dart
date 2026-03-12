import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CommonInputField extends TextFormField {
  final String? header;
  final String? hintText;
  final Function(String?)? onTextChange;
  final InputDecoration? inputDecoration;
  final double height;
  final bool isOptional;
  final bool willShowCounter;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final Color? fillColor;

  CommonInputField({
    super.controller,
    super.autofocus,
    super.focusNode,
    super.style,
    this.header,
    this.hintText,
    this.onTextChange,
    this.height = AppConstants.valueDouble50,
    this.willShowCounter = false,
    super.textInputAction = TextInputAction.next,
    this.isOptional = false,
    this.inputDecoration,
    this.hintStyle,
    this.contentPadding,
    this.fillColor,
    super.textDirection,
  }) : super(
          onChanged: onTextChange != null ? (s) => onTextChange(s) : null,
          decoration: inputDecoration ??
              InputDecoration(
                hintText: hintText,
                counterText: willShowCounter ? null : "",
                hintStyle: hintStyle,
                filled: fillColor != null,
                fillColor: fillColor,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              ),
        );
}
