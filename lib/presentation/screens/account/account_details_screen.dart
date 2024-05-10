import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymnastic_center/application/auth/update/update_bloc.dart';
import 'package:gymnastic_center/infrastructure/datasources/user/user_datasource.dart';
import 'package:gymnastic_center/infrastructure/local_storage/local_storage.dart';
import 'package:gymnastic_center/infrastructure/repositories/user/user_repository.dart';

bool _isEditing = false;

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateBloc(UserHttpRepository(
          keyValueStorage: LocalStorageService(),
          userDatasource: APIUserDatasource(LocalStorageService()))),
      child: _AccountDetailsScreen(),
    );
  }
}

class _AccountDetailsScreen extends StatelessWidget {
  _AccountDetailsScreen();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        body: Center(
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
                    TextField(
                      onChanged: context.read<UpdateBloc>().fullnameChanged,
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                      ),
                    ),
                    TextField(
                      onChanged: context.read<UpdateBloc>().emailChanged,
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    TextField(
                      onChanged: context.read<UpdateBloc>().phoneChanged,
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                      ),
                    ),
                    TextField(
                      onChanged: context.read<UpdateBloc>().passwordChanged,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: FilledButton(
                  onPressed: () {
                    RegExp emailRegex =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    RegExp passwordRegex = RegExp(
                      r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$',
                    );
                    if (emailRegex.hasMatch(_emailController.text) &&
                        _nameController.text.length >= 7 &&
                        passwordRegex.hasMatch(_passwordController.text)) {
                      context.read<UpdateBloc>().onSubmitUpdate();
                    }
                  },
                  child: const Text('Save Changes',
                      style: TextStyle(fontSize: 20)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
