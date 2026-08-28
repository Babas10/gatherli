import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/base_bloc.dart';
import 'package:play_with_me/features/auth/domain/repositories/auth_repository.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_event.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_state.dart';

class AuthenticationBloc
    extends BaseBloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository _authRepository;

  AuthenticationBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(const AuthenticationUnknown()) {
    on<AuthenticationStarted>(_onAuthenticationStarted);
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
  }

  void _onAuthenticationStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) {
    debugPrint('🔐 AuthenticationBloc: Starting authentication monitoring');

    trackSubscription(
      _authRepository.authStateChanges.listen(
        (user) {
          debugPrint(
            '🔐 AuthenticationBloc: Auth state changed - user: ${user?.email ?? 'null'}',
          );
          add(AuthenticationUserChanged(user));
        },
        onError: (error) {
          debugPrint(
            '❌ AuthenticationBloc: Error in auth state stream: $error',
          );
          add(const AuthenticationUserChanged(null));
        },
      ),
    );
  }

  void _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthenticationState> emit,
  ) {
    if (event.user != null) {
      debugPrint(
        '✅ AuthenticationBloc: User authenticated - ${event.user!.email}',
      );
      emit(AuthenticationAuthenticated(event.user!));
    } else {
      debugPrint('🚫 AuthenticationBloc: User unauthenticated');
      emit(const AuthenticationUnauthenticated());
    }
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      debugPrint('🔐 AuthenticationBloc: Logout requested');
      await _authRepository.signOut();
      debugPrint('✅ AuthenticationBloc: Logout successful');
    } catch (error) {
      debugPrint('❌ AuthenticationBloc: Logout failed: $error');
      // The auth state stream will handle the state change
      // We don't emit error states here as this is a global bloc
    }
  }
}
