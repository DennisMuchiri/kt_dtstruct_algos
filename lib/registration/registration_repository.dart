
import 'package:loyaltyapp/networking/api_base_helper.dart';
import 'package:loyaltyapp/registration/registration_model.dart';

class RegistrationRepository {
  ApiBaseHelper _baseHelper = ApiBaseHelper();

  Future<RegisterResponse> add(RegistrationModel registrationModel) async {
    try{
      var response = await _baseHelper.post("register/add", registrationModel.toJson(),"");
      print(response);
      return RegisterResponse.fromJson(response);
    }catch(e){
      print(e.toString());
    }
  }

  Future<What3WordsResponse> getWhat3Words(What3Words what3words) async{

    //print("LAT ${what3words.lat}");
    Map<String,dynamic> response = await _baseHelper.get("register/what3words/${what3words.lat}/${what3words.long}","");
    //print(response);
    return What3WordsResponse.fromJson(response);
  }
}