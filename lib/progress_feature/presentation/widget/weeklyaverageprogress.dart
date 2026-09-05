import 'package:faith/colorapp.dart';
import 'package:faith/firestoreServices.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Weeklyaverageprogress extends StatefulWidget {
  const Weeklyaverageprogress({super.key});

  @override
  State<Weeklyaverageprogress> createState() =>
      _WeeklyaverageprogressState();
}

class _WeeklyaverageprogressState extends State<Weeklyaverageprogress> {
  final Firestoreservices _firestoreService = Firestoreservices();

  List<double> weeklyScores = List.filled(7, 0);

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWeeklyData();
  }

  Future<void> loadWeeklyData() async {
    try {
      final allProgress = await _firestoreService.getAllProgress();

      final now = DateTime.now();

      // Monday of current week
      final monday = now.subtract(
        Duration(days: now.weekday - DateTime.monday),
      );

      List<double> scores = List.filled(7, 0);

      for (final data in allProgress) {
        final dateString = data['date'];

        if (dateString == null) continue;

        DateTime? date;

        try {
          date = DateTime.parse(dateString);
        } catch (e) {
          continue;
        }

        // Difference from Monday
        final difference = date.difference(
          DateTime(
            monday.year,
            monday.month,
            monday.day,
          ),
        ).inDays;

        // Current week only
        if (difference >= 0 && difference < 7) {
          final score = data['score'];

          if (score != null) {
            scores[difference] = (score as num).toDouble();
          }
        }
      }

      if (mounted) {
        setState(() {
          weeklyScores = scores;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Weekly chart error: $e');

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  double get weeklyAverage {
    final scoresWithData =
        weeklyScores.where((score) => score > 0).toList();

    if (scoresWithData.isEmpty) {
      return 0;
    }

    final total =
        scoresWithData.reduce((a, b) => a + b);

    return total / scoresWithData.length;
  }

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
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
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
                          "${weeklyAverage.round()}%",
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
                        borderRadius:
                            BorderRadius.circular(20),
                        color: AppColors.emeraldGreen
                            .withOpacity(0.15),
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
                            "This week",
                            style: TextStyle(
                              color:
                                  AppColors.emeraldGreen,
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
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.emeraldGreen,
                          ),
                        )
                      : LineChart(
                          LineChartData(
                            minY: 0,
                            maxY: 100,

                            gridData: FlGridData(
                              show: true,
                              drawVerticalLine: false,
                            ),

                            borderData:
                                FlBorderData(show: false),

                            titlesData: FlTitlesData(
                              topTitles: AxisTitles(
                                sideTitles:
                                    SideTitles(
                                  showTitles: false,
                                ),
                              ),

                              rightTitles: AxisTitles(
                                sideTitles:
                                    SideTitles(
                                  showTitles: false,
                                ),
                              ),

                              leftTitles: AxisTitles(
                                sideTitles:
                                    SideTitles(
                                  showTitles: true,
                                  reservedSize: 30,
                                  interval: 20,
                                ),
                              ),

                              bottomTitles: AxisTitles(
                                sideTitles:
                                    SideTitles(
                                  showTitles: true,
                                  interval: 1,
                                  getTitlesWidget:
                                      (value, meta) {
                                    const days = [
                                      'Mon',
                                      'Tue',
                                      'Wed',
                                      'Thu',
                                      'Fri',
                                      'Sat',
                                      'Sun',
                                    ];

                                    final index =
                                        value.toInt();

                                    if (index >= 0 &&
                                        index <
                                            days.length) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets
                                                .only(
                                          top: 8,
                                        ),
                                        child: Text(
                                          days[index],
                                          style:
                                              const TextStyle(
                                            fontSize: 12,
                                          ),
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
                                spots: List.generate(
                                  7,
                                  (index) {
                                    return FlSpot(
                                      index.toDouble(),
                                      weeklyScores[index],
                                    );
                                  },
                                ),

                                isCurved: true,

                                barWidth: 4,

                                color:
                                    AppColors.emeraldGreen,

                                dotData: FlDotData(
                                  show: true,
                                ),

                                belowBarData:
                                    BarAreaData(
                                  show: true,
                                  color: AppColors
                                      .emeraldGreen
                                      .withOpacity(0.15),
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