import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/infrastructure/datasources/client/clients_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/clients/clients_repository_impl.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_input_decoration.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateBloc(ClientsRepositoryImpl(
              keyValueStorage: LocalStorageService(),
              clientsDatasource: ClientsDatasourceImpl(LocalStorageService()))),
        ),
        BlocProvider(
          create: (context) => ClientsBloc(ClientsRepositoryImpl(
              keyValueStorage: LocalStorageService(),
              clientsDatasource: ClientsDatasourceImpl(LocalStorageService()))),
        ),
      ],
      child: const _AccountDetailsScreen(),
    );
  }
}

class _AccountDetailsScreen extends StatefulWidget {
  const _AccountDetailsScreen();

  @override
  State<_AccountDetailsScreen> createState() => _AccountDetailsScreenState();
}

class _AccountDetailsScreenState extends State<_AccountDetailsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ClientsBloc>().getClientData();
  }

  _pressSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      await context.read<UpdateBloc>().onSubmitUpdate();
    }
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
    RegExp phoneRegex = RegExp(
        r'^\s*(\+\d{1,3})([-. \t]*(\d{3})[-. \t]*)?((\d{3})[-. \t]*(\d{2,4})(?:[-.x \t]*(\d+))?)\s*$');

    if (value == null || value.isEmpty) {
      return 'You must enter a phone number.';
    }

    if (!phoneRegex.hasMatch(value)) {
      return 'Phone number must be in the format +1234567890.';
    }

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

  @override
  Widget build(BuildContext context) {
    final Client? client = context.watch<ClientsBloc>().state.client;
    final clientEmpty = context.watch<ClientsBloc>().state.isEmpty;
    _nameController.text = clientEmpty ? '' : client!.name;
    _emailController.text = clientEmpty ? '' : client!.email;
    _phoneController.text = clientEmpty ? '' : client!.phone;
    return BlocConsumer<UpdateBloc, UpdateState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Account Details'),
              ]),
            ],
          ),
        ),
        body: //SafeArea(
            /*child:*/ SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 100,
                      child: Icon(
                        Icons.person,
                        size: 90,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: Container(
                            height: 65,
                            width: 20,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                                child: Icon(
                              Icons.edit,
                            ))))
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GymnasticTextFormField(
                          controller: _nameController,
                          onChanged: context.read<UpdateBloc>().fullnameChanged,
                          validator: _validateName,
                          decoration: const GymnasticTextInputDecoration(
                            labelText: 'Full Name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GymnasticTextFormField(
                            controller: _emailController,
                            onChanged: context.read<UpdateBloc>().emailChanged,
                            validator: _validateEmail,
                            decoration: const GymnasticTextInputDecoration(
                              labelText: 'Email',
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GymnasticTextFormField(
                          controller: _phoneController,
                          onChanged: context.read<UpdateBloc>().phoneChanged,
                          validator: _validatePhone,
                          decoration: const GymnasticTextInputDecoration(
                              labelText: 'Phone'),
                        ),
                      ),
                      TextButton(
                          onPressed: _passwordBottomSheet,
                          child: const Text(
                            'Edit Password',
                            style: TextStyle(fontSize: 18),
                          )),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: FilledButton(
                    onPressed:
                        state.updateFormStatus == UpdateFormStatus.posting
                            ? null
                            : _pressSubmit,
                    child: const Text('Save Changes',
                        style: TextStyle(fontSize: 20)),
                  ),
                )
              ],
            ),
          ),
        ),
        //),
      ),
    );
  }

  _passwordBottomSheet() => showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => UpdateBloc(ClientsRepositoryImpl(
              keyValueStorage: LocalStorageService(),
              clientsDatasource: ClientsDatasourceImpl(LocalStorageService()))),
          child: const _ChangePasswordMenu(),
        );
      });
}

class _ChangePasswordMenu extends StatefulWidget {
  const _ChangePasswordMenu();

  @override
  State<_ChangePasswordMenu> createState() => _ChangePasswordMenuState();
}

class _ChangePasswordMenuState extends State<_ChangePasswordMenu> {
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
                controller: passwordController,
                obscureText: hidePassword,
                validator: validatePassword,
                onChanged: context.read<UpdateBloc>().passwordChanged,
                decoration: GymnasticTextInputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                  suffixIconColor: const Color(0xffc8ccd9),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: toggleObscuredPassword,
                      child: Icon(
                        hidePassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GymnasticTextFormField(
                controller: confirmPasswordController,
                obscureText: hideConfirmPassword,
                validator: validateConfirm,
                //onChanged: context.read<UpdateBloc>().passwordChanged,
                decoration: GymnasticTextInputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Password',
                  suffixIconColor: const Color(0xffc8ccd9),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: toggleObscuredConfirm,
                      child: Icon(
                        hideConfirmPassword
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                      ),
                    ),
                  ),
                ),
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
