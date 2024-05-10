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
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return _layout([
      Padding(
        padding: EdgeInsets.fromLTRB(
            0, 0, 0, MediaQuery.of(context).size.height * 0.0628),
        child: Image.asset(
          'assets/icon/logoApp_${isDarkMode ? 'white' : 'purple'}.png',
          height: MediaQuery.of(context).size.height * 0.127,
        ),
      ),
      _textFieldPadding(
          Text('Login',
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black)),
          top: false),
      _textFieldPadding(TextField(
        controller: _emailController,
        style: TextStyle(
            fontSize: 16,
            color:
                isDarkMode ? Colors.white : const Color.fromARGB(176, 0, 0, 0)),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          contentPadding: const EdgeInsets.fromLTRB(36, 15, 10, 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(176, 0, 0, 0),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(300)),
              borderSide: BorderSide(
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(132, 158, 158, 158),
              )),
          floatingLabelStyle: TextStyle(
              fontSize: 17.78,
              color: isDarkMode
                  ? Colors.white
                  : const Color.fromARGB(176, 0, 0, 0),
              fontWeight: FontWeight.bold),
          labelStyle: TextStyle(
              fontSize: 17.78,
              color: isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold),
          hintStyle: TextStyle(
            fontSize: 16,
            color: isDarkMode
                ? Colors.white54
                : const Color.fromARGB(176, 0, 0, 0),
          ),
          labelText: 'Email',
          hintText: 'youremail@example.com',
          prefixIconColor:
              isDarkMode ? Colors.white : const Color.fromARGB(176, 0, 0, 0),
          prefixIcon: const Icon(Icons.email),
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
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(300)),
                borderSide: BorderSide(
                  color: isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(176, 0, 0, 0),
                )),
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(300)),
                borderSide: BorderSide(
                  color: isDarkMode
                      ? Colors.white
                      : const Color.fromARGB(132, 158, 158, 158),
                )),
            floatingLabelStyle: TextStyle(
                fontSize: 17.78,
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(176, 0, 0, 0),
                fontWeight: FontWeight.bold),
            labelStyle: TextStyle(
                fontSize: 17.78,
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
            hintStyle: TextStyle(
              fontSize: 16,
              color: isDarkMode
                  ? Colors.white54
                  : const Color.fromARGB(176, 0, 0, 0),
            ),
            labelText: 'Password',
            hintText: 'Password',
            suffixIconColor:
                isDarkMode ? Colors.white : const Color.fromARGB(176, 0, 0, 0),
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
              child: GradientText(
                  textWidget:
                      const Text('Login', style: TextStyle(fontSize: 20)),
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
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
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
        Text("Sign up",
            style: TextStyle(
                color: isDarkMode
                    ? Colors.white
                    : const Color.fromARGB(255, 88, 27, 173),
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ])
    ]);
  }

  Widget _layout(List<Widget> children) {
    double circleRadius = MediaQuery.of(context).size.height * 0.871;
    double horizontalPadding = MediaQuery.of(context).size.width * 0.0444;

    var colors = Theme.of(context).colorScheme;

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
            child: Container(color: colors.background),
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
