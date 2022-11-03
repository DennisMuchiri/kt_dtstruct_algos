import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/redemption/bloc/redemption_state.dart';
import 'package:loyaltyapp/redemption/redemption_model.dart';
import 'package:loyaltyapp/redemption/redemption_repository.dart';

class RedemptionCubit extends Cubit<RedemptionState> {
  RedemptionRepository redemptionRepository;

  RedemptionCubit(this.redemptionRepository) : super(RedemptionInitial());

  Future<List<Redemption>> fetchRedemptions() async {
    try {
      emit(RedemptionLoading());
      final redemptions = await redemptionRepository.fetchRedemptions();

      emit(RedemptionLoaded(redemptions: redemptions));
    } catch (e) {
      emit(RedemptionError(e.toString()));
    }
  }

  Future<List<Redemption>> search(Redemption redemption) async {
    try {
      emit(RedemptionSearchSubmitting());
      final redemptions = await redemptionRepository.searchRedemption(redemption);
      var list = redemptions == null ? new List<Redemption>() : redemptions;
      emit(RedemptionSearchSubmitted(redemptionSearchResponse: list));
    } catch (e) {
      print(e.toString());
      emit(RedemptionError("No Network"));
    }
  }

  Future<Redemption> fetchById(String id) async {
    try{
      emit(RedemptionFetchByIdSubmitting());
      final redemption = await redemptionRepository.fetchRedemption(id);
      emit(RedemptionFetchByIdSubmitted(redemptionFetchByIdResponse: redemption));
    }catch(e){
      print(e.toString());
      emit(RedemptionError(e.toString()));
    }
  }

  Future<Redemption> addRedemption(Redemption redemption) async {
    try {
      emit(RedemptionSubmitting());
      final redemptionResponse = await redemptionRepository.addRedemption(redemption);
      emit(RedemptionSubmitted(redemptionResponse: redemptionResponse));
    } catch (e) {
      print(e.toString());
      emit(RedemptionError("No Network"));
    }
  }

  Future<RedeemPointResponse> redeemPoint(RedeemPoint redeemPoint) async {
    try {
      emit(RedeemPointSubmitting());
      final redeemPointResponse = await redemptionRepository.redeemPoint(redeemPoint);
      emit(RedeemPointSubmitted(redemptionResponse: redeemPointResponse));
      return redeemPointResponse;
    } catch (e) {
      print(e.toString());
      emit(RedemptionError("No Network"));
    }
  }
}
