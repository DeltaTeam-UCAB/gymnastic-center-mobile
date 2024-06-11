import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_input_decoration.dart';

class AccountFormFieldDecoration {
  GymnasticTextInputDecoration getDecoration(
      BuildContext context, String label) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    final enabledBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final focusedBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final errorBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final focusedErrorBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final floatingLabelStyle = TextStyle(
        fontSize: 17.78,
        color: isDark ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.6));
    final labelStyle = TextStyle(
        fontSize: 17.78,
        color: isDark ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.6));
    final hintStyle = TextStyle(
        fontSize: 16,
        color: isDark
            ? const Color(0xffcdcdcd)
            : const Color.fromRGBO(0, 0, 0, 0.6));

    return GymnasticTextInputDecoration(
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: focusedErrorBorder,
        floatingLabelStyle: floatingLabelStyle,
        labelStyle: labelStyle,
        hintStyle: hintStyle,
        labelText: label);
  }

  GymnasticTextInputDecoration getDecorationPassword(
      BuildContext context, String label, GestureDetector button) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    final enabledBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final focusedBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final errorBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final focusedErrorBorder = OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(300)),
        borderSide: BorderSide(
          color: isDark
              ? const Color(0xffcdcdcd)
              : const Color.fromRGBO(0, 0, 0, 0.6),
        ));
    final floatingLabelStyle = TextStyle(
        fontSize: 17.78,
        color: isDark ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.6));
    final labelStyle = TextStyle(
        fontSize: 17.78,
        color: isDark ? Colors.white : const Color.fromRGBO(0, 0, 0, 0.6));
    final hintStyle = TextStyle(
        fontSize: 16,
        color: isDark
            ? const Color(0xffcdcdcd)
            : const Color.fromRGBO(0, 0, 0, 0.6));

    return GymnasticTextInputDecoration(
      enabledBorder: enabledBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: focusedErrorBorder,
      floatingLabelStyle: floatingLabelStyle,
      labelStyle: labelStyle,
      hintStyle: hintStyle,
      labelText: label,
      hintText: 'Password',
      suffixIconColor: const Color(0xffc8ccd9),
      suffixIcon: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
        child: button,
      ),
    );
  }

  TextStyle getTextStyle(BuildContext context) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    return TextStyle(
        fontSize: 16,
        color: isDark
            ? const Color(0xffcdcdcd)
            : const Color.fromRGBO(0, 0, 0, 0.6));
  }
}
