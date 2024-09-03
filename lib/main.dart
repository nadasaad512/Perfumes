import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:perfumes/UI/HomeScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'UI/SplashScreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return  MaterialApp(
          locale: Locale('ar', ''), // Arabic locale
          supportedLocales: [
            Locale('ar', ''), // Arabic
            Locale('en', ''), // English (or any other supported locales)
          ],
          localizationsDelegates: [
            // Default Flutter delegates
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            // Check if the current device locale is supported, if not, fallback to the first one
            for (var supportedLocale in supportedLocales) {
              if (supportedLocale.languageCode == locale?.languageCode &&
                  supportedLocale.countryCode == locale?.countryCode) {
                return supportedLocale;
              }
            }
            return supportedLocales.first;
          },
          debugShowCheckedModeBanner: false,
          title: 'عطوري',
          home: SplashScreen(),
        );
      },

    );
  }
}
