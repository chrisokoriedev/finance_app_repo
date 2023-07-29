import 'package:expense_app/model/create_expense.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'utils/routes.dart';

final nameProvider = Provider((ref) => 'Chris');
void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CreateExpenseModelAdapter());
  await Hive.openBox<CreateExpenseModel>('data');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp.router(
          routerConfig: AppRouter.router,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColor.kWhitColor,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.kBlueColor,
            ),
            useMaterial3: true,
          ),
        );
      });
    });
  }
}
