
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/redemption/redemption_model.dart';

abstract class RedemptionState extends Equatable{
  const RedemptionState();

  @override
  List<Object> get props => [];
}

class RedemptionInitial extends RedemptionState {
  const RedemptionInitial();
}

class RedemptionLoading extends RedemptionState {}

class RedemptionLoaded extends RedemptionState {
  final List<Redemption> redemptions;

  const RedemptionLoaded({@required this.redemptions});//: assert(redemptions != null);

  @override
  List<Object> get props => [redemptions];
}

class RedemptionSubmitting extends RedemptionState {}

class RedemptionSubmitted extends RedemptionState {
  final Redemption redemptionResponse;

  const RedemptionSubmitted({@required this.redemptionResponse}): assert(redemptionResponse != null);

  @override
  List<Object>get props => [redemptionResponse];
}

class RedeemPointSubmitting extends RedemptionState {}

class RedeemPointSubmitted extends RedemptionState {
  final RedeemPointResponse redemptionResponse;

  const RedeemPointSubmitted({@required this.redemptionResponse}): assert(redemptionResponse != null);

  @override
  List<Object>get props => [redemptionResponse];
}

class RedemptionSearchSubmitting extends RedemptionState {}

class RedemptionSearchSubmitted extends RedemptionState {
  final List<Redemption> redemptionSearchResponse;


  const RedemptionSearchSubmitted({@required this.redemptionSearchResponse}): assert(redemptionSearchResponse != null);

  @override
  List<Object>get props => [redemptionSearchResponse];
}

class RedemptionFetchByIdSubmitting extends RedemptionState {}

class RedemptionFetchByIdSubmitted extends RedemptionState {
  final Redemption redemptionFetchByIdResponse;


  const RedemptionFetchByIdSubmitted({@required this.redemptionFetchByIdResponse}): assert(redemptionFetchByIdResponse != null);

  @override
  List<Object>get props => [redemptionFetchByIdResponse];
}

class RedemptionError extends RedemptionState{
  final String message;
  const RedemptionError(this.message);
}