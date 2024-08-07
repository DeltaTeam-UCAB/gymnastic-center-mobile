import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/auth/recover_password/recover_password_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/ellipse_masked_background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_input_decoration.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ResetPasswordScreen();
  }
}

class _ResetPasswordScreen extends StatefulWidget {
  const _ResetPasswordScreen();

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<_ResetPasswordScreen> {
  late TextEditingController _emailController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  String? _validateEmail(String? value) {
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (value == null || value.isEmpty) {
      return 'You must enter an email.';
    }

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email.';
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

  _pressSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      await context.read<RecoverPasswordBloc>().sendCode();
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

          if (state.formStatus == RecoverPasswordFormStatus.sent) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.push('/password/verify');
          }
        },
        builder: (context, state) => _layout([
              _textFieldPadding(
                  Text(
                    'Reset password',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color:
                          isDarkMode ? Colors.white : const Color(0xff222222),
                      fontSize: 28,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  top: false),
              _textFieldPadding(
                  Text(
                    'Please enter your email address. You will get a link to create new password by email.',
                    style: TextStyle(
                      color:
                          isDarkMode ? Colors.white : const Color(0xff677294),
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  top: false),
              _textFieldPadding(
                  SizedBox(
                      height: MediaQuery.of(context).size.height * 0.09,
                      child: GymnasticTextFormField(
                        onChanged: (value) => context
                            .read<RecoverPasswordBloc>()
                            .changeEmail(value),
                        controller: _emailController,
                        validator: _validateEmail,
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
                          labelText: 'Email',
                          hintText: 'youremail@example.com',
                          prefixIcon: const Icon(Icons.email),
                          prefixIconColor: isDarkMode
                              ? Colors.white
                              : const Color(0x7c8d95af),
                        ),
                      )),
                  bottom: false),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, 0, 0, MediaQuery.of(context).size.height * 0.3),
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
                                  textWidget: const Text(
                                      'Send verification code',
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
    double horizontalPadding = MediaQuery.of(context).size.width * 0.0444;
    ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    child: EllipseMaskedBackground(
                      ellipseMaskContent: SizedBox.expand(
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
                              ),
                              Positioned(
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                  onPressed: context.pop,
                                ),
                              )
                            ],
                          )),
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
