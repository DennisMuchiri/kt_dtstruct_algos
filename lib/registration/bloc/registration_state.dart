import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/registration/registration_model.dart';

abstract class RegistrationState extends Equatable{
  const RegistrationState();

  @override
  List<Object> get props => [];
}

class RegistrationInitial extends RegistrationState {
  const RegistrationInitial();
}

class RegistrationLoading extends RegistrationState {}


class RegistrationSubmitting extends RegistrationState {}

class RegistrationSubmitted extends RegistrationState {
  final RegisterResponse registrationResponse;

  const RegistrationSubmitted({@required this.registrationResponse});//: assert(registrationResponse != null);

  @override
  List<Object>get props => [registrationResponse];
}

class ClaimSearchSubmitting extends RegistrationState {}



class RegistrationError extends RegistrationState{
  final String message;
  const RegistrationError(this.message);
}