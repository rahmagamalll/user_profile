import 'package:equatable/equatable.dart';

class PersonalInfoState extends Equatable {
  final bool isLoading;
  final bool isReadOnly;
  final bool isSuccess;
  final String? error;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? imagePath;

  const PersonalInfoState({
    this.isLoading = false,
    this.isReadOnly = true,
    this.isSuccess = false,
    this.error,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.imagePath,
  });

  PersonalInfoState copyWith({
    bool? isLoading,
    bool? isReadOnly,
    bool? isSuccess,
    String? error,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? imagePath,
  }) {
    return PersonalInfoState(
      isLoading: isLoading ?? this.isLoading,
      isReadOnly: isReadOnly ?? this.isReadOnly,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isReadOnly,
        isSuccess,
        error,
        firstName,
        lastName,
        email,
        phone,
        imagePath,
      ];
}
