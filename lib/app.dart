import 'package:e_commerce_app/bindings/general_bindings.dart';
import 'package:e_commerce_app/utils/constants/colors.dart';
import 'package:e_commerce_app/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ----Use this class to setup themes, initial bindings, any animation and much more
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // As we are using GetXController in the OnBoardingController Therefore we have to use the GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      // This themeMode will check weather our system is in dark or light mode and set theme accordingly
      theme: TAppTheme.lightTheme,
      // This is automatically for light theme.
      darkTheme: TAppTheme.darkTheme,
      // This is automatically for dark theme.
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: TColors.primaryColor,
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
