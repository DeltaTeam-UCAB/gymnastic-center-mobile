import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymnastic_center/presentation/widgets/shared/backgrounds/circle_masked_background.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _hidePassword = true;

  final passwordFieldFocusNode = FocusNode();

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
          const Text('Login',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
          top: false),
      _textFieldPadding(TextField(
        controller: _emailController,
        style:
            const TextStyle(fontSize: 16, color: Color.fromARGB(176, 0, 0, 0)),
        decoration: const InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: EdgeInsets.fromLTRB(36, 15, 10, 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color.fromARGB(176, 0, 0, 0),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: Color.fromARGB(132, 158, 158, 158),
              )),
          floatingLabelStyle: TextStyle(
              fontSize: 17.78,
              color: Color.fromARGB(176, 0, 0, 0),
              fontWeight: FontWeight.bold),
          labelStyle: TextStyle(
              fontSize: 17.78,
              color: Colors.black,
              fontWeight: FontWeight.bold),
          hintStyle: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(176, 0, 0, 0),
          ),
          labelText: 'Email',
          hintText: 'youremail@example.com',
          prefixIconColor: Color.fromARGB(176, 0, 0, 0),
          prefixIcon: Icon(Icons.email),
        ),
      )),
      _textFieldPadding(
        TextField(
          controller: _passwordController,
          obscureText: _hidePassword,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(176, 0, 0, 0),
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.fromLTRB(36, 15, 10, 15),
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(300)),
                borderSide: BorderSide(
                  color: Color.fromARGB(176, 0, 0, 0),
                )),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(300)),
                borderSide: BorderSide(
                  color: Color.fromARGB(176, 0, 0, 0),
                )),
            floatingLabelStyle: const TextStyle(
                fontSize: 17.78,
                color: Color.fromARGB(176, 0, 0, 0),
                fontWeight: FontWeight.bold),
            labelStyle: const TextStyle(
                fontSize: 17.78,
                color: Colors.black,
                fontWeight: FontWeight.bold),
            hintStyle: const TextStyle(
                fontSize: 16, color: Color.fromARGB(176, 0, 0, 0)),
            labelText: 'Password',
            hintText: 'Password',
            suffixIconColor: const Color.fromARGB(176, 0, 0, 0),
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
      ),
      Row(children: [
        Expanded(
            child: FilledButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 88, 27, 173),
            padding: const EdgeInsets.symmetric(),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                  0,
                  MediaQuery.of(context).size.height * 0.0192,
                  0,
                  MediaQuery.of(context).size.height * 0.0192),
              child: const GradientText(
                  textWidget: Text('Login', style: TextStyle(fontSize: 20)),
                  gradient: LinearGradient(colors: [
                    Colors.white,
                    Colors.white,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight))),
        )),
      ]),
      const SizedBox(
        height: 15,
      ),
      const Text("Forget your password?",
          style: TextStyle(
              color: Color.fromARGB(255, 88, 27, 173),
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      const SizedBox(
        height: 20,
      ),
      const Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Text("Don't have an account?",
            style: TextStyle(
                color: Color.fromARGB(176, 0, 0, 0),
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
        SizedBox(
          width: 10,
        ),
        Text("Sign up",
            style: TextStyle(
                color: Color.fromARGB(255, 88, 27, 173),
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ])
    ]);
  }

  Widget _layout(List<Widget> children) {
    double circleRadius = MediaQuery.of(context).size.height * 0.871;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.0444;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: CircleMaskedBackground(
          backgroundContent: SvgPicture.asset(
            'assets/splash/splash-screen-bg.svg',
            fit: BoxFit.cover,
            height: MediaQuery.of(context).size.height,
            alignment: Alignment.topLeft,
          ),
          circleMaskContent: Container(
            alignment: Alignment.center,
            height: double.infinity,
            child: Container(color: Colors.white),
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
