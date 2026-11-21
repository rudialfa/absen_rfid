import 'package:absensi/core/core.dart';
import 'package:absensi/data/model/request/device/device_request_model.dart';
import 'package:absensi/data/model/response/device/device_response_model.dart';
import 'package:absensi/presentation/bloc/device/device_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum _Action { rename, rotate, delete }

class DeviceListPage extends StatefulWidget {
  const DeviceListPage({super.key});

  @override
  State<DeviceListPage> createState() => _DeviceListPageState();
}

class _DeviceListPageState extends State<DeviceListPage> {
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() => context.read<DeviceBloc>().add(const DeviceEvent.getList());

  void _snack(String message, {bool error = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  String _created(String? iso) {
    final d = DateTime.tryParse(iso ?? '');
    return d == null ? '-' : d.toLocal().toFormattedDateTime();
  }

  Future<bool> _confirm({
    required String title,
    required String message,
    required String action,
  }) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(action),
          ),
        ],
      ),
    );
    return ok ?? false;
  }

  Future<void> _add() async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => const _NameDialog(
        title: 'Tambah perangkat',
        action: 'Tambah',
      ),
    );
    if (name == null || !mounted) return;

    context
        .read<DeviceBloc>()
        .add(DeviceEvent.create(DeviceNameRequestModel(name: name)));
  }

  Future<void> _rename(DeviceModel d) async {
    final name = await showDialog<String>(
      context: context,
      builder: (context) => _NameDialog(
        title: 'Ganti nama perangkat',
        action: 'Simpan',
        initial: d.name,
      ),
    );
    if (name == null || !mounted || name == d.name) return;

    context
        .read<DeviceBloc>()
        .add(DeviceEvent.rename(d.id, DeviceNameRequestModel(name: name)));
  }

  Future<void> _rotate(DeviceModel d) async {
    final ok = await _confirm(
      title: 'Ganti key "${d.name}"?',
      message: 'Key lama langsung tidak berlaku. ESP32 yang masih memakai key '
          'lama akan menampilkan "Kunci salah" sampai key baru dipasang '
          '(upload sketch, atau lewat BLE di Tahap 6).\n\n'
          'Lakukan ini hanya kalau kamu siap memasang key baru.',
      action: 'Ganti key',
    );
    if (!ok || !mounted) return;

    context.read<DeviceBloc>().add(DeviceEvent.rotateKey(d.id));
  }

  Future<void> _delete(DeviceModel d) async {
    final ok = await _confirm(
      title: 'Hapus "${d.name}"?',
      message: 'Key perangkat ini langsung tidak berlaku, dan ESP32 yang '
          'memakainya akan menampilkan "Kunci salah". Riwayat absensi tetap '
          'tersimpan. Perangkat terakhir tidak bisa dihapus.',
      action: 'Hapus',
    );
    if (!ok || !mounted) return;

    context.read<DeviceBloc>().add(DeviceEvent.delete(d.id));
  }

  Future<void> _showKey(DeviceModel d, String key, bool rotated) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => _KeyDialog(
        deviceName: d.name,
        deviceKey: key,
        rotated: rotated,
      ),
    );
    if (!mounted) return;
    _load(); // daftar dimuat ulang, key tidak tersimpan lagi di aplikasi
  }

  Widget _tile(DeviceModel d) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
      ),
      child: ListTile(
        leading: const Icon(Icons.memory, color: AppColors.primary),
        title: Text(
          d.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text('Dibuat ${_created(d.createdAt)}'),
        trailing: PopupMenuButton<_Action>(
          enabled: !_saving,
          onSelected: (action) {
            switch (action) {
              case _Action.rename:
                _rename(d);
              case _Action.rotate:
                _rotate(d);
              case _Action.delete:
                _delete(d);
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: _Action.rename, child: Text('Ganti nama')),
            PopupMenuItem(value: _Action.rotate, child: Text('Ganti key')),
            PopupMenuItem(value: _Action.delete, child: Text('Hapus')),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perangkat (ESP32)')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        onPressed: _saving ? null : _add,
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<DeviceBloc, DeviceState>(
        listener: (context, state) {
          final saving =
              state.maybeWhen(saving: () => true, orElse: () => false);
          if (saving != _saving) setState(() => _saving = saving);

          state.maybeWhen(
            saved: (message) {
              _snack(message, error: false);
              _load();
            },
            saveFailed: (message) => _snack(message),
            keyIssued: (device, key, rotated) => _showKey(device, key, rotated),
            orElse: () {},
          );
        },
        buildWhen: (_, current) => current.maybeWhen(
          initial: () => true,
          listLoading: () => true,
          listLoaded: (_) => true,
          listFailed: (_) => true,
          orElse: () => false,
        ),
        builder: (context, state) {
          final body = state.maybeWhen<Widget>(
            listLoaded: (items) {
              if (items.isEmpty) {
                return const Center(child: Text('Belum ada perangkat.'));
              }

              return RefreshIndicator(
                onRefresh: () async => _load(),
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: items.map(_tile).toList(),
                ),
              );
            },
            listFailed: (message) => Center(
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
                      onPressed: _load,
                      label: 'Coba lagi',
                      width: 200,
                    ),
                  ],
                ),
              ),
            ),
            orElse: () => const Center(child: CircularProgressIndicator()),
          );

          return Column(
            children: [
              if (_saving) const LinearProgressIndicator(),
              Expanded(child: body),
            ],
          );
        },
      ),
    );
  }
}

/// Dialog nama perangkat (tambah dan ganti nama)
class _NameDialog extends StatefulWidget {
  const _NameDialog({
    required this.title,
    required this.action,
    this.initial,
  });

  final String title;
  final String action;
  final String? initial;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  late final TextEditingController c =
      TextEditingController(text: widget.initial ?? '');
  String? error;

  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  void _ok() {
    final value = c.text.trim();

    if (value.isEmpty) {
      setState(() => error = 'Nama wajib diisi');
      return;
    }
    if (value.length > 100) {
      setState(() => error = 'Nama maksimal 100 karakter');
      return;
    }

    Navigator.pop(context, value);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: c,
        autofocus: true,
        textCapitalization: TextCapitalization.words,
        onSubmitted: (_) => _ok(),
        decoration: InputDecoration(
          hintText: 'Contoh: Gerbang Utama',
          errorText: error,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        TextButton(onPressed: _ok, child: Text(widget.action)),
      ],
    );
  }
}

/// Menampilkan device key sekali. Tidak bisa ditutup dengan tombol back atau
/// klik di luar dialog, supaya key tidak hilang sebelum disalin.
class _KeyDialog extends StatefulWidget {
  const _KeyDialog({
    required this.deviceName,
    required this.deviceKey,
    required this.rotated,
  });

  final String deviceName;
  final String deviceKey;
  final bool rotated;

  @override
  State<_KeyDialog> createState() => _KeyDialogState();
}

class _KeyDialogState extends State<_KeyDialog> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.deviceKey));
    if (!mounted) return;
    setState(() => _copied = true);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AlertDialog(
        title: Text(widget.rotated ? 'Key baru' : 'Perangkat ditambahkan'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.deviceName,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const SpaceHeight(12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: SelectableText(
                  widget.deviceKey,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SpaceHeight(12),
              const Text(
                'Key ini hanya tampil sekali. Salin sekarang dan jangan kirim '
                'ke chat atau repositori.',
                style: TextStyle(fontSize: 12, color: AppColors.gray),
              ),
              const SpaceHeight(8),
              if (widget.rotated)
                const Text(
                  'Key lama sudah tidak berlaku. ESP32 yang masih memakainya '
                  'menampilkan "Kunci salah" sampai key baru dipasang.',
                  style: TextStyle(fontSize: 12, color: AppColors.red),
                )
              else
                const Text(
                  'Pasang key ini di sketch ESP32 (DEVICE_KEY). Setelah BLE '
                  '(Tahap 6) selesai, key dikirim langsung dari aplikasi.',
                  style: TextStyle(fontSize: 12, color: AppColors.gray),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: _copy,
            child: Text(_copied ? 'Tersalin' : 'Salin'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Sudah saya simpan'),
          ),
        ],
      ),
    );
  }
}
