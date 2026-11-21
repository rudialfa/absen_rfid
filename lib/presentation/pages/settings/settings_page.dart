import 'package:absensi/core/core.dart';
import 'package:absensi/data/model/request/settings/settings_update_request_model.dart';
import 'package:absensi/data/model/response/settings/settings_response_model.dart';
import 'package:absensi/presentation/bloc/settings/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final lateC = TextEditingController();
  final outC = TextEditingController();
  final cooldownC = TextEditingController();
  final lcdC = TextEditingController();
  bool requireToken = false;

  /// Nilai terakhir dari server, dipakai untuk mengirim hanya field yang berubah
  SettingsModel? _loaded;

  static final _timeRegex = RegExp(r'^([01]\d|2[0-3]):[0-5]\d$');

  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const SettingsEvent.getSettings());
  }

  @override
  void dispose() {
    lateC.dispose();
    outC.dispose();
    cooldownC.dispose();
    lcdC.dispose();
    super.dispose();
  }

  void _fill(SettingsModel s) {
    setState(() {
      _loaded = s;
      lateC.text = s.lateTime;
      outC.text = s.checkoutStart;
      cooldownC.text = s.cooldownSeconds.toString();
      lcdC.text = s.lcdIdle;
      requireToken = s.requireCardToken;
    });
  }

  void _snack(String message, {bool error = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _pickTime(TextEditingController c) async {
    final parts = c.text.split(':');
    final hour = (int.tryParse(parts.first) ?? 7).clamp(0, 23);
    final minute =
        (parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0).clamp(0, 59);

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: hour, minute: minute),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return;

    c.text = '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';
  }

  Future<bool> _confirmRequireToken() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aktifkan wajib token kartu?'),
        content: const Text(
          'Kartu yang belum didaftarkan ulang dengan token akan ditolak saat '
          'tap. Pastikan semua kartu murid dan guru sudah diberi token.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Aktifkan'),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  void _save() {
    FocusScope.of(context).unfocus();

    final current = _loaded;
    if (current == null) return;

    final late = lateC.text.trim();
    final out = outC.text.trim();
    final lcd = lcdC.text.trim();
    final cooldown = int.tryParse(cooldownC.text.trim());

    if (!_timeRegex.hasMatch(late) || !_timeRegex.hasMatch(out)) {
      _snack('Jam harus berformat HH:MM');
      return;
    }
    if (late.compareTo(out) > 0) {
      _snack('Batas terlambat tidak boleh lebih besar dari jam mulai pulang');
      return;
    }
    if (cooldown == null || cooldown < 1 || cooldown > 600) {
      _snack('Cooldown harus angka 1 sampai 600 detik');
      return;
    }
    if (lcd.isEmpty || lcd.length > 16) {
      _snack('Teks LCD wajib diisi, maksimal 16 karakter');
      return;
    }

    final request = SettingsUpdateRequestModel(
      lateTime: late != current.lateTime ? late : null,
      checkoutStart: out != current.checkoutStart ? out : null,
      cooldownSeconds: cooldown != current.cooldownSeconds ? cooldown : null,
      lcdIdle: lcd != current.lcdIdle ? lcd : null,
      requireCardToken:
          requireToken != current.requireCardToken ? requireToken : null,
    );

    if (request.isEmpty) {
      _snack('Tidak ada perubahan', error: false);
      return;
    }

    context.read<SettingsBloc>().add(SettingsEvent.update(request));
  }

  Widget _timeField({
    required TextEditingController controller,
    required String label,
    required String help,
    required bool disabled,
  }) {
    return GestureDetector(
      onTap: disabled ? null : () => _pickTime(controller),
      child: AbsorbPointer(
        child: CustomTextField(
          controller: controller,
          label: label,
          readOnly: true,
          helperText: help,
          prefixIcon: const Icon(Icons.access_time),
        ),
      ),
    );
  }

  Widget _form(bool saving) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.stroke),
          ),
          child: const Text(
            'Perubahan jam langsung berlaku di tap berikutnya. Cooldown dan '
            'teks LCD diambil perangkat tiap 5 menit atau saat dinyalakan '
            'ulang.',
            style: TextStyle(fontSize: 12, color: AppColors.gray),
          ),
        ),
        const SpaceHeight(20),
        _timeField(
          controller: lateC,
          label: 'Batas terlambat',
          help: 'Tap masuk setelah jam ini dicatat terlambat',
          disabled: saving,
        ),
        const SpaceHeight(16),
        _timeField(
          controller: outC,
          label: 'Jam mulai pulang',
          help:
              'Tap sebelum jam ini dihitung masuk, sesudahnya dihitung pulang',
          disabled: saving,
        ),
        const SpaceHeight(16),
        CustomTextField(
          controller: cooldownC,
          label: 'Cooldown kartu (detik)',
          keyboardType: TextInputType.number,
          helperText:
              'Kartu yang sama diabaikan selama waktu ini (1 sampai 600)',
          prefixIcon: const Icon(Icons.timer_outlined),
          readOnly: saving,
        ),
        const SpaceHeight(16),
        CustomTextField(
          controller: lcdC,
          label: 'Teks LCD saat menunggu kartu',
          helperText: 'Maksimal 16 karakter',
          prefixIcon: const Icon(Icons.text_fields),
          readOnly: saving,
        ),
        const SpaceHeight(8),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Wajib token kartu',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: const Text(
            'Kartu tanpa token ditolak (anti kartu clone). Aktifkan setelah '
            'semua kartu didaftarkan ulang.',
          ),
          value: requireToken,
          onChanged: saving
              ? null
              : (value) async {
                  if (value && !await _confirmRequireToken()) return;
                  if (!mounted) return;
                  setState(() => requireToken = value);
                },
        ),
        const SpaceHeight(16),
        Button.filled(
          onPressed: _save,
          label: saving ? 'Menyimpan...' : 'Simpan',
          disabled: saving,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setelan Perangkat')),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          state.maybeWhen(
            loaded: (s) => _fill(s),
            saved: (s, message) {
              _fill(s);
              _snack(message, error: false);
            },
            saveFailed: (s, message) => _snack(message),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return state.maybeWhen<Widget>(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loadFailed: (message) => Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.red),
                    ),
                    const SpaceHeight(16),
                    Button.outlined(
                      onPressed: () => context
                          .read<SettingsBloc>()
                          .add(const SettingsEvent.getSettings()),
                      label: 'Coba lagi',
                      width: 200,
                    ),
                  ],
                ),
              ),
            ),
            saving: (_) => _form(true),
            orElse: () => _form(false),
          );
        },
      ),
    );
  }
}
