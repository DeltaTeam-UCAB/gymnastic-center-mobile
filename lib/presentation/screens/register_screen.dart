import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/circle_masked_background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/custom_button.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _fullNameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _acceptTermsAndConditions = false;

  bool _hidePassword = true;

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

  @override
  Widget build(BuildContext context) {
    return _layout([
      Padding(
        padding: EdgeInsets.fromLTRB(
            0, 0, 0, MediaQuery.of(context).size.height * 0.0628),
        child: Image.asset(
          'assets/icon/logoApp_purple.png',
          height: MediaQuery.of(context).size.height * 0.127,
        ),
      ),
      _textFieldPadding(
          const Text('Sign up',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          top: false),
      _textFieldPadding(TextField(
        controller: _fullNameController,
        style: const TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.fromLTRB(36, 15, 10, 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color(0xffcdcdcd),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color(0xffcdcdcd),
              )),
          floatingLabelStyle: TextStyle(fontSize: 17.78, color: Colors.white),
          labelStyle: TextStyle(fontSize: 17.78, color: Colors.white),
          hintStyle: TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
          labelText: 'Full Name',
          hintText: 'Your name here',
        ),
      )),
      _textFieldPadding(TextField(
        controller: _emailController,
        style: const TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.fromLTRB(36, 15, 10, 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color(0xffcdcdcd),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color(0xffcdcdcd),
              )),
          floatingLabelStyle: TextStyle(fontSize: 17.78, color: Colors.white),
          labelStyle: TextStyle(fontSize: 17.78, color: Colors.white),
          hintStyle: TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
          labelText: 'Email',
          hintText: 'youremail@example.com',
          prefixIconColor: Color(0x7bc8ccd9),
          prefixIcon: Icon(Icons.email),
        ),
      )),
      _textFieldPadding(TextField(
        controller: _phoneController,
        style: const TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.fromLTRB(36, 15, 10, 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color(0xffcdcdcd),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color(0xffcdcdcd),
              )),
          floatingLabelStyle: TextStyle(fontSize: 17.78, color: Colors.white),
          labelStyle: TextStyle(fontSize: 17.78, color: Colors.white),
          hintStyle: TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
          labelText: 'Phone',
          hintText: '+088031420698',
        ),
      )),
      _textFieldPadding(
          TextField(
            controller: _passwordController,
            obscureText: _hidePassword,
            style: const TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              contentPadding: const EdgeInsets.fromLTRB(36, 15, 10, 15),
              enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(300)),
                  borderSide: BorderSide(
                    color: Color(0xffcdcdcd),
                  )),
              focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(300)),
                  borderSide: BorderSide(
                    color: Color(0xffcdcdcd),
                  )),
              floatingLabelStyle:
                  const TextStyle(fontSize: 17.78, color: Colors.white),
              labelStyle: const TextStyle(fontSize: 17.78, color: Colors.white),
              hintStyle:
                  const TextStyle(fontSize: 16, color: Color(0xffcdcdcd)),
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
          ),
          bottom: false),
      Padding(
          padding: EdgeInsets.fromLTRB(
              0,
              MediaQuery.of(context).size.height * 0.0282,
              0,
              MediaQuery.of(context).size.height * 0.0449),
          child: Row(
            children: [
              Checkbox(
                  value: _acceptTermsAndConditions,
                  onChanged: (bool? value) {
                    setState(() {
                      _acceptTermsAndConditions = value!;
                    });
                  }),
              const Text('Yes! Agree to all Terms and Conditions'),
            ],
          )),
      Row(children: [
        Expanded(
            child: FilledButton(
          onPressed: () {},
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
    ]);
  }

  Widget _layout(List<Widget> children) {
    double circleRadius = MediaQuery.of(context).size.height * 0.871;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.0444;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: CircleMaskedBackground(
          backgroundContent: Container(color: Colors.white),
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
          circlePosition: Offset(MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height * 0.21 + circleRadius),
          circleRadius: circleRadius,
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  0,
                  horizontalPadding,
                  MediaQuery.of(context).size.height * 0.064),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              )),
        ));
  }
}
