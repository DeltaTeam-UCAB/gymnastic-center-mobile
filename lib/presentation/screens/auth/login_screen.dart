import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/auth/login/login_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/user/api_user_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/circle_masked_background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_input_decoration.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LocalStorageService localStorageService = LocalStorageService();
    return BlocProvider(
        create: (context) => LoginBloc(
                userRespository: UserRepositoryImpl(
              userDatasource: APIUserDatasource(localStorageService),
              keyValueStorage: localStorageService,
            )),
        child: const _LoginScreen());
  }
}

class _LoginScreen extends StatefulWidget {
  const _LoginScreen();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<_LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _hidePassword = true;

  final _formKey = GlobalKey<FormState>();

  final passwordFieldFocusNode = FocusNode();

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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'You must enter a password.';
    }
    return null;
  }

  void _pressSubmit() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().submit();
    }
  }

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    // final formStatus = context.watch<LoginBloc>().state.formStatus;
    bool isDarkMode = context.watch<ThemesBloc>().isDarkMode;
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.formStatus != current.formStatus,
      listener: (context, state) {
        if (state.formStatus == LoginFormStatus.invalid &&
            state.errorMessage.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage)),
          );
          return;
        }

        if (state.formStatus == LoginFormStatus.valid) {
          context.go('/home/0');
          return;
        }
      },
      builder: (context, state) {
        return _layout([
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, 0, 0, MediaQuery.of(context).size.height * 0.0628),
            child: Image.asset(
              'assets/icon/logoApp_white.png',
              height: MediaQuery.of(context).size.height * 0.227,
            ),
          ),
          _textFieldPadding(
              Text('Login',
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black)),
              top: false),
          _textFieldPadding(
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: GymnasticTextFormField(
                    onChanged: (value) =>
                        context.read<LoginBloc>().changeEmail(value),
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
                      prefixIconColor:
                          isDarkMode ? Colors.white : const Color(0x7c8d95af),
                    ),
                  )),
              bottom: false),
          _textFieldPadding(
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  child: GymnasticTextFormField(
                    onChanged: (value) =>
                        context.read<LoginBloc>().changePassword(value),
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
          const SizedBox(
            height: 15,
          ),
          Row(children: [
            Expanded(
                child: FilledButton(
              onPressed: state.formStatus != LoginFormStatus.posting
                  ? _pressSubmit
                  : null,
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
                  child: (state.formStatus == LoginFormStatus.posting)
                      ? const CircularProgressIndicator()
                      : GradientText(
                          textWidget: const Text('Login',
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
          ]),
          const SizedBox(
            height: 15,
          ),
          Text("Forgot your password?",
              style: TextStyle(
                  color: isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(255, 88, 27, 173),
                  fontSize: 16.0)),
          const SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            Text("Don't have an account?",
                style: TextStyle(
                    color: isDarkMode
                        ? Colors.white
                        : const Color.fromARGB(176, 0, 0, 0),
                    fontSize: 16.0)),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () => context.go('/register'),
              child: Text("Sign up",
                  style: TextStyle(
                      color: isDarkMode
                          ? Colors.white
                          : const Color.fromARGB(255, 88, 27, 173),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold)),
            ),
          ])
        ]);
      },
    );
  }

  Widget _layout(List<Widget> children) {
    double circleRadius = MediaQuery.of(context).size.height *
        0.671; // ? Aqui puedo cambiar el radio
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
                backgroundContent: SvgPicture.asset(
                  'assets/splash/splash-screen-bg.svg',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  alignment: Alignment.topLeft,
                ),
                circleMaskContent: Container(
                  alignment: Alignment.center,
                  height: double.infinity,
                  child: Container(color: colors.background),
                ),
                circlePosition: Offset(MediaQuery.of(context).size.width / 2,
                    MediaQuery.of(context).size.height * 0.36 + circleRadius),
                circleRadius: circleRadius,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        horizontalPadding,
                        0,
                        horizontalPadding,
                        MediaQuery.of(context).size.height * 0.064),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: children,
                      ),
                    )),
              ),
            ),
          ),
        ));
  }
}
