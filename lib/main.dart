import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_profile/core/routing/new_routing.dart';

void main() {
  runApp( ProfileApp());
}

class ProfileApp extends StatelessWidget {
   ProfileApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return MaterialApp.router(
          routerConfig: _appRouter.config(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.light),
       
        );
      },
    );
  }
}
