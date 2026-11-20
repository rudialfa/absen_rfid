import 'dart:async';

import 'package:absensi/data/datasources/api_helper.dart';
import 'package:absensi/data/datasources/auth_local_datsource.dart';
import 'package:absensi/data/datasources/auth_remote_datasource.dart';
import 'package:absensi/data/model/request/auth/login_request_model.dart';
import 'package:absensi/data/model/response/auth/auth_response_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRemoteDatasource remoteDatasource;
  final AuthLocalDatsource localDatasource;
  StreamSubscription<void>? _sub;

  AuthBloc(this.remoteDatasource, this.localDatasource)
      : super(const _Initial()) {
    on<_Started>(_onStarted);
    on<_Login>(_onLogin);
    on<_Logout>(_onLogout);
    on<_SessionExpired>(_onSessionExpired);

    // Server menolak token di request mana pun: otomatis keluar
    _sub = ApiHelper.onUnauthorized
        .listen((_) => add(const AuthEvent.sessionExpired()));
  }

  /// Dipanggil sekali saat aplikasi dibuka: cek token yang tersimpan.
  Future<void> _onStarted(
    _Started event,
    Emitter<AuthState> emit,
  ) async {
    final saved = await localDatasource.getAuthData();
    if (saved == null) {
      emit(const AuthState.unauthenticated());
      return;
    }

    final res = await remoteDatasource.me();
    await res.fold(
      (l) async {
        // Hanya token yang ditolak server yang dihapus. Kalau jaringan putus,
        // token tetap disimpan supaya bisa dicoba lagi.
        if (l == ApiHelper.sessionExpired) {
          try {
            await localDatasource.removeAuthData();
          } catch (_) {}
        }
        emit(AuthState.unauthenticated(message: l));
      },
      (r) async => emit(AuthState.authenticated(r.user)),
    );
  }

  Future<void> _onLogin(
    _Login event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthState.loading());

    final res = await remoteDatasource.login(event.request);
    await res.fold(
      (l) async => emit(AuthState.unauthenticated(message: l)),
      (r) async {
        try {
          await localDatasource.saveAuthData(r);
        } catch (_) {
          // Tetap masuk, tapi login tidak diingat setelah aplikasi ditutup
        }
        emit(AuthState.authenticated(r.user));
      },
    );
  }

  Future<void> _onLogout(
    _Logout event,
    Emitter<AuthState> emit,
  ) async {
    // Beri tahu server dulu (token masih dibutuhkan), hasilnya tidak menahan pengguna
    await remoteDatasource.logout();
    try {
      await localDatasource.removeAuthData();
    } catch (_) {}
    emit(const AuthState.unauthenticated());
  }

  Future<void> _onSessionExpired(
    _SessionExpired event,
    Emitter<AuthState> emit,
  ) async {
    final signedOut =
        state.maybeWhen(unauthenticated: (_) => true, orElse: () => false);
    if (signedOut) return;

    try {
      await localDatasource.removeAuthData();
    } catch (_) {}
    emit(const AuthState.unauthenticated(message: ApiHelper.sessionExpired));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}