import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:user_profile/core/helper/spacing.dart';
import 'package:user_profile/core/routing/new_routing.gr.dart';
import 'package:user_profile/core/theming/styles.dart';
import 'package:user_profile/core/widgets/custom_elevation_button.dart';
import 'package:user_profile/core/widgets/top_app_bar.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const TopAppBar(title: 'Home',backarrow: false,)),
      body: Column(
        children: [
          verticalSpacing(100),
          Center(
            child: Text(
              'Welcome to the Home Screen!',
              style: TextStylesManager.font18Bold(context),
            ),
          ),
          Spacer(),
          CustomElevationButton(
            title: 'profile',
            onPressed: () {
              context.router.push(const ProfileRoute());
            },
          ),
          verticalSpacing(10),
        ],
      ),
    );
  }
}
