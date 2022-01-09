import 'package:equity_gals_portfolio/portfolio_page/portfolio_page.dart';
import 'portfolio_page.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EGPieChart extends StatefulWidget {
  final double maxContentWidth;
  const EGPieChart({Key? key, required this.maxContentWidth}) : super(key: key);

  @override
  State<EGPieChart> createState() => PieChartState();
}

class PieChartState extends State<EGPieChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Column(children: [
        Row(
          children: <Widget>[
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.3,
                child: PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 30,
                      sections: showingSections()),
                ),
              ),
            ),
            const SizedBox(width: 200),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(56, 88, 78, 1),
                  ),
                  SelectableText("AASF",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ]),
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(56, 125, 109, 1),
                  ),
                  SelectableText("IVV",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ]),
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(84, 164, 145, 1),
                  ),
                  SelectableText("IAA",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ]),
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(106, 191, 171, 1),
                  ),
                  SelectableText("IEU",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ]),
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(135, 214, 195, 1),
                  ),
                  SelectableText("IAF",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ]),
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(161, 223, 208, 1),
                  ),
                  SelectableText("AAA",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ]),
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(188, 239, 227, 1),
                  ),
                  SelectableText("VAP",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ]),
                Row(children: [
                  Container(
                    height: 32,
                    width: 32,
                    color: const Color.fromRGBO(208, 239, 232, 1),
                  ),
                  SelectableText("QAU",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontFamily: "AvenirLight", color: egpGreen))
                ])
              ],
            ),
            const SizedBox(
              width: 200,
            )
          ],
        ),
      ]),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(8, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 20.0;
      final radius = isTouched ? 150.0 : 120.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color.fromRGBO(56, 88, 78, 1),
            value: 35,
            title: '35%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 1:
          return PieChartSectionData(
            color: const Color.fromRGBO(56, 125, 109, 1),
            value: 12.5,
            title: '12.5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 2:
          return PieChartSectionData(
            color: const Color.fromRGBO(84, 164, 145, 1),
            value: 12.5,
            title: '12.5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 3:
          return PieChartSectionData(
            color: const Color.fromRGBO(106, 191, 171, 1),
            value: 12.5,
            title: '12.5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 4:
          return PieChartSectionData(
            color: const Color.fromRGBO(135, 214, 195, 1),
            value: 12.5,
            title: '12.5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 5:
          return PieChartSectionData(
            color: const Color.fromRGBO(161, 223, 208, 1),
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 6:
          return PieChartSectionData(
            color: const Color.fromRGBO(188, 239, 227, 1),
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );
        case 7:
          return PieChartSectionData(
            color: const Color.fromRGBO(208, 239, 232, 1),
            value: 5,
            title: '5%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          );

        default:
          throw Error();
      }
    });
  }
}
