import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../HeaderDashboard/header.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(height: 45.h, child: const DashboardHeader()),
        ),
       
      ],
    ));
  }
}
