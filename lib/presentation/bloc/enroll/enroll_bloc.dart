import 'dart:async';

import 'package:absensi/data/datasources/enroll_remote_datasource.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'enroll_event.dart';
part 'enroll_state.dart';
part 'enroll_bloc.freezed.dart';

/// Satu sesi scan kartu: mengaktifkan mode daftar di server lalu memeriksa
/// status secara berkala sampai kartu siap, kartu sudah dipakai, waktu habis,
/// atau terjadi kegagalan.
class EnrollBloc extends Bloc<EnrollEvent, EnrollState> {
  static const writeTimeoutMessage =
      'Token belum selesai ditulis ke kartu. Pastikan perangkat menyala dengan '
      'sketch versi final, lalu scan ulang.';

  final EnrollRemoteDatasource remoteDatasource;
  final Duration pollInterval;
  final Duration writeTimeout;

  Timer? _timer;
  int _session = 0;
  bool _polling = false;
  DateTime? _writingSince;

  EnrollBloc(
    this.remoteDatasource, {
    this.pollInterval = const Duration(seconds: 1),
    this.writeTimeout = const Duration(seconds: 60),
  }) : super(const _Initial()) {
    on<_Start>(_onStart);
    on<_Poll>(_onPoll);
    on<_Cancel>(_onCancel);
  }

  void _stop() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _onStart(
    _Start event,
    Emitter<EnrollState> emit,
  ) async {
    _stop();
    final session = ++_session;
    _writingSince = null;
    _polling = false;

    emit(const EnrollState.starting());

    final res = await remoteDatasource.start();
    if (session != _session) return;

    res.fold(
      (l) => emit(EnrollState.failed(l)),
      (r) {
        emit(EnrollState.waiting(r.expiresIn));
        _timer = Timer.periodic(pollInterval, (_) {
          if (!isClosed) add(const EnrollEvent.poll());
        });
      },
    );
  }

  Future<void> _onPoll(
    _Poll event,
    Emitter<EnrollState> emit,
  ) async {
    if (_polling) return; // satu pemeriksaan pada satu waktu

    final session = _session;
    _polling = true;

    try {
      final res = await remoteDatasource.status();
      if (session != _session) return;

      res.fold(
        (l) {
          _stop();
          emit(EnrollState.failed(l));
        },
        (r) {
          final c = r.captured;

          // Kartu sudah dipakai murid atau guru lain
          if (c != null && c.registered) {
            _stop();
            emit(EnrollState.alreadyUsed(
              uid: c.uid,
              ownerName: c.ownerName,
              ownerType: c.ownerType,
            ));
            return;
          }

          if (c != null) {
            // Token sudah tertulis di kartu dan dikonfirmasi perangkat
            if (r.cardTokenConfirmed == true) {
              _stop();
              emit(EnrollState.ready(c.uid));
              return;
            }

            // Perangkat sedang menulis token
            final since = _writingSince ??= DateTime.now();
            if (DateTime.now().difference(since) > writeTimeout) {
              _stop();
              emit(const EnrollState.failed(writeTimeoutMessage));
              return;
            }
            emit(EnrollState.writing(c.uid));
            return;
          }

          // Belum ada kartu dan mode daftar sudah mati: waktu habis
          if (!r.active) {
            _stop();
            emit(const EnrollState.expired());
            return;
          }

          emit(EnrollState.waiting(r.expiresIn));
        },
      );
    } finally {
      _polling = false;
    }
  }

  Future<void> _onCancel(
    _Cancel event,
    Emitter<EnrollState> emit,
  ) async {
    _stop();
    _session++;
    _writingSince = null;

    await remoteDatasource.cancel();
    emit(const EnrollState.initial());
  }

  @override
  Future<void> close() {
    _stop();
    return super.close();
  }
}