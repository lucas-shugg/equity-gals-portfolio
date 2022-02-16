import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/portfolio_holding.dart';

class HoldingsPieChart extends StatefulWidget {
  const HoldingsPieChart({Key? key, required this.portfolio}) : super(key: key);
  final Map<String, PortfolioHolding> portfolio;
  @override
  State<HoldingsPieChart> createState() => PieChartState();
}

class PieChartState extends State<HoldingsPieChart> {
  int? touchedIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(64.0),
      child: SizedBox(
        width: 500,
        height: 500,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = null;
                  return;
                }
                touchedIndex =
                    pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            }),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 30,
            sections: generateSections(),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> generateSections() {
    // If the portfolio is empty do no work
    if (widget.portfolio.entries.isEmpty) {
      return [];
    }

    int length = widget.portfolio.entries.length;

    assert(length <= 9,
        "As we use a color index to generate the colors and its only valid up too 900");

    // Get list and sort them by holding percentage
    final portfolioHoldingsList = widget.portfolio.entries.toList();
    portfolioHoldingsList.sort((a, b) => a.value.holdingWeightAsPercentage
        .compareTo(b.value.holdingWeightAsPercentage));

    int sectionNumber = 0;
    // Generate the sections
    return portfolioHoldingsList.map(
      (portfolioHolding) {
        // Using the section number before it is incremented gives us the section index
        final isTouched = sectionNumber == touchedIndex;
        final fontSize = isTouched ? 25.0 : 20.0;
        final radius = isTouched ? 250.0 : 200.0;

        sectionNumber += 1;

        // Used to fan out the patterns so the names don't clash, fairly aribratry calucation used that
        // works for the current number of stocks
        double titlePosition = (length + 3 - sectionNumber) / (length + 4);

        return PieChartSectionData(
          value: portfolioHolding.value.holdingWeightAsPercentage,
          title:
              "${portfolioHolding.key}\n${portfolioHolding.value.holdingWeightAsPercentage}%",
          radius: radius,
          color: Colors.teal[(sectionNumber + 1) *
              100], // Inside the bracket becomes 100, 200 ..., 900
          titlePositionPercentageOffset: titlePosition,
          titleStyle: TextStyle(color: Colors.white, fontSize: fontSize),
        );
      },
    ).toList();
  }
}
