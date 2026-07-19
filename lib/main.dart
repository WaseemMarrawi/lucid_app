import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:provider/provider.dart';
import 'package:restaurants_menu/router/app_router.dart';
import 'common/design/design.dart';
import 'common/design/src/theme/theme/theme_notifier.dart';
import 'common/helper/helper.dart';
import 'core/di/injection.dart';
import 'package:device_preview/device_preview.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureInjection();
  HydratedBloc.storage = getIt<HydratedStorage>();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en'), Locale('tr')],

      path: 'assets/translations',

      fallbackLocale: const Locale('ar'),

      child: ChangeNotifierProvider<AppThemeNotifier>(
        create: (_) => getIt<AppThemeNotifier>(),
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: DevicePreview(
        enabled: false,
        builder: (context) {
          return MaterialApp(
            navigatorKey: AppVariables.navigatorKey,
            localizationsDelegates: context.localizationDelegates,

            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: context.watch<AppThemeNotifier>().themeData,
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            initialRoute: RouteName.splash,
            onGenerateRoute: RouteManager.onGenerateRoute,
          );
        },
      ),
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 801, name: TABLET),
        const Breakpoint(start: 801, end: double.infinity, name: DESKTOP),
      ],
    );
  }
}
