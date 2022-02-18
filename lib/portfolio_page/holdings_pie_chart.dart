import 'package:equity_gals_portfolio/portfolio_page/portfolio_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/portfolio_holding.dart';

class HoldingsPieChart extends StatefulWidget {
  const HoldingsPieChart(
      {Key? key, required this.portfolio, required this.stockHoveredOver})
      : super(key: key);
  final Map<String, PortfolioHolding> portfolio;
  final ValueNotifier<String?> stockHoveredOver;

  @override
  State<HoldingsPieChart> createState() => PieChartState();
}

class PieChartState extends State<HoldingsPieChart> {
  @override
  void initState() {
    super.initState();
    // Rebuild the widget when a stock is hovered over to apply highlighting and
    // growth to widget
    widget.stockHoveredOver.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
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
                  widget.stockHoveredOver.value = null;
                  return;
                }
                // Assumes AX region, would need to refactor if expanded to global
                // regions.
                widget.stockHoveredOver.value = pieTouchResponse
                    .touchedSection?.touchedSection?.title
                    .split("\n")
                    .first;
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
    portfolioHoldingsList.sort((a, b) {
      var weightComparison = a.value.holdingWeightAsPercentage
          .compareTo(b.value.holdingWeightAsPercentage);
      // They are equal holding weight, use code to split difference
      if (weightComparison == 0) {
        // Code compare
        return a.key.compareTo(b.key);
      }
      return weightComparison;
    });

    int sectionNumber = 0;
    // Generate the sections
    return portfolioHoldingsList.map(
      (portfolioHolding) {
        // Using the section number before it is incremented gives us the section index
        final isHovered = widget.stockHoveredOver.value ==
            portfolioHolding.key.split(".").first;
        final fontSize = isHovered ? 25.0 : 20.0;
        final radius = isHovered ? 230.0 : 190.0;

        sectionNumber += 1;

        // Used to fan out the patterns so the names don't clash, fairly arbitrary calculation used that
        // works for the current number of stocks
        double titlePosition = (length + 3 - sectionNumber) / (length + 4);

        return PieChartSectionData(
          value: portfolioHolding.value.holdingWeightAsPercentage,
          title:
              "${portfolioHolding.key.split(".").first}\n${portfolioHolding.value.holdingWeightAsPercentage}%",
          radius: radius,
          // Inside the bracket becomes 200, 200 ..., 900
          color: Colors.teal[(sectionNumber + 1) * 100],
          titlePositionPercentageOffset: titlePosition,
          titleStyle: isHovered
              ? highlightedText.copyWith(fontSize: fontSize)
              : TextStyle(color: Colors.white, fontSize: fontSize),
        );
      },
    ).toList();
  }
}
