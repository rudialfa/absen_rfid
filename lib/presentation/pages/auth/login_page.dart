import 'package:absensi/core/core.dart';
import 'package:absensi/data/model/request/auth/login_request_model.dart';
import 'package:absensi/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailC = TextEditingController();
  final passC = TextEditingController();
  bool _hidePassword = true;

  @override
  void dispose() {
    emailC.dispose();
    passC.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (emailC.text.trim().isEmpty || passC.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email & password wajib diisi')),
      );
      return;
    }

    context.read<AuthBloc>().add(
          AuthEvent.login(
            LoginRequestModel(email: emailC.text, password: passC.text),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  final loading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );
                  final error = state.maybeWhen(
                    unauthenticated: (message) => message,
                    orElse: () => null,
                  );

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Icon(
                        Icons.school,
                        size: 64,
                        color: AppColors.primary,
                      ),
                      const SpaceHeight(12),
                      const Text(
                        Variables.appName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SpaceHeight(32),
                      CustomTextField(
                        controller: emailC,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                      const SpaceHeight(16),
                      CustomTextField(
                        controller: passC,
                        label: 'Password',
                        obscureText: _hidePassword,
                        textInputAction: TextInputAction.done,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          tooltip: _hidePassword
                              ? 'Tampilkan password'
                              : 'Sembunyikan password',
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () =>
                              setState(() => _hidePassword = !_hidePassword),
                        ),
                      ),
                      if (error != null) ...[
                        const SpaceHeight(16),
                        Text(
                          error,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: AppColors.red),
                        ),
                      ],
                      const SpaceHeight(24),
                      Button.filled(
                        onPressed: _submit,
                        label: loading ? 'Memproses...' : 'Masuk',
                        disabled: loading,
                      ),
                      const SpaceHeight(24),
                      const Text(
                        'Server: ${Variables.baseUrl}',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: AppColors.gray),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
