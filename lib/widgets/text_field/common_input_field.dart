
import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';

class CommonInputField extends TextFormField{
  final String? header;
  final String? hintText;
  final Function(String?)? onTextChange;
  final InputDecoration? inputDecoration;
  final bool willShowCounter;
  final Function(String?)? customValidator;
  final double height;
  final bool isOptional;
  final TextStyle? hintStyle;
  final Widget? prefix, suffix, prefixIcon, suffixIcon;
  final EdgeInsets? contentPadding;
  final Color? fillColor;
  final String? emptyErrorMessage;
  CommonInputField(
      {this.header,
        this.hintText,
        this.onTextChange,
        this.prefix,
        this.suffix,
        this.prefixIcon,
        this.suffixIcon,
        this.customValidator,
        this.height = AppConstants.valueDoubleSkt50,
        super.autocorrect,
        super.autofillHints,
        super.autofocus,
        super.autovalidateMode = AutovalidateMode.onUserInteraction,
        super.buildCounter,
        super.canRequestFocus,
        super.controller,
        super.cursorColor,
        super.cursorHeight,
        super.cursorOpacityAnimates,
        super.cursorRadius,
        super.cursorWidth,
        super.dragStartBehavior,
        super.enableIMEPersonalizedLearning,
        super.enableInteractiveSelection,
        super.enableSuggestions,
        super.enabled,
        super.expands,
        super.focusNode,
        super.initialValue,
        super.inputFormatters,
        super.scribbleEnabled,
        super.key,
        super.keyboardAppearance,
        super.keyboardType,
        super.magnifierConfiguration,
        super.maxLength = AppConstants.valueIntSkt50,
        super.maxLengthEnforcement,
        super.maxLines,
        super.minLines,
        super.mouseCursor,
        super.obscureText,
        super.obscuringCharacter,
        super.onAppPrivateCommand,
        super.onEditingComplete,
        super.onFieldSubmitted,
        super.onSaved,
        super.onTap,
        super.readOnly,
        super.restorationId,
        super.scrollController,
        super.style,
        super.textAlign,
        super.textInputAction = TextInputAction.next,
        this.isOptional = false,
        this.inputDecoration,
        this.willShowCounter = false,
        this.hintStyle,
        this.contentPadding,
        this.fillColor,
        super.textDirection,
        this.emptyErrorMessage,
      })
      : super(
    onChanged: onTextChange != null ? (s) => onTextChange(s) : null,
    decoration: inputDecoration ??
        InputDecoration(
          hintText: hintText,
          counterText: willShowCounter ? null : "",
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintStyle: hintStyle,
          filled: fillColor != null,
          fillColor: fillColor,
          prefix: prefix,
          suffix: suffix,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        ),
  );
}