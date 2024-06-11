import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/presentation/screens/account/widgets/account_form_field_decoration.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';

class ChangePasswordMenu extends StatefulWidget {
  const ChangePasswordMenu({super.key});

  @override
  State<ChangePasswordMenu> createState() => _ChangePasswordMenuState();
}

class _ChangePasswordMenuState extends State<ChangePasswordMenu> {
  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  final passwordFieldFocusNode = FocusNode();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void toggleObscuredPassword() {
    setState(() {
      hidePassword = !hidePassword;
      if (!passwordFieldFocusNode.hasPrimaryFocus) {
        passwordFieldFocusNode.canRequestFocus = false;
      }
    });
  }

  void toggleObscuredConfirm() {
    setState(() {
      hideConfirmPassword = !hideConfirmPassword;
      if (!passwordFieldFocusNode.hasPrimaryFocus) {
        passwordFieldFocusNode.canRequestFocus = false;
      }
    });
  }

  String? validatePassword(String? value) {
    final RegExp passwordRegex = RegExp(
      r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$',
    );

    if (value == null || value.isEmpty) {
      return 'You must enter a password.';
    }

    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain at least 8 characters';
    }

    return null;
  }

  String? validateConfirm(String? value) {
    if (value != passwordController.text) {
      return 'Password confirmation must be equal';
    }
    return null;
  }

  _pressSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      await context.read<UpdateBloc>().onSubmitUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    final formDeco = AccountFormFieldDecoration();
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Change your password',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GymnasticTextFormField(
                style: formDeco.getTextStyle(context),
                controller: passwordController,
                obscureText: hidePassword,
                validator: validatePassword,
                onChanged: context.read<UpdateBloc>().passwordChanged,
                decoration: formDeco.getDecorationPassword(
                    context,
                    'Password',
                    GestureDetector(
                      onTap: toggleObscuredPassword,
                      child: Icon(
                        hidePassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                        color: isDark
                            ? const Color(0xffcdcdcd)
                            : const Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GymnasticTextFormField(
                style: formDeco.getTextStyle(context),
                controller: confirmPasswordController,
                obscureText: hideConfirmPassword,
                validator: validateConfirm,
                //onChanged: context.read<UpdateBloc>().passwordChanged,
                decoration: formDeco.getDecorationPassword(
                    context,
                    'Confirm Pasword',
                    GestureDetector(
                      onTap: toggleObscuredConfirm,
                      child: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                        color: isDark
                            ? const Color(0xffcdcdcd)
                            : const Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    )),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 300,
              child: FilledButton(
                onPressed: _pressSubmit,
                child: const Text('Change Password',
                    style: TextStyle(fontSize: 20)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
