import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_profile/core/helper/share_pref_helper.dart';
import 'package:user_profile/core/helper/shared_pref_keys.dart';
import 'package:user_profile/core/helper/spacing.dart';
import 'package:user_profile/core/theming/styles.dart';
import 'package:user_profile/core/widgets/custom_elevation_button.dart';
import 'package:user_profile/core/widgets/custom_snack_bar.dart';
import 'package:user_profile/core/widgets/custom_text_form_field.dart';
import 'package:user_profile/features/profile/ui/widgets/user_image.dart';

class PersonalInfoForm extends StatefulWidget {
  const PersonalInfoForm({super.key});

  @override
  State<PersonalInfoForm> createState() => _PersonalInfoFormState();
}

class _PersonalInfoFormState extends State<PersonalInfoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool readOnly = false;
  String? imagePathFromGallery;

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadDataFromSharedPrefs();
  }

  Future<void> _loadDataFromSharedPrefs() async {
    firstNameController.text =
        await SharePrefHelper.getString(SharedPrefKeys.userName) ?? '';
    lastNameController.text =
        await SharePrefHelper.getString(SharedPrefKeys.userLastName) ?? '';
    emailController.text =
        await SharePrefHelper.getString(SharedPrefKeys.email) ?? '';
    phoneController.text =
        await SharePrefHelper.getString(SharedPrefKeys.phone) ?? '';
    imagePathFromGallery = await SharePrefHelper.getString(
      SharedPrefKeys.userPhoto,
    );

    setState(() {
      readOnly = true;
    });
  }

  Future<void> _saveToSharedPrefs() async {
    await SharePrefHelper.setData(
      SharedPrefKeys.userName,
      firstNameController.text.trim(),
    );
    await SharePrefHelper.setData(
      SharedPrefKeys.userLastName,
      lastNameController.text.trim(),
    );
    await SharePrefHelper.setData(
      SharedPrefKeys.email,
      emailController.text.trim(),
    );
    await SharePrefHelper.setData(
      SharedPrefKeys.phone,
      phoneController.text.trim(),
    );
    if (imagePathFromGallery != null) {
      await SharePrefHelper.setData(
        SharedPrefKeys.userPhoto,
        imagePathFromGallery!,
      );
    }
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
          Text('First name', style: TextStylesManager.font18Bold(context)),
          verticalSpacing(10),
          CustomTextFormField(
            controller: firstNameController,
            readOnly: readOnly,
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
          Text('Last name', style: TextStylesManager.font18Bold(context)),
          verticalSpacing(10),
          CustomTextFormField(
            controller: lastNameController,
            readOnly: readOnly,
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
            readOnly: readOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              final RegExp emailRegex = RegExp(r'^[\w]+@([\w-]+\.)+[\w-]{3}$');
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
          Text('Phone Number', style: TextStylesManager.font18Bold(context)),
          verticalSpacing(10),
          CustomTextFormField(
            controller: phoneController,
            readOnly: readOnly,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your phone number';
              }
              final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
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
                  onPressed: () async {
                    if (!readOnly) {
                      if (_formKey.currentState!.validate()) {
                        await _saveToSharedPrefs();
                        setState(() {
                          readOnly = true;
                        });
                        // ignore: use_build_context_synchronously
                        CustomSnackBar.show(context, 'Save Successfully.');
                      }
                    } else {
                      setState(() {
                        readOnly = false;
                      });
                    }
                  },
                  title: readOnly ? 'Edit' : 'Save',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
