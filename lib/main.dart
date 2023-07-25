import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'features/homepage/hompage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      });
    });
  }
}
