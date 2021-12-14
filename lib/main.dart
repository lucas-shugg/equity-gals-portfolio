import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';
import 'portfolio/portfolio_page.dart';

void main() {
  // Flutter apps by default have a hash at the end of the url, (e.g portfolio.equitygal.com/#/). This removes the /#/
  setPathUrlStrategy();
  runApp(const EgpPortfolio());
}

class EgpPortfolio extends StatelessWidget {
  const EgpPortfolio({Key? key}) : super(key: key);
  static const defaultTextStyle =
      TextStyle(fontFamily: 'AvenirLight.ttf', color: egpGreen);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PORTFOLIO | equity gals',
      theme: ThemeData(
        dataTableTheme: const DataTableThemeData(
            headingTextStyle: defaultTextStyle,
            dataTextStyle: defaultTextStyle),
        canvasColor: const Color.fromRGBO(254, 238, 227, 1),
        textTheme: const TextTheme(
            bodyText1: defaultTextStyle, headline6: defaultTextStyle),
      ),
      home: const PortfolioPage(),
    );
  }
}
