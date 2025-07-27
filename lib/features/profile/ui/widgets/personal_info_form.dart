import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart';
import 'package:user_profile/core/helper/spacing.dart';
import 'package:user_profile/core/theming/styles.dart';
import 'package:user_profile/core/widgets/custom_elevation_button.dart';
import 'package:user_profile/core/widgets/custom_snack_bar.dart';
import 'package:user_profile/core/widgets/custom_text_form_field.dart';
import 'package:user_profile/features/profile/data/enum/bunny_animation_enum.dart';
import 'package:user_profile/features/profile/logic/cubit/personal_info_cubit.dart';
import 'package:user_profile/features/profile/logic/cubit/personal_info_state.dart';

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

  Artboard? riveartboard;
  late RiveAnimationController controllerIdel;
  late RiveAnimationController controllerSuccess;
  late RiveAnimationController controllerFail;
  late RiveAnimationController controllerEyeCover;
  late RiveAnimationController controllerIntro;
  late RiveAnimationController controllerIdleLookAround;

  @override
  void initState() {
    super.initState();
    context.read<PersonalInfoCubit>().loadUserData();

    controllerIdel = SimpleAnimation(BunnyAnimation.idle.name);
    controllerSuccess = SimpleAnimation(BunnyAnimation.success.name);
    controllerFail = SimpleAnimation(BunnyAnimation.fail.name);
    controllerEyeCover = SimpleAnimation(BunnyAnimation.eye_cover.name);
    controllerIntro = SimpleAnimation(BunnyAnimation.Intro.name);
    controllerIdleLookAround = SimpleAnimation(
      BunnyAnimation.idle_look_around.name,
    );

    bunnyAnimationRive();
  }

  void bunnyAnimationRive() {
    rootBundle.load('assets/animation/bunny_login.riv').then((data) async {
      final file = RiveFile.import(data);

      final artboard = file.mainArtboard;
      artboard.addController(controllerIdleLookAround);

      setState(() {
        riveartboard = artboard;
      });
    });
  }

  void removeControllers() {
    riveartboard?.removeController(controllerIdel);
    riveartboard?.removeController(controllerSuccess);
    riveartboard?.removeController(controllerFail);
    riveartboard?.removeController(controllerEyeCover);
    riveartboard?.removeController(controllerIntro);
  }

  void idelAnimation() {
    removeControllers();
    riveartboard?.addController(controllerIdel);
  }

  void successAnimation() {
    removeControllers();
    riveartboard?.addController(controllerSuccess);
  }

  void failAnimation() {
    removeControllers();
    riveartboard?.addController(controllerFail);
  }

  void eyeCoverAnimation() {
    removeControllers();
    riveartboard?.addController(controllerEyeCover);
  }

  void introAnimation() {
    removeControllers();
    riveartboard?.addController(controllerIntro);
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
      listenWhen: (prev, curr) => curr.isSuccess || curr.error != null,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                  child:
                      riveartboard != null
                          ? Rive(artboard: riveartboard!)
                          : const SizedBox.shrink(),
                ),
                verticalSpacing(20),
                Text(
                  'First name',
                  style: TextStylesManager.font18Bold(context),
                ),
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
                      failAnimation();
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
                Text('Last name', style: TextStylesManager.font18Bold(context)),
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
                      failAnimation();
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
                Text(
                  'Phone Number',
                  style: TextStylesManager.font18Bold(context),
                ),
                verticalSpacing(10),
                CustomTextFormField(
                  controller: phoneController,
                  readOnly: state.isReadOnly,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your phone number';
                    }
                    final RegExp phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
                    if (!phoneRegex.hasMatch(value.trim())) {
                      failAnimation();
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
                verticalSpacing(130),

                /// Save / Edit Button
                Row(
                  children: [
                    Expanded(
                      child: CustomElevationButton(
                        onPressed: () {
                          if (state.isReadOnly) {
                            context.read<PersonalInfoCubit>().toggleEditMode();
                            idelAnimation();
                          } else {
                            if (_formKey.currentState!.validate()) {
                              context.read<PersonalInfoCubit>().saveUserData(
                                firstName: firstNameController.text.trim(),
                                lastName: lastNameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                imagePath: imagePathFromGallery,
                              );
                              successAnimation();
                              Future.delayed(const Duration(seconds: 2), () {
                                introAnimation();
                              });
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
