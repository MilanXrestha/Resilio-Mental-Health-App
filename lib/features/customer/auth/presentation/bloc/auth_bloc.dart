import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../domain/usecases/facebook_signin_usecase.dart';
import '../../domain/usecases/google_signin_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/send_signin_link_usecase.dart';
import '../../domain/usecases/signin_with_email_link_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final SignUpUseCase _signUpUseCase;
  final GoogleSignInUseCase _googleSignInUseCase;
  final FacebookSignInUseCase _facebookSignInUseCase;
  final SendSignInLinkUseCase _sendSignInLinkUseCase;
  final SignInWithEmailLinkUseCase _signInWithEmailLinkUseCase;

  AuthBloc(
    this._loginUseCase,
    this._signUpUseCase,
    this._googleSignInUseCase,
    this._facebookSignInUseCase,
    this._sendSignInLinkUseCase,
    this._signInWithEmailLinkUseCase,
  ) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<FacebookSignInRequested>(_onFacebookSignInRequested);
    on<SendSignInLinkRequested>(_onSendSignInLinkRequested);
    on<SignInWithEmailLinkRequested>(_onSignInWithEmailLinkRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());

    try {
      final result = await _loginUseCase(
        LoginParams(
          email: event.email.trim(),
          password: event.password.trim(),
        ),
      );

      result.fold(
            (failure) => emit(AuthError(_mapFailureToMessage(failure))),
            (user) => emit(AuthAuthenticated(user)),
      );
    } catch (e) {
      emit(AuthError("Something went wrong. Please try again."));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _signUpUseCase(
      SignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _googleSignInUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onFacebookSignInRequested(
    FacebookSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _facebookSignInUseCase(const NoParams());

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSendSignInLinkRequested(
    SendSignInLinkRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _sendSignInLinkUseCase(
      SendSignInLinkParams(
        email: event.email,
        appUrl: event.appUrl,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (_) => emit(const SignInLinkSent()),
    );
  }

  Future<void> _onSignInWithEmailLinkRequested(
    SignInWithEmailLinkRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await _signInWithEmailLinkUseCase(
      SignInWithEmailLinkParams(
        email: event.email,
        link: event.link,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: Implement logout use case
    emit(AuthInitial());
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    // TODO: Implement logout use case
    emit(AuthInitial());
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.message;
  }
}
