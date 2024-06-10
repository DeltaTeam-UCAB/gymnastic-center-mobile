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
  final TextEditingController _passwordController = TextEditingController();

  bool _hidePassword = true;
  final _passwordFieldFocusNode = FocusNode();
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

  void _toggleObscured() {
    setState(() {
      _hidePassword = !_hidePassword;
      if (!_passwordFieldFocusNode.hasPrimaryFocus) {
        _passwordFieldFocusNode.canRequestFocus = false;
      }
    });
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

  @override
  Widget build(BuildContext context) {
    final Client? client = context.watch<ClientsBloc>().state.client;
    _nameController.text = client != null ? client.name : '';
    _emailController.text = client != null ? client.email : '';
    _phoneController.text = client != null ? client.phone : '';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 100,
                child: Icon(
                  Icons.person,
                  size: 90,
                ),
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
                        decoration: GymnasticTextInputDecoration(
                            labelText: 'Full Name',
                            hintText: client == null ? '' : client.name),
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
                        decoration: GymnasticTextInputDecoration(
                            labelText: 'Phone',
                            hintText: client == null ? '' : client.phone),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GymnasticTextFormField(
                        controller: _passwordController,
                        obscureText: _hidePassword,
                        validator: _validatePassword,
                        onChanged: context.read<UpdateBloc>().passwordChanged,
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: FilledButton(
                  onPressed: state.updateFormStatus == UpdateFormStatus.posting
                      ? null
                      : _pressSubmit,
                  child: const Text('Save Changes',
                      style: TextStyle(fontSize: 20)),
                ),
              )
            ],
          ),
        ),
        //),
      ),
    );
  }
}
