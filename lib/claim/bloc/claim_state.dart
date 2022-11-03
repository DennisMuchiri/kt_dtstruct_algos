
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/claim/claim_model.dart';

abstract class ClaimState extends Equatable{
  const ClaimState();

  @override
  List<Object> get props => [];
}

class ClaimInitial extends ClaimState {
  const ClaimInitial();
}

class ClaimLoading extends ClaimState {}

class ClaimLoaded extends ClaimState {
  final List<Claim> claims;

  const ClaimLoaded({@required this.claims}); //: assert(claims != null)

  @override
  List<Object> get props => [claims];
}

class ClaimFiltering extends ClaimState {}

class ClaimFiltered extends ClaimState {
  final List<Claim> claims;

  const ClaimFiltered({@required this.claims}): assert(claims != null);

  @override
  List<Object> get props => [claims];
}

class ClaimSubmitting extends ClaimState {}

class ClaimSubmitted extends ClaimState {
  final Claim claimResponse;

  const ClaimSubmitted({@required this.claimResponse}): assert(claimResponse != null);

  @override
  List<Object>get props => [claimResponse];
}

class ClaimSearchSubmitting extends ClaimState {}

class ClaimSearchSubmitted extends ClaimState {
  final List<Claim> claimSearchResponse;


  const ClaimSearchSubmitted({@required this.claimSearchResponse}): assert(claimSearchResponse != null);

  @override
  List<Object>get props => [claimSearchResponse];
}

class ClaimFetchByIdSubmitting extends ClaimState {}

class ClaimFetchByIdSubmitted extends ClaimState {
  final Claim claimFetchByIdResponse;


  const ClaimFetchByIdSubmitted({@required this.claimFetchByIdResponse}): assert(claimFetchByIdResponse != null);

  @override
  List<Object>get props => [claimFetchByIdResponse];
}

class ClaimDisputing extends ClaimState {}

class ClaimDisputeSubmitted extends ClaimState {
  final ClaimDisputeReplyResponse claimDisputeReplyResponse;


  const ClaimDisputeSubmitted({@required this.claimDisputeReplyResponse}): assert(claimDisputeReplyResponse != null);

  @override
  List<Object>get props => [claimDisputeReplyResponse];
}

class ClaimError extends ClaimState{
  final String message;
  const ClaimError(this.message);
}