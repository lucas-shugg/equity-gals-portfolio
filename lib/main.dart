import 'package:flutter/material.dart';
import 'portfolio/portfolio_page.dart';

void main() {
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
      title: 'EGP Portfolio',
      // This is the theme of your application.
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
