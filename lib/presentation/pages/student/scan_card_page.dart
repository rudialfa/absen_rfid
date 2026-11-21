import 'package:absensi/core/core.dart';
import 'package:absensi/data/datasources/enroll_remote_datasource.dart';
import 'package:absensi/presentation/bloc/enroll/enroll_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanCardPage extends StatelessWidget {
  const ScanCardPage({super.key, this.title = 'Scan Kartu'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          EnrollBloc(EnrollRemoteDatasource())..add(const EnrollEvent.start()),
      child: _ScanView(title: title),
    );
  }
}

class _ScanView extends StatefulWidget {
  const _ScanView({required this.title});

  final String title;

  @override
  State<_ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<_ScanView> {
  late final EnrollBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<EnrollBloc>();
  }

  @override
  void dispose() {
    final ready =
        _bloc.state.maybeWhen(ready: (_) => true, orElse: () => false);

    // Sesi yang belum menghasilkan kartu siap dibatalkan di server
    if (!ready && !_bloc.isClosed) {
      _bloc.add(const EnrollEvent.cancel());
    }
    super.dispose();
  }

  void _restart() => _bloc.add(const EnrollEvent.start());

  Widget _status({
    Widget? leading,
    required String title,
    String? subtitle,
    String? uid,
    List<Widget> actions = const [],
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        leading ?? const SizedBox.shrink(),
        const SpaceHeight(20),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        if (subtitle != null) ...[
          const SpaceHeight(8),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.gray),
          ),
        ],
        if (uid != null) ...[
          const SpaceHeight(16),
          Text(
            'UID: $uid',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
        ],
        if (actions.isNotEmpty) ...[
          const SpaceHeight(24),
          ...actions,
        ],
      ],
    );
  }

  Widget _spinner() => const SizedBox(
        width: 56,
        height: 56,
        child: CircularProgressIndicator(strokeWidth: 4),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: BlocBuilder<EnrollBloc, EnrollState>(
        builder: (context, state) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: state.when<Widget>(
                initial: () => _status(
                  leading: _spinner(),
                  title: 'Menyiapkan...',
                ),
                starting: () => _status(
                  leading: _spinner(),
                  title: 'Menyiapkan...',
                ),
                waiting: (expiresIn) => _status(
                  leading: const Icon(
                    Icons.nfc,
                    size: 80,
                    color: AppColors.primary,
                  ),
                  title: 'Tempelkan kartu ke perangkat',
                  subtitle:
                      'Sisa waktu $expiresIn detik.\nPastikan perangkat (ESP32) '
                      'menyala dan terhubung Wi-Fi.',
                ),
                writing: (uid) => _status(
                  leading: _spinner(),
                  title: 'Menulis token ke kartu...',
                  subtitle:
                      'Jangan angkat kartu sampai selesai. Kalau perangkat '
                      'meminta, tempelkan lagi kartu yang sama.',
                  uid: uid,
                ),
                ready: (uid) => _status(
                  leading: const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.green,
                  ),
                  title: 'Kartu siap',
                  subtitle:
                      'Token sudah tertulis. Simpan dalam 5 menit setelah ini.',
                  uid: uid,
                  actions: [
                    Button.filled(
                      onPressed: () => Navigator.pop(context, uid),
                      label: 'Pakai kartu ini',
                    ),
                  ],
                ),
                alreadyUsed: (uid, ownerName, ownerType) => _status(
                  leading: const Icon(
                    Icons.error_outline,
                    size: 80,
                    color: AppColors.red,
                  ),
                  title: 'Kartu ini sudah dipakai',
                  subtitle: 'Pemilik: ${ownerName ?? '-'} '
                      '(${ownerType == 'teacher' ? 'guru' : 'murid'}).\n'
                      'Gunakan kartu lain.',
                  uid: uid,
                  actions: [
                    Button.outlined(onPressed: _restart, label: 'Scan ulang'),
                  ],
                ),
                expired: () => _status(
                  leading: const Icon(
                    Icons.timer_off_outlined,
                    size: 80,
                    color: AppColors.gray,
                  ),
                  title: 'Waktu habis',
                  subtitle: 'Belum ada kartu yang terbaca.',
                  actions: [
                    Button.outlined(onPressed: _restart, label: 'Scan ulang'),
                  ],
                ),
                failed: (message) => _status(
                  leading: const Icon(
                    Icons.error_outline,
                    size: 80,
                    color: AppColors.red,
                  ),
                  title: 'Scan gagal',
                  subtitle: message,
                  actions: [
                    Button.outlined(onPressed: _restart, label: 'Coba lagi'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
