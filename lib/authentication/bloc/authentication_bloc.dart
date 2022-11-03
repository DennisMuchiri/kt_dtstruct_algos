
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/authentication/authentication_repository.dart';
import 'package:loyaltyapp/user/user_model.dart';
import 'package:loyaltyapp/user/user_repository.dart';

part 'authentication_state.dart';
part 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent,AuthenticationState> {
  AuthenticationBloc({
   @required AuthenticationRepository authenticationRepository,
    @required UserRepository userRepository
}) : assert(authenticationRepository != null),
        assert(userRepository != null),
    _authenticationRepository = authenticationRepository,
  _userRepository = userRepository,
  super(const AuthenticationState.unknown()){
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
        (status) => add(AuthenticationStatusChanged(status))
    );
  }
  
  final  AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      )async* {
    if(event  is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    }else if (event is AuthenticationLogoutRequested){
      _authenticationRepository.logOut();
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    _authenticationRepository.dispose();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event,
      )async {
      switch(event.status){
        case AuthenticationStatus.unauthenticated:
          return const AuthenticationState.unauthenticated();
          break;
        case AuthenticationStatus.authenticated:
          final user = await _tryGetUser();
          return user != null
            ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated();
          break;
        default:
          return const AuthenticationState.unknown();
      }
  }

  Future<User> _tryGetUser() async {
    try{
      final user =  await _userRepository.getUser();
      return user;
    }on Exception{
      return null;
    }
  }
}
