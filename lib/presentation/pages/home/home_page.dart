import 'package:absensi/core/core.dart';
import 'package:absensi/presentation/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Variables.appName),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            icon: const Icon(Icons.logout),
            onPressed: () =>
                context.read<AuthBloc>().add(const AuthEvent.logout()),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = state.maybeWhen(
            authenticated: (u) => u,
            orElse: () => null,
          );

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.verified_user,
                    size: 64,
                    color: AppColors.primary,
                  ),
                  const SpaceHeight(16),
                  Text(
                    'Halo, ${user?.name ?? '-'}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SpaceHeight(4),
                  Text(user?.email ?? ''),
                  const SpaceHeight(12),
                  Chip(label: Text(user?.roleLabel ?? '-')),
                  const SpaceHeight(24),
                  const Text(
                    'Dashboard untuk peran ini menyusul di tahap berikutnya.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
