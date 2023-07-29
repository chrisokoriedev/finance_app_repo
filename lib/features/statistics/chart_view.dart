import 'package:expense_app/features/statistics/model/day_model.dart';
import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartComponent extends StatelessWidget {
  const ChartComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 35.h,
      child: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries(
              color: AppColor.kBlackColor,
              width: 4.0,
              dataSource: <SalesData>[
                SalesData('2001', 22),
                SalesData('2004', 2),
                SalesData('2008', 222),
                SalesData('2010', 25),
                SalesData('2011', 52),
                SalesData('2022', 72),
              ],
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.amount)
        ],
        // annotations: [],
      ),
    );
  }
}
