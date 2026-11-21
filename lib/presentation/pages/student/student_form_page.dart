import 'package:absensi/core/core.dart';
import 'package:absensi/data/model/request/student/student_request_model.dart';
import 'package:absensi/data/model/response/class/class_response_model.dart';
import 'package:absensi/data/model/response/student/student_response_model.dart';
import 'package:absensi/presentation/bloc/class/class_bloc.dart';
import 'package:absensi/presentation/bloc/student/student_bloc.dart';
import 'package:absensi/presentation/pages/student/scan_card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentFormPage extends StatefulWidget {
  final StudentModel? initial;
  const StudentFormPage({super.key, this.initial});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  static const _newClassOption = '+ Kelas baru';

  late final TextEditingController nameC;
  late final TextEditingController newClassC;

  String? _selectedClass; // nama kelas, atau _newClassOption
  String? _uid; // hasil scan, hanya untuk tambah murid
  bool _active = true;

  bool get isEdit => widget.initial != null;

  @override
  void initState() {
    super.initState();
    final i = widget.initial;
    nameC = TextEditingController(text: i?.name ?? '');
    newClassC = TextEditingController();
    _selectedClass = (i != null && i.className.isNotEmpty) ? i.className : null;
    _active = i?.isActive ?? true;
    context.read<ClassBloc>().add(const ClassEvent.getList());
  }

  @override
  void dispose() {
    nameC.dispose();
    newClassC.dispose();
    super.dispose();
  }

  void _snack(String message, {bool error = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _scan() async {
    final uid = await context.push<String>(
      const ScanCardPage(title: 'Scan kartu murid'),
    );
    if (uid == null || !mounted) return;
    setState(() => _uid = uid);
  }

  Future<void> _replaceCard() async {
    final i = widget.initial!;

    final uid = await context.push<String>(
      const ScanCardPage(title: 'Scan kartu pengganti'),
    );
    if (uid == null || !mounted) return;

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ganti kartu?'),
        content: Text(
          'Kartu lama ${i.rfidUid} milik ${i.name} tidak berlaku lagi. '
          'Kartu baru: $uid.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ganti'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;

    context.read<StudentBloc>().add(StudentEvent.replaceCard(i.id));
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final name = nameC.text.trim();
    if (name.isEmpty) {
      _snack('Nama wajib diisi');
      return;
    }
    if (name.length > 100) {
      _snack('Nama maksimal 100 karakter');
      return;
    }

    final classes = context.read<ClassBloc>().state.maybeWhen(
          loaded: (items) => items,
          orElse: () => <ClassModel>[],
        );

    int? classId;
    String? className;

    if (classes.isEmpty || _selectedClass == _newClassOption) {
      final typed = newClassC.text.trim();
      if (typed.isNotEmpty) className = typed;
    } else {
      final picked = classes.where((c) => c.name == _selectedClass);
      if (picked.isNotEmpty) classId = picked.first.id;
    }

    if (className != null && className.length > 50) {
      _snack('Nama kelas maksimal 50 karakter');
      return;
    }

    // ---- Tambah murid ----
    if (!isEdit) {
      if (classId == null && className == null) {
        _snack('Kelas wajib dipilih atau diisi');
        return;
      }

      final uid = _uid;
      if (uid == null) {
        _snack('Scan kartu dulu');
        return;
      }

      context.read<StudentBloc>().add(
            StudentEvent.create(
              StudentCreateRequestModel(
                name: name,
                classId: classId,
                className: className,
                rfidUid: uid,
              ),
            ),
          );
      return;
    }

    // ---- Edit murid: hanya field yang berubah dikirim ----
    final i = widget.initial!;

    final request = StudentUpdateRequestModel(
      name: name != i.name ? name : null,
      classId: classId != null && classId != i.classId ? classId : null,
      className:
          classId == null && className != null && className != i.className
              ? className
              : null,
      isActive: _active != i.isActive ? _active : null,
    );

    if (request.isEmpty) {
      _snack('Tidak ada perubahan', error: false);
      return;
    }

    context.read<StudentBloc>().add(StudentEvent.update(i.id, request));
  }

  Widget _classField() {
    return BlocBuilder<ClassBloc, ClassState>(
      builder: (context, state) {
        final loading =
            state.maybeWhen(loading: () => true, orElse: () => false);
        if (loading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
          );
        }

        final names = state.maybeWhen(
          loaded: (items) => items.map((c) => c.name).toList(),
          orElse: () => <String>[],
        );

        final canPick = names.isNotEmpty;
        final value = (_selectedClass != null &&
                (names.contains(_selectedClass) ||
                    _selectedClass == _newClassOption))
            ? _selectedClass
            : null;
        final showNew = !canPick || value == _newClassOption;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (canPick)
              CustomDropdown(
                key: ValueKey('class-$value'),
                value: value,
                items: [...names, _newClassOption],
                label: 'Kelas',
                onChanged: (v) => setState(() => _selectedClass = v),
              ),
            if (showNew) ...[
              if (canPick) const SpaceHeight(16),
              CustomTextField(
                controller: newClassC,
                label: canPick ? 'Nama kelas baru' : 'Kelas',
                helperText: canPick
                    ? 'Kelas baru dibuat otomatis'
                    : 'Daftar kelas belum termuat. Ketik nama kelas, '
                        'kelas baru dibuat otomatis',
                prefixIcon: const Icon(Icons.class_outlined),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _cardSection(bool saving) {
    final i = widget.initial;
    final uid = isEdit ? i!.rfidUid : _uid;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Kartu RFID',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SpaceHeight(8),
          if (uid == null)
            const Text(
              'Belum ada kartu. Tekan "Scan kartu", lalu tempelkan kartu ke '
              'perangkat.',
              style: TextStyle(color: AppColors.gray),
            )
          else ...[
            Text(
              'UID: $uid',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
            const SpaceHeight(4),
            Text(
              isEdit
                  ? (i!.hasToken
                      ? 'Token anti kartu clone aktif'
                      : 'Belum bertoken (anti kartu clone belum aktif)')
                  : 'Token sudah ditulis ke kartu. Simpan dalam 5 menit.',
              style: const TextStyle(color: AppColors.gray, fontSize: 12),
            ),
          ],
          const SpaceHeight(12),
          Button.outlined(
            onPressed: isEdit ? _replaceCard : _scan,
            label: isEdit
                ? 'Ganti kartu'
                : (uid == null ? 'Scan kartu' : 'Scan ulang kartu'),
            icon: const Icon(Icons.nfc),
            disabled: saving,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Murid' : 'Tambah Murid')),
      body: BlocConsumer<StudentBloc, StudentState>(
        listener: (context, state) {
          state.maybeWhen(
            saveFailed: (message) => _snack(message),
            saved: (message) {
              _snack(message, error: false);
              Navigator.pop(context, true);
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          final saving =
              state.maybeWhen(saving: () => true, orElse: () => false);

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CustomTextField(
                controller: nameC,
                label: 'Nama',
                textCapitalization: TextCapitalization.words,
                prefixIcon: const Icon(Icons.person_outline),
                readOnly: saving,
              ),
              const SpaceHeight(16),
              _classField(),
              const SpaceHeight(16),
              _cardSection(saving),
              if (isEdit) ...[
                const SpaceHeight(8),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Murid aktif',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  subtitle: const Text(
                    'Murid nonaktif tidak bisa absen (kartu dianggap tidak '
                    'terdaftar). Riwayat absensi tetap tersimpan.',
                  ),
                  value: _active,
                  onChanged: saving
                      ? null
                      : (value) => setState(() => _active = value),
                ),
              ],
              const SpaceHeight(24),
              Button.filled(
                onPressed: _submit,
                label: saving
                    ? 'Menyimpan...'
                    : (isEdit ? 'Simpan' : 'Tambah murid'),
                disabled: saving,
              ),
            ],
          );
        },
      ),
    );
  }
}
