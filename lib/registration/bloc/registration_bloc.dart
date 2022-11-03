import 'dart:async';

import 'package:loyaltyapp/networking/api_reponse.dart';
import 'package:loyaltyapp/registration/registration_model.dart';
import 'package:loyaltyapp/registration/registration_repository.dart';

class RegistrationBloc {
  RegistrationRepository _registrationRepository;
  StreamController _what3WordsStreamController;

  StreamSink<ApiResponse<What3WordsResponse>> get what3wordsSink => _what3WordsStreamController.sink;
  Stream<ApiResponse<What3WordsResponse>> get what3wordsStream => _what3WordsStreamController.stream;

  RegistrationBloc() {
    _registrationRepository = RegistrationRepository();
    _what3WordsStreamController = StreamController<ApiResponse<What3WordsResponse>>.broadcast();
  }

  add(RegistrationModel registrationModel) async {
    try{
      print(registrationModel.email);
        var response =  await _registrationRepository.add(registrationModel);
        print(response.toString());

        return ApiResponse.completed(response);
      //  return response;
    }catch(e){
      print(e.toString());
      ApiResponse.error(e.toString());
    }
  }

  fetchWhat3Words(What3Words what3words) async {
    what3wordsSink.add(ApiResponse.loading("Fetch What 3 Words"));
    try{
      final response = await _registrationRepository.getWhat3Words(what3words);
      //return response.what3words;
      what3wordsSink.add(ApiResponse.completed(response));
    }catch(e){
      print(e.toString());
      what3wordsSink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose(){
    _what3WordsStreamController?.close();
  }
}
