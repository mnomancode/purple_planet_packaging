import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:purple_planet_packaging/app/core/utils/app_colors.dart';
import 'package:purple_planet_packaging/app/core/utils/app_utils.dart';


import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.read(routerProvider);
    return ScreenUtilInit(
        designSize: AppUtils.isTablet(context) ? const Size(768, 1024) : const Size(390, 884),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          final appTheme = ref.read(appThemeProvider);
          return MaterialApp.router(
            title: 'Purple Planet Packaging',
            color: AppColors.primaryColor,
            // localizationsDelegates: const [
            //   S.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: S.delegate.supportedLocales,
            // locale: const Locale('en', 'US'),
            // localeResolutionCallback: (deviceLocale, supportedLocales) {
            //   for (var locale in supportedLocales) {
            //     if (locale.languageCode == deviceLocale!.languageCode &&
            //         locale.countryCode == deviceLocale.countryCode) {
            //       return deviceLocale;
            //     }
            //   }
            //   return supportedLocales.first;
            // },
            theme: appTheme.lightTheme,
            // darkTheme: appTheme.darkTheme,

            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => 'Purple Planet Packaging',
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
            routerDelegate: router.routerDelegate,
          );
        });
  }
}
