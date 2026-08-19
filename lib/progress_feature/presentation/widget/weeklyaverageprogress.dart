import 'package:faith/colorapp.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Weeklyaverageprogress extends StatelessWidget {
  const Weeklyaverageprogress({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: width,
          height: height * 0.35,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Weekly Average",
                          style: TextStyle(
                            color: AppColors.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "81%",
                          style: TextStyle(
                            color: AppColors.emeraldGreen,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.emeraldGreen.withOpacity(0.15),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            size: 18,
                            color: AppColors.emeraldGreen,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            "8% this week",
                            style: TextStyle(
                              color: AppColors.emeraldGreen,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: LineChart(
                    LineChartData(
                      minY: 60,
                      maxY: 100,

                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),

                      borderData: FlBorderData(show: false),

                      titlesData: FlTitlesData(
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const days = [
                                'Mon',
                                'Tue',
                                'Wed',
                                'Thu',
                                'Fri',
                                'Sat',
                                'Sun',
                              ];

                              if (value.toInt() >= 0 &&
                                  value.toInt() < days.length) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    days[value.toInt()],
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                      ),

                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 72),
                            FlSpot(1, 78),
                            FlSpot(2, 74),
                            FlSpot(3, 82),
                            FlSpot(4, 79),
                            FlSpot(5, 88),
                            FlSpot(6, 81),
                          ],
                          isCurved: true,
                          barWidth: 4,
                          color: AppColors.emeraldGreen,

                          dotData: FlDotData(show: true),

                          belowBarData: BarAreaData(
                            show: true,
                            color: AppColors.emeraldGreen.withOpacity(0.15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}