import 'package:absensi/core/core.dart';
import 'package:absensi/presentation/bloc/auth/auth_bloc.dart';
import 'package:absensi/presentation/pages/settings/settings_page.dart';
import 'package:absensi/presentation/pages/student/student_list_page.dart';
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

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Column(
                children: [
                  const SpaceHeight(8),
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
                ],
              ),
              const SpaceHeight(24),
              if (user?.isAdmin ?? false) ...[
                _MenuTile(
                  icon: Icons.badge_outlined,
                  title: 'Murid dan kartu',
                  subtitle: 'Tambah murid, daftarkan kartu, ganti kartu hilang',
                  onTap: () => context.push(const StudentListPage()),
                ),
                const SpaceHeight(12),
                _MenuTile(
                  icon: Icons.settings_outlined,
                  title: 'Setelan perangkat',
                  subtitle:
                      'Jam masuk, batas terlambat, jam pulang, cooldown, teks LCD',
                  onTap: () => context.push(const SettingsPage()),
                ),
              ] else
                const Text(
                  'Dashboard untuk peran ini menyusul di tahap berikutnya.',
                  textAlign: TextAlign.center,
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
