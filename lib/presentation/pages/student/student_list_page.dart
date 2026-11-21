import 'dart:async';

import 'package:absensi/core/core.dart';
import 'package:absensi/data/model/response/student/student_response_model.dart';
import 'package:absensi/presentation/bloc/student/student_bloc.dart';
import 'package:absensi/presentation/pages/student/student_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final searchC = TextEditingController();
  Timer? _debounce;
  bool? _active; // null = semua

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchC.dispose();
    super.dispose();
  }

  void _load() {
    context.read<StudentBloc>().add(
          StudentEvent.getList(q: searchC.text, active: _active),
        );
  }

  void _onSearch(String _) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 400), _load);
  }

  Future<void> _open([StudentModel? student]) async {
    await context.push<bool>(StudentFormPage(initial: student));
    if (!mounted) return;
    _load();
  }

  Widget _chip(String label, bool? value) {
    return ChoiceChip(
      label: Text(label),
      selected: _active == value,
      onSelected: (_) {
        setState(() => _active = value);
        _load();
      },
    );
  }

  Widget _tile(StudentModel s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.stroke),
      ),
      child: ListTile(
        onTap: () => _open(s),
        leading: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Text(
            s.name.isEmpty ? '?' : s.name[0].toUpperCase(),
            style: const TextStyle(color: AppColors.white),
          ),
        ),
        title: Text(
          s.name,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle:
            Text('${s.className.isEmpty ? '-' : s.className}  •  ${s.rfidUid}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!s.isActive)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  'Nonaktif',
                  style: TextStyle(color: AppColors.red, fontSize: 12),
                ),
              ),
            Tooltip(
              message: s.hasToken ? 'Token aktif' : 'Belum bertoken',
              child: Icon(
                s.hasToken ? Icons.verified : Icons.warning_amber_rounded,
                color: s.hasToken ? Colors.green : Colors.orange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Murid dan Kartu')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        onPressed: () => _open(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: SearchInput(
              controller: searchC,
              onChanged: _onSearch,
              hintText: 'Cari nama, kelas, atau UID',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                children: [
                  _chip('Semua', null),
                  _chip('Aktif', true),
                  _chip('Nonaktif', false),
                ],
              ),
            ),
          ),
          const SpaceHeight(8),
          Expanded(
            child: BlocBuilder<StudentBloc, StudentState>(
              buildWhen: (_, current) => current.maybeWhen(
                initial: () => true,
                listLoading: () => true,
                listLoaded: (_) => true,
                listFailed: (_) => true,
                orElse: () => false,
              ),
              builder: (context, state) {
                return state.maybeWhen<Widget>(
                  listLoaded: (items) {
                    if (items.isEmpty) {
                      return const Center(child: Text('Belum ada murid.'));
                    }

                    return RefreshIndicator(
                      onRefresh: () async => _load(),
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 88),
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
                  orElse: () =>
                      const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
