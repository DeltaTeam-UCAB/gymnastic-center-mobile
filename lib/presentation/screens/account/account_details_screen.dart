import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/application/themes/themes_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/infrastructure/datasources/client/clients_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/clients/clients_repository_impl.dart';
import 'package:gymnastic_center/presentation/screens/account/widgets/account_form_field_decoration.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';

import 'widgets/change_password_menu.dart';

enum _AvatarImageOp { takePhoto, fromGallery }

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBloc(ClientsRepositoryImpl(
          keyValueStorage: LocalStorageService(),
          clientsDatasource: ClientsDatasourceImpl(LocalStorageService()))),
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
    final Client client = context.watch<ClientsBloc>().state.client;
    _nameController.text = client.name;
    _emailController.text = client.email;
    _phoneController.text = client.phone;
    final formDeco = AccountFormFieldDecoration();
    final isDark = context.watch<ThemesBloc>().isDarkMode;
    return BlocBuilder<UpdateBloc, UpdateState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: const Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Account Details'),
              ]),
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20),
                Stack(alignment: Alignment.bottomRight, children: [
                  const CircleAvatar(
                    radius: 100,
                    child: Icon(
                      Icons.person,
                      size: 90,
                    ),
                  ),
                  PopupMenuButton<_AvatarImageOp>(
                    child: ElevatedButton(
                      onPressed: null,
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(isDark
                              ? const Color.fromARGB(255, 213, 185, 255)
                              : Theme.of(context).primaryColor)),
                      child: Container(
                        width: 20,
                        height: 60,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).indicatorColor,
                        ),
                      ),
                    ),
                    onSelected: (_AvatarImageOp item) {},
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<_AvatarImageOp>>[
                      const PopupMenuItem<_AvatarImageOp>(
                        value: _AvatarImageOp.takePhoto,
                        child: ListTile(
                          leading: Icon(Icons.camera_alt),
                          title: Text('Take Photo'),
                        ),
                      ),
                      const PopupMenuItem<_AvatarImageOp>(
                        value: _AvatarImageOp.fromGallery,
                        child: ListTile(
                          leading: Icon(Icons.upload_rounded),
                          title: Text('Upload from gallery'),
                        ),
                      )
                    ],
                  ),
                ]),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GymnasticTextFormField(
                          style: formDeco.getTextStyle(context),
                          controller: _nameController,
                          onChanged: context.read<UpdateBloc>().fullnameChanged,
                          validator: _validateName,
                          decoration:
                              formDeco.getDecoration(context, 'Full name'),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GymnasticTextFormField(
                              style: formDeco.getTextStyle(context),
                              controller: _emailController,
                              onChanged:
                                  context.read<UpdateBloc>().emailChanged,
                              validator: _validateEmail,
                              decoration:
                                  formDeco.getDecoration(context, 'Email'))),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GymnasticTextFormField(
                          style: formDeco.getTextStyle(context),
                          controller: _phoneController,
                          onChanged: context.read<UpdateBloc>().phoneChanged,
                          validator: _validatePhone,
                          decoration: formDeco.getDecoration(context, 'Phone'),
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
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) =>
                BlocProvider(
              create: (context) => UpdateBloc(ClientsRepositoryImpl(
                  keyValueStorage: LocalStorageService(),
                  clientsDatasource:
                      ClientsDatasourceImpl(LocalStorageService()))),
              child: SizedBox(
                height: constraints.maxHeight * 0.5 +
                    MediaQuery.of(context).viewInsets.bottom * 0.8,
                child: const ChangePasswordMenu(),
              ),
            ),
          ));
}
