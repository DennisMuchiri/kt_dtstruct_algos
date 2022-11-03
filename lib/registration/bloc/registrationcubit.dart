import 'package:bloc/bloc.dart';
import 'package:loyaltyapp/registration/registration_repository.dart';
import 'package:loyaltyapp/registration/bloc/registration_state.dart';
import 'package:loyaltyapp/registration/registration_model.dart';


class RegistrationCubit extends Cubit<RegistrationState> {
  RegistrationRepository registrationRepository;

  RegistrationCubit(this.registrationRepository) : super(RegistrationInitial());

  Future<RegistrationModel> register(RegistrationModel registrationModel) async {
    try {
      emit(RegistrationSubmitting());
      final registrationResponse = await registrationRepository.add(registrationModel);
      emit(RegistrationSubmitted(registrationResponse: registrationResponse));
    } catch (e) {
      print(e.toString());
      emit(RegistrationError("No Network"));
    }
  }
}