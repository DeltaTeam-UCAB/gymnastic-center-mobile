import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/auth/recover_password/recover_password_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/circle_masked_background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_input_decoration.dart';

class CreatePasswordScreen extends StatelessWidget {
  const CreatePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _CreatePasswordScreen();
  }
}

class _CreatePasswordScreen extends StatefulWidget {
  const _CreatePasswordScreen({super.key});

  @override
  _CreatePasswordScreenState createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<_CreatePasswordScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _repeatPasswordController;

  bool _hidePassword = true;

  final _formKey = GlobalKey<FormState>();

  final passwordFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'You must enter a password.';
    }
    return null;
  }

  String? _validateRepeatPassword(String? value) {
    if (value != _passwordController.text) {
      return 'Passwords must match.';
    }
    return null;
  }

  Widget _textFieldPadding(Widget child,
      {bool bottom = true, bool top = true}) {
    double paddingValue = MediaQuery.of(context).size.height * 0.022;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            0, top ? paddingValue : 0, 0, bottom ? paddingValue : 0),
        child: child);
  }

  void _toggleObscured() {
    setState(() {
      _hidePassword = !_hidePassword;
      if (!passwordFieldFocusNode.hasPrimaryFocus) {
        passwordFieldFocusNode.canRequestFocus = false;
      }
    });
  }

  _pressSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      await context.read<RecoverPasswordBloc>().submitPasswordChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = context.watch<ThemesBloc>().isDarkMode;

    return BlocConsumer<RecoverPasswordBloc, RecoverPasswordState>(
        listenWhen: (previous, current) =>
            previous.formStatus != current.formStatus,
        listener: (context, state) {
          if (state.formStatus == RecoverPasswordFormStatus.invalid) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }

          if (state.formStatus == RecoverPasswordFormStatus.finished) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.go('/password/changed');
          }
        },
        builder: (context, state) => _layout([
              _textFieldPadding(
                  Text(
                    'Create password',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: isDarkMode ? Colors.white : Color(0xff222222),
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  top: false),
              _textFieldPadding(
                  Text(
                    'Create a new password and please never share it with anyone for safe use.',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Color(0xff677294),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  top: false),
              _textFieldPadding(
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                      child: GymnasticTextFormField(
                        onChanged: (value) => {
                          context
                              .read<RecoverPasswordBloc>()
                              .changePassword(value)
                        },
                        controller: _passwordController,
                        obscureText: _hidePassword,
                        validator: _validatePassword,
                        decoration: GymnasticTextInputDecoration(
                          floatingLabelStyle: TextStyle(
                              fontSize: 17.78,
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff677294)),
                          labelStyle: TextStyle(
                              fontSize: 17.78,
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff677294)),
                          labelText: 'New password',
                          hintText: 'Password',
                          suffixIconColor: const Color(0xffc8ccd9),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _hidePassword
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      )),
                  bottom: false),
              _textFieldPadding(
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                      child: GymnasticTextFormField(
                        onChanged: (value) => {},
                        controller: _repeatPasswordController,
                        obscureText: _hidePassword,
                        validator: _validateRepeatPassword,
                        decoration: GymnasticTextInputDecoration(
                          floatingLabelStyle: TextStyle(
                              fontSize: 17.78,
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff677294)),
                          labelStyle: TextStyle(
                              fontSize: 17.78,
                              color: isDarkMode
                                  ? Colors.white
                                  : const Color(0xff677294)),
                          labelText: 'Confirm password',
                          hintText: 'Password',
                          suffixIconColor: const Color(0xffc8ccd9),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                            child: GestureDetector(
                              onTap: _toggleObscured,
                              child: Icon(
                                _hidePassword
                                    ? Icons.visibility_rounded
                                    : Icons.visibility_off_rounded,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                      )),
                  bottom: false),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.23),
                  child: Row(children: [
                    Expanded(
                        child: FilledButton(
                      onPressed:
                          state.formStatus == RecoverPasswordFormStatus.posting
                              ? null
                              : _pressSubmit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : const Color.fromARGB(255, 88, 27, 173),
                        padding: const EdgeInsets.symmetric(),
                      ),
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              MediaQuery.of(context).size.height * 0.0192,
                              0,
                              MediaQuery.of(context).size.height * 0.0192),
                          child: state.formStatus ==
                                  RecoverPasswordFormStatus.posting
                              ? const CircularProgressIndicator()
                              : GradientText(
                                  textWidget: const Text('Update password',
                                      style: TextStyle(fontSize: 20)),
                                  gradient: LinearGradient(
                                      colors: isDarkMode
                                          ? ([
                                              const Color(0xff4f14a0),
                                              const Color(0xff8066ff),
                                            ])
                                          : ([
                                              Colors.white,
                                              Colors.white,
                                            ]),
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight))),
                    )),
                  ]))
            ]));
  }

  Widget _layout(List<Widget> children) {
    double circleRadius = MediaQuery.of(context).size.height * 0.871;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.0444;
    ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    child: CircleMaskedBackground(
                      circleMaskContent: SizedBox.expand(
                          child: Container(
                        color: colors.background,
                        alignment: Alignment.topCenter,
                      )),
                      backgroundContent: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          child: Stack(
                            children: [
                              SvgPicture.asset(
                                'assets/splash/splash-screen-bg.svg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height,
                                alignment: Alignment.topLeft,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    MediaQuery.of(context).size.height * 0.17,
                                    MediaQuery.of(context).size.height * 0.0628,
                                    0,
                                    0),
                                child: Image.asset(
                                  'assets/icon/logoApp_white.png',
                                  height: MediaQuery.of(context).size.height *
                                      0.127,
                                ),
                              )
                            ],
                          )),
                      circlePosition: Offset(
                          MediaQuery.of(context).size.width / 2,
                          MediaQuery.of(context).size.height * 0.21 +
                              circleRadius),
                      circleRadius: circleRadius,
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              horizontalPadding,
                              0,
                              horizontalPadding,
                              MediaQuery.of(context).size.height * 0.044),
                          child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: children,
                              ))),
                    )))));
  }
}
