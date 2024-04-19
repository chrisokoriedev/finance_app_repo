import 'package:expense_app/firebase_options.dart';
import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:expense_app/utils/string_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Hive.initFlutter();
  // Hive.registerAdapter(CreateExpenseModelAdapter());
  // await Hive.openBox<CreateExpenseModel>(AppString.hiveDb);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          title: AppString.appName,
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.kWhitColor,
            canvasColor: AppColor.kWhitColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.kBlueColor,
            ),
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
