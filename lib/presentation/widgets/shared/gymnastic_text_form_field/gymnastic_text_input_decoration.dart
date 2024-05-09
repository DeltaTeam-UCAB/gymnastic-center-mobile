import 'package:flutter/material.dart';

class GymnasticTextInputDecoration extends InputDecoration {
  const GymnasticTextInputDecoration({
    super.alignLabelWithHint,
    super.border,
    super.constraints,
    super.counter,
    super.counterStyle,
    super.counterText,
    super.disabledBorder,
    super.enabled,
    super.error,
    super.errorMaxLines,
    super.errorStyle,
    super.errorText,
    super.fillColor,
    super.filled,
    super.floatingLabelAlignment,
    super.focusColor,
    super.helperMaxLines,
    super.helperStyle,
    super.helperText,
    super.hintFadeDuration,
    super.hintMaxLines,
    super.hintText,
    super.hintTextDirection,
    super.hoverColor,
    super.icon,
    super.iconColor,
    super.isCollapsed,
    super.isDense,
    super.label,
    super.labelText,
    super.prefix,
    super.prefixIcon,
    super.prefixIconColor,
    super.prefixIconConstraints,
    super.prefixStyle,
    super.prefixText,
    super.semanticCounterText,
    super.suffix,
    super.suffixIcon,
    super.suffixIconColor,
    super.suffixIconConstraints,
    super.suffixStyle,
    super.suffixText,
    super.floatingLabelBehavior = FloatingLabelBehavior.always,
    super.contentPadding = const EdgeInsets.fromLTRB(36, 15, 10, 15),
    super.enabledBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: Color(0xffcdcdcd),
        )),
    super.focusedBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: Color(0xffcdcdcd),
        )),
    super.errorBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: Color(0xffcdcdcd),
        )),
    super.focusedErrorBorder = const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: Color(0xffcdcdcd),
        )),
    super.floatingLabelStyle =
        const TextStyle(fontSize: 17.78, color: Colors.white),
    super.labelStyle = const TextStyle(fontSize: 17.78, color: Colors.white),
    super.hintStyle = const TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
  });
}
