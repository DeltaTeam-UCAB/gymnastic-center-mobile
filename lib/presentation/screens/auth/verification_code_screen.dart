import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gymnastic_center/application/auth/recover_password/recover_password_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/user/api_user_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/circle_masked_background.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RecoverPasswordBloc(
          userRespository: UserRepositoryImpl(
        userDatasource: APIUserDatasource(),
        keyValueStorage: LocalStorageService(),
      )),
      child: const _VerificationCodeScreen(),
    );
  }
}

class _VerificationCodeScreen extends StatefulWidget {
  const _VerificationCodeScreen({super.key});

  @override
  _VerificationCodeScreenState createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<_VerificationCodeScreen> {
  late TextEditingController _firstDigit;
  late TextEditingController _secondDigit;
  late TextEditingController _thirdDigit;
  late TextEditingController _fourthDigit;

  final _formKey = GlobalKey<FormState>();

  final _firstDigitFocusNode = FocusNode();
  final _secondDigitFocusNode = FocusNode();
  final _thirdDigitFocusNode = FocusNode();
  final _fourthDigitFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _firstDigit = TextEditingController();
    _secondDigit = TextEditingController();
    _thirdDigit = TextEditingController();
    _fourthDigit = TextEditingController();

    _firstDigit.text = '\u200b';
    _secondDigit.text = '\u200b';
    _thirdDigit.text = '\u200b';
    _fourthDigit.text = '\u200b';
  }

  void _onCodeChanged() {
    String firstDigit =
        _firstDigit.text.length > 1 ? _firstDigit.text.substring(1) : '';
    String secondDigit =
        _secondDigit.text.length > 1 ? _secondDigit.text.substring(1) : '';
    String thirdDigit =
        _thirdDigit.text.length > 1 ? _thirdDigit.text.substring(1) : '';
    String fourthDigit =
        _fourthDigit.text.length > 1 ? _fourthDigit.text.substring(1) : '';

    String code = firstDigit + secondDigit + thirdDigit + fourthDigit;

    context.read<RecoverPasswordBloc>().changeCode(code);

    if (code.length == 4) {
      context.read<RecoverPasswordBloc>().validateCode();
    }
  }

  Widget _textFieldPadding(Widget child,
      {bool bottom = true, bool top = true}) {
    double paddingValue = MediaQuery.of(context).size.height * 0.022;
    return Padding(
        padding: EdgeInsets.fromLTRB(
            0, top ? paddingValue : 0, 0, bottom ? paddingValue : 0),
        child: child);
  }

  Widget _digitTextField(TextEditingController controller, FocusNode focusNode,
      {FocusNode? next, FocusNode? previous}) {
    double digitTextFieldSize = MediaQuery.of(context).size.width / 6;
    double digitTextFieldFontSize = MediaQuery.of(context).size.width * 0.072;
    double digitTextFieldLineHeight = 1.072;
    return _textFieldPadding(SizedBox(
        height: digitTextFieldSize,
        width: digitTextFieldSize,
        child: TextField(
          keyboardType: TextInputType.number,
          focusNode: focusNode,
          onChanged: (value) {
            if (value.isEmpty) {
              if (previous != null) previous.requestFocus();
              controller.text = '\u200b';
            }
            if (value.length > 1) {
              if (next != null) next.requestFocus();
              _onCodeChanged();
            }
          },
          maxLength: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: digitTextFieldFontSize,
              fontWeight: FontWeight.w700,
              color: const Color(0xff4f14a0),
              height: digitTextFieldLineHeight),
          controller: controller,
          decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xffffffff))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xffffffff))),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(color: Color(0xffffffff))),
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            hoverColor: Colors.white,
            counterText: '',
          ),
        )));
  }

  _pressSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      await context.read<RecoverPasswordBloc>().validateCode();
    }
  }

  @override
  Widget build(BuildContext context) {
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

          if (state.formStatus == RecoverPasswordFormStatus.valid) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            context.go('/password/create');
          }
        },
        builder: (context, state) => _layout([
              _textFieldPadding(
                  const Text('Verification Code',
                      style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  top: false),
              _textFieldPadding(
                  const Text(
                    'Please type the verification code sent to youremail@gmail.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  top: false),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _digitTextField(_firstDigit, _firstDigitFocusNode,
                    next: _secondDigitFocusNode),
                _digitTextField(_secondDigit, _secondDigitFocusNode,
                    next: _thirdDigitFocusNode, previous: _firstDigitFocusNode),
                _digitTextField(_thirdDigit, _thirdDigitFocusNode,
                    next: _fourthDigitFocusNode,
                    previous: _secondDigitFocusNode),
                _digitTextField(_fourthDigit, _fourthDigitFocusNode,
                    previous: _thirdDigitFocusNode),
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("I didn't receive a code!",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        context.read<RecoverPasswordBloc>().sendCode();
                      },
                      child: const Text("Please resend",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                  ]),
            ]));
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: children,
                              ))),
                    )))));
  }
}
