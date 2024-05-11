import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/auth/register/register_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/infrastructure/core/constants/environment.dart';
import 'package:gymnastic_center/infrastructure/core/http/dio_http.dart';
import 'package:gymnastic_center/infrastructure/datasources/user/user_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/circle_masked_background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/checkbox_form_field.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_input_decoration.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(
        UserHttpRepository(
            keyValueStorage: LocalStorageService(),
            http: DioHttpHandler(Environment.backendApi)),
      ),
      child: const _RegisterForm(),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<_RegisterForm> {
  late TextEditingController _fullNameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  bool _hidePassword = true;

  final _formKey = GlobalKey<FormState>();

  final passwordFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  void _toggleObscured() {
    setState(() {
      _hidePassword = !_hidePassword;
      if (!passwordFieldFocusNode.hasPrimaryFocus) {
        passwordFieldFocusNode.canRequestFocus = false;
      }
    });
  }

  Widget _textFieldPadding(Widget child,
      {bool bottom = true, bool top = true}) {
    double paddingValue = MediaQuery.of(context).size.height * 0.022;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            0, top ? paddingValue : 0, 0, bottom ? paddingValue : 0),
        child: child);
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

  String? _validatePhone(String? value) {
    // RegExp phoneRegex = RegExp(r'^[+]{1}[(]?[0-9]{1,4}[)]?[-\s0-9]*$');

    if (value == null || value.isEmpty) {
      return 'You must enter a phone number.';
    }

    // if (!phoneRegex.hasMatch(value)) {
    //   return 'Please enter a valid phone number.';
    // }

    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'You must enter your name.';
    }

    if (value.length < 7) {
      return 'Name must be at least 7 characters long.';
    }

    return null;
  }

  String? _validatePassword(String? value) {
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

  _pressSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      print('Form is valid!');
      await context.read<RegisterBloc>().obSubmitRegister();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.registerFormStatus == RegisterFormStatus.invalid) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
        }

        if (state.registerFormStatus == RegisterFormStatus.valid) {
          context.go('/login');
        }

        if (state.registerFormStatus == RegisterFormStatus.valid) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Register success!')),
          );
        }
      },
      child: _layout([
        _textFieldPadding(
            const Text('Sign up',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            top: false),
        _textFieldPadding(
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: GymnasticTextFormField(
                  controller: _fullNameController,
                  onChanged: context.read<RegisterBloc>().fullnameChanged,
                  validator: _validateName,
                  decoration: const GymnasticTextInputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Your name here',
                  ),
                )),
            bottom: false),
        _textFieldPadding(
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: GymnasticTextFormField(
                  controller: _emailController,
                  validator: _validateEmail,
                  onChanged: context.read<RegisterBloc>().emailChanged,
                  decoration: const GymnasticTextInputDecoration(
                    labelText: 'Email',
                    hintText: 'youremail@example.com',
                    prefixIconColor: Color(0x7bc8ccd9),
                    prefixIcon: Icon(Icons.email),
                  ),
                )),
            bottom: false),
        _textFieldPadding(
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: GymnasticTextFormField(
                  controller: _phoneController,
                  validator: _validatePhone,
                  decoration: const GymnasticTextInputDecoration(
                    labelText: 'Phone',
                    hintText: '+088031420698',
                  ),
                )),
            bottom: false),
        _textFieldPadding(
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
                child: GymnasticTextFormField(
                  controller: _passwordController,
                  obscureText: _hidePassword,
                  validator: _validatePassword,
                  onChanged: context.read<RegisterBloc>().passwordChanged,
                  decoration: GymnasticTextInputDecoration(
                    labelText: 'Password',
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
                0, 0, 0, MediaQuery.of(context).size.height * 0.0449),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.0294,
              child: CheckboxFormField(
                title: const Text('Yes! Agree to all Terms and Conditions',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
                validator: (value) {
                  if (value == null || !value) {
                    return 'You must agree to all Terms and Conditions.';
                  }

                  return null;
                },
              ),
            )),
        Row(children: [
          Expanded(
              child: FilledButton(
            onPressed: context.read<RegisterBloc>().state.registerFormStatus ==
                    RegisterFormStatus.posting
                ? null
                : _pressSubmit,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(),
            ),
            child: Padding(
                padding: EdgeInsets.fromLTRB(
                    0,
                    MediaQuery.of(context).size.height * 0.0192,
                    0,
                    MediaQuery.of(context).size.height * 0.0192),
                child: const GradientText(
                    textWidget: Text('Sign up', style: TextStyle(fontSize: 20)),
                    gradient: LinearGradient(colors: [
                      Color(0xff4f14a0),
                      Color(0xff8066ff),
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight))),
          ))
        ]),
      ]),
    );
  }

  Widget _layout(List<Widget> children) {
    double circleRadius = MediaQuery.of(context).size.height * 0.871;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.0444;
    bool isDarkMode = context.watch<ThemesBloc>().isDarkMode;
    ColorScheme colors = Theme.of(context).colorScheme;

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top,
                    child: CircleMaskedBackground(
                      backgroundContent: SizedBox.expand(
                          child: Container(
                        color: colors.background,
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0,
                              MediaQuery.of(context).size.height * 0.0628,
                              0,
                              0),
                          child: Image.asset(
                            'assets/icon/logoApp_${isDarkMode ? 'white' : 'purple'}.png',
                            height: MediaQuery.of(context).size.height * 0.127,
                          ),
                        ),
                      )),
                      circleMaskContent: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        child: SvgPicture.asset(
                          'assets/splash/splash-screen-bg.svg',
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.height,
                          alignment: Alignment.topLeft,
                        ),
                      ),
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
