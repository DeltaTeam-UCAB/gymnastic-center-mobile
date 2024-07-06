import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/application/clients/bloc/clients_bloc.dart';
import 'package:gymnastic_center/domain/entities/client/client.dart';
import 'package:gymnastic_center/infrastructure/camara_gallery/camara_gallery_impl.dart';
import 'package:gymnastic_center/infrastructure/datasources/client/clients_datasource_impl.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/clients/clients_repository_impl.dart';
import 'package:gymnastic_center/injector.dart';
import 'package:gymnastic_center/presentation/screens/account/widgets/account_form_field_decoration.dart';
import 'package:gymnastic_center/presentation/widgets/shared/gymnastic_text_form_field/gymnastic_text_form_field.dart';
import 'package:gymnastic_center/presentation/widgets/shared/image_view.dart';

import 'widgets/change_password_menu.dart';

enum _AvatarImageOp { takePhoto, fromGallery }

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UpdateBloc>(),
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
  var canPop = true;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  _pressSubmit() async {
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.

      await context.read<UpdateBloc>().onSubmitUpdate();
      canPop = true;
      context.read<ClientsBloc>().getClientData();
    }
  }

  _uploadPhoto(String? photo) async {
    if (photo != null) {
      context.read<UpdateBloc>().avatarImageChanged(photo);
    }
    canPop = false;
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

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Discard Changes?'),
          content: const Text(
            'Changes are not saved',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Discard'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Client client = context.watch<ClientsBloc>().state.client;
    _nameController.text = client.name;
    _emailController.text = client.email;
    _phoneController.text = client.phone;
    final initialName = _nameController.text;
    var avatar = client.avatarImage;
    final formDeco = AccountFormFieldDecoration();
    return BlocBuilder<UpdateBloc, UpdateState>(
      buildWhen: (previous, current) {
        if (previous.avatarImage != current.avatarImage) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        bool ableToSave() {
          if (state.updateFormStatus == UpdateFormStatus.posting) return false;
          if (initialName == state.fullname) return false;
          return true;
        }

        if (context.read<ClientsBloc>().state.isLoading) {
          return const Center(
            child: SizedBox(
                width: 50, height: 50, child: CircularProgressIndicator()),
          );
        }
        return PopScope(
          canPop: canPop,
          onPopInvoked: (bool didPop) async {
            if (didPop) {
              return;
            }
            final bool shouldPop = await _showBackDialog() ?? false;
            if (context.mounted && shouldPop) {
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Column(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                      CircleAvatar(
                        radius: 100,
                        child: avatar == null
                            ? const Icon(
                                Icons.person,
                                size: 90,
                              )
                            : SizedBox(
                                height: 200,
                                width: 200,
                                child:
                                    ClipOval(child: ImageView(image: avatar!))),
                      ),
                      PopupMenuButton<_AvatarImageOp>(
                        child: ClipOval(
                          child: Container(
                            color: Colors.deepPurple, // Set the circle color
                            width: 50, // Adjust the size as needed
                            height: 50,
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onSelected: (_AvatarImageOp item) {},
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuEntry<_AvatarImageOp>>[
                          PopupMenuItem<_AvatarImageOp>(
                            onTap: () async {
                              final photo =
                                  await CamaraGalleryImpl().takePhoto();
                              _uploadPhoto(photo);
                              if (photo != null) avatar = photo;
                            },
                            value: _AvatarImageOp.takePhoto,
                            child: const ListTile(
                              leading: Icon(Icons.camera_alt),
                              title: Text('Take Photo'),
                            ),
                          ),
                          PopupMenuItem<_AvatarImageOp>(
                            onTap: () async {
                              final photo =
                                  await CamaraGalleryImpl().selectPhoto();
                              _uploadPhoto(photo);
                              if (photo != null) avatar = photo;
                            },
                            value: _AvatarImageOp.fromGallery,
                            child: const ListTile(
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
                              onChanged: (value) {
                                context
                                    .read<UpdateBloc>()
                                    .fullnameChanged(value);
                                canPop = false;
                              },
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
                                  onChanged: (value) {
                                    context
                                        .read<UpdateBloc>()
                                        .emailChanged(value);
                                    canPop = false;
                                  },
                                  validator: _validateEmail,
                                  decoration: formDeco.getDecoration(
                                      context, 'Email'))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GymnasticTextFormField(
                              style: formDeco.getTextStyle(context),
                              controller: _phoneController,
                              onChanged: (value) {
                                context.read<UpdateBloc>().phoneChanged(value);
                                canPop = false;
                              },
                              validator: _validatePhone,
                              decoration:
                                  formDeco.getDecoration(context, 'Phone'),
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
                        onPressed: ableToSave() ? _pressSubmit : null,
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
      },
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
