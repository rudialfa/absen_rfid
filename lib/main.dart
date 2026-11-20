import 'package:absensi/core/core.dart';
import 'package:absensi/data/datasources/auth_local_datsource.dart';
import 'package:absensi/data/datasources/auth_remote_datasource.dart';
import 'package:absensi/presentation/bloc/auth/auth_bloc.dart';
import 'package:absensi/presentation/pages/auth/login_page.dart';
import 'package:absensi/presentation/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AuthBloc(AuthRemoteDatasource(), AuthLocalDatsource())
                ..add(const AuthEvent.started()),
        ),
      ],
      child: MaterialApp(
        title: Variables.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => state.maybeWhen<Widget>(
            authenticated: (_) => const HomePage(),
            initial: () => const _Splash(),
            orElse: () => const LoginPage(),
          ),
        ),
      ),
    );
  }
}

class _Splash extends StatelessWidget {
  const _Splash();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
