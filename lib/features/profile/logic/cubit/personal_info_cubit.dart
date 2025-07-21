import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_profile/core/helper/share_pref_helper.dart';
import 'package:user_profile/core/helper/shared_pref_keys.dart';
import 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(const PersonalInfoState());

  Future<void> loadUserData() async {
    emit(state.copyWith(isLoading: true));
    try {
      final firstName =
          await SharePrefHelper.getString(SharedPrefKeys.userName) ?? '';
      final lastName =
          await SharePrefHelper.getString(SharedPrefKeys.userLastName) ?? '';
      final email =
          await SharePrefHelper.getString(SharedPrefKeys.email) ?? '';
      final phone =
          await SharePrefHelper.getString(SharedPrefKeys.phone) ?? '';
      final image =
          await SharePrefHelper.getString(SharedPrefKeys.userPhoto) ?? '';

      emit(state.copyWith(
        isLoading: false,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        imagePath: image,
        isReadOnly: true,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> saveUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    String? imagePath,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      await SharePrefHelper.setData(SharedPrefKeys.userName, firstName);
      await SharePrefHelper.setData(SharedPrefKeys.userLastName, lastName);
      await SharePrefHelper.setData(SharedPrefKeys.email, email);
      await SharePrefHelper.setData(SharedPrefKeys.phone, phone);
      if (imagePath != null) {
        await SharePrefHelper.setData(SharedPrefKeys.userPhoto, imagePath);
      }

      emit(state.copyWith(
        isLoading: false,
        isSuccess: true,
        isReadOnly: true,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
        imagePath: imagePath ?? state.imagePath,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void toggleEditMode() {
    emit(state.copyWith(isReadOnly: !state.isReadOnly));
  }

  void resetSuccessFlag() {
    emit(state.copyWith(isSuccess: false));
  }
}
