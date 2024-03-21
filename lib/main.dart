import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/vault_api.dart';
import 'core/vault_cubit.dart';
import 'core/vault_state.dart';
import 'infrastructure/infrastructure.dart';
import 'infrastructure/storage.dart';
import 'ui/password_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await Storage.create();

  runApp(BlocProvider(
    create: (context) => VaultCubit(
      VaultApi(protector: Protection.sensibleDefaults(), storage: storage),
    ),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PasswordManager',
      home: BlocListener<VaultCubit, VaultState>(
          listenWhen: (previous, current) => current.failure != null,
          listener: (context, state) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.failure!.message)));
          },
          child: const PasswordScreen()),
    );
  }
}