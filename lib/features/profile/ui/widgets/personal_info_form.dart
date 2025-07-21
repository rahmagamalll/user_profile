import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_profile/core/helper/spacing.dart';
import 'package:user_profile/core/theming/styles.dart';
import 'package:user_profile/core/widgets/custom_elevation_button.dart';
import 'package:user_profile/core/widgets/custom_snack_bar.dart';
import 'package:user_profile/core/widgets/custom_text_form_field.dart';
import 'package:user_profile/features/profile/logic/cubit/personal_info_cubit.dart';
import 'package:user_profile/features/profile/logic/cubit/personal_info_state.dart';
import 'package:user_profile/features/profile/ui/widgets/user_image.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String? imagePathFromGallery;

  @override
  void initState() {
    super.initState();
    context.read<PersonalInfoCubit>().loadUserData();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonalInfoCubit, PersonalInfoState>(
      listenWhen: (prev, curr) =>
          curr.isSuccess || curr.error != null,
      listener: (context, state) {
        if (state.isSuccess) {
          CustomSnackBar.show(context, 'Saved Successfully');
          context.read<PersonalInfoCubit>().resetSuccessFlag();
        } else if (state.error != null) {
          CustomSnackBar.show(context, 'Error: ${state.error}');
        }
      },
      child: BlocBuilder<PersonalInfoCubit, PersonalInfoState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          firstNameController.text = state.firstName ?? '';
          lastNameController.text = state.lastName ?? '';
          emailController.text = state.email ?? '';
          phoneController.text = state.phone ?? '';
          imagePathFromGallery = state.imagePath;

          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpacing(20),
                UserImage(
                  onChangedPhoto: (value) {
                    imagePathFromGallery = value;
                  },
                ),
                verticalSpacing(20),

                /// First Name
                Text('First name',
                    style: TextStylesManager.font18Bold(context)),
                verticalSpacing(10),
                CustomTextFormField(
                  controller: firstNameController,
                  readOnly: state.isReadOnly,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your first name';
                    }
                    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                    if (!nameRegex.hasMatch(value.trim())) {
                      return 'Only letters are allowed';
                    }
                    return null;
                  },
                  hintText: 'first name',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 13.h,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  hintStyle: TextStylesManager.font16Medium(context),
                ),
                verticalSpacing(15),

                /// Last Name
                Text('Last name',
                    style: TextStylesManager.font18Bold(context)),
                verticalSpacing(10),
                CustomTextFormField(
                  controller: lastNameController,
                  readOnly: state.isReadOnly,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your last name';
                    }
                    final RegExp nameRegex = RegExp(r'^[a-zA-Z]+$');
                    if (!nameRegex.hasMatch(value.trim())) {
                      return 'Only letters are allowed';
                    }
                    return null;
                  },
                  hintText: 'last name',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 13.h,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  hintStyle: TextStylesManager.font16Medium(context),
                ),
                verticalSpacing(15),

                /// Email
                Text('Email', style: TextStylesManager.font18Bold(context)),
                verticalSpacing(10),
                CustomTextFormField(
                  controller: emailController,
                  readOnly: state.isReadOnly,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    final RegExp emailRegex =
                        RegExp(r'^[\w]+@([\w-]+\.)+[\w-]{3}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                  hintText: 'email',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 13.h,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  hintStyle: TextStylesManager.font16Medium(context),
                ),
                verticalSpacing(15),

                /// Phone
                Text('Phone Number',
                    style: TextStylesManager.font18Bold(context)),
                verticalSpacing(10),
                CustomTextFormField(
                  controller: phoneController,
                  readOnly: state.isReadOnly,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    final RegExp phoneRegex =
                        RegExp(r'^01[0125][0-9]{8}$');
                    if (!phoneRegex.hasMatch(value.trim())) {
                      return 'Enter a valid Egyptian phone number';
                    }
                    return null;
                  },
                  hintText: 'phone number',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 13.h,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                  hintStyle: TextStylesManager.font16Medium(context),
                ),
                verticalSpacing(40),

                /// Save / Edit Button
                Row(
                  children: [
                    Expanded(
                      child: CustomElevationButton(
                        onPressed: () {
                          if (state.isReadOnly) {
                            context
                                .read<PersonalInfoCubit>()
                                .toggleEditMode();
                          } else {
                            if (_formKey.currentState!.validate()) {
                              context.read<PersonalInfoCubit>().saveUserData(
                                    firstName:
                                        firstNameController.text.trim(),
                                    lastName:
                                        lastNameController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: phoneController.text.trim(),
                                    imagePath: imagePathFromGallery,
                                  );
                            }
                          }
                        },
                        title: state.isReadOnly ? 'Edit' : 'Save',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
