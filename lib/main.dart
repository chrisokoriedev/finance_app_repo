  import 'package:expense_app/domain/theme.dart';
  import 'package:expense_app/firebase_options.dart';
import 'package:expense_app/provider/theme.dart';
  import 'package:expense_app/utils/string_app.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/services.dart';
  import 'package:flutter_easyloading/flutter_easyloading.dart';
  import 'package:hooks_riverpod/hooks_riverpod.dart';
  import 'package:responsive_sizer/responsive_sizer.dart';
  import 'package:shared_preferences/shared_preferences.dart';

  import 'provider/local_auth.dart';
  import 'utils/routes.dart';
  import 'utils/theme.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final sharedPreferences = await SharedPreferences.getInstance();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const MyApp(),
      ),
    );
  }

  class MyApp extends HookConsumerWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final themeCntrl = ref.watch(themeProvider);
      return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp.router(
            routerConfig: AppRouter.router,
            title: AppString.appName,
            debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: themeCntrl?ThemeMode.dark:ThemeMode.light,
          );
        },
      );
    }
  }
