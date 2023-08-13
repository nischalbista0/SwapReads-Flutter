import 'package:flutter/material.dart';

import '../config/constants/app_color_theme.dart';
import '../config/router/app_route.dart';
import '../proximity.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ProximityBrightnessControl(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SwapReads',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: AppColors.primaryColor,
            secondary: AppColors.secondaryColor,
          ),
          // customize appbar
          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.appBarColor,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          fontFamily: 'Poppins',
        ),
        initialRoute: AppRoute.splashRoute,
        routes: AppRoute.getApplicationRoute(),
      ),
    );
  }
}
