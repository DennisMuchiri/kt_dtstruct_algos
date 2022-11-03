import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:loyaltyapp/claim/bloc/claim_state.dart';
import 'package:loyaltyapp/claim/claim_model.dart';
import 'package:loyaltyapp/claim/claim_repository.dart';

class ClaimCubit extends Cubit<ClaimState> {
  ClaimRepository claimRepository;

  ClaimCubit(this.claimRepository) : super(ClaimInitial());

  Future<List<Claim>> fetchClaims() async {
    try {
      emit(ClaimLoading());
      final claims = await claimRepository.fetchClaims();

      emit(ClaimLoaded(claims: claims));
    } catch (e) {
      emit(ClaimError(e.toString()));
    }
  }

  Future<List<Claim>> filterClaims(ClaimFilter filter) async {
    try {
      emit(ClaimFiltering());
      final claims = await claimRepository.filterClaims(filter);
    print("emot");
      emit(ClaimFiltered(claims: claims));
    } catch (e) {
      emit(ClaimError(e.toString()));
    }
  }

  Future<List<Claim>> search(Claim claim) async {
    try {
      emit(ClaimSearchSubmitting());
      final claims = await claimRepository.searchClaim(claim);
      var list = claims == null ? new List<Claim>() : claims;
      emit(ClaimSearchSubmitted(claimSearchResponse: list));
    } catch (e) {
      print(e.toString());
      emit(ClaimError("No Network"));
    }
  }

  Future<Claim> fetchById(String id) async {
    try{
      emit(ClaimFetchByIdSubmitting());
      final claim = await claimRepository.fetchClaim(id);
      emit(ClaimFetchByIdSubmitted(claimFetchByIdResponse: claim));
    }catch(e){
      print(e.toString());
      emit(ClaimError(e.toString()));
    }
  }

  Future<Claim> addClaim(Claim claim) async {
    try {
      emit(ClaimSubmitting());
      final claimResponse = await claimRepository.addClaim(claim);
      emit(ClaimSubmitted(claimResponse: claimResponse));
    } catch (e) {
      print(e.toString());
      emit(ClaimError("No Network"));
    }
  }

  Future<ClaimDisputeReplyResponse> dispute(ClaimDisputeReply claimDisputeReply) async {
    try {
      emit(ClaimDisputing());
      final response = await claimRepository.addDispute(claimDisputeReply);
      emit(ClaimDisputeSubmitted(claimDisputeReplyResponse: response));
      //return response;
    } catch (e) {
      print(e);
      emit(ClaimError(e.toString()));
      //return e;
    }
  }
}
