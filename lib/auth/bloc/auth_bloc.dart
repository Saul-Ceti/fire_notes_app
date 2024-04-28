import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fire_notes_app/auth/user_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _autRepo = UserAuthRepository();
  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerfication);
    on<AnonymousAuthEvent>(_authAnonymous);
    on<GoogleAuthEvent>(_authUser);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _authVerfication(event, emit) {
    // revisar si existe usuario autenticado
    if (_autRepo.isAlreadyAuthenticated()) {
      emit(AuthSuccessState());
    } else {
      emit(UnAuthState());
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    // Desloggear usuario
    await _autRepo.signOutGoogleUser();
    await _autRepo.signOutFirebaseUser();
    emit(SignOutSuccessState());
  }

  FutureOr<void> _authUser(event, emit) async {
    emit(AuthAwaitingState());
    try {
      // Loggear usuario
      await _autRepo.signInWithGoogle();
      emit(AuthSuccessState());
    } catch (e) {
      print("Error al autenticar: $e");
      emit(AuthErrorState());
    }
  }

  FutureOr<void> _authAnonymous(event, emit) async {
    await FirebaseAuth.instance.signInAnonymously();
  }
}
