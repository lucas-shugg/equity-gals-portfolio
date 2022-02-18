import 'package:flutter/foundation.dart';

import '../models/portfolio_holding.dart';
import 'holdings_pie_chart.dart';
import 'package:flutter/material.dart';

import 'description.dart';
import 'header.dart';
import 'podcast_button.dart';
import 'data_table.dart';
import '../models/stock.dart';
import 'title.dart';

const Color egpPink = Color.fromRGBO(242, 11, 249, 1);

const Color egpGreen = Color.fromRGBO(56, 88, 78, 1);

const highlightedText = TextStyle(
  fontWeight: FontWeight.bold,
  color: egpPink,
);

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  static double _maxContentWidth = 980;
  // 3rd Dec 2021 are when the prices have been recorded
  // This is our core data which we pass around use on this page
  Map<String, PortfolioHolding> portfolio = {
    "AASF.AX": PortfolioHolding(
      Stock('Airlie Australian\nShare Fund', 3.56),
      0.35,
    ),
    "VAP.AX": PortfolioHolding(
      Stock('Vanguard Australian\nProperty Secs ETF', 93.82),
      0.13,
    ),
    "IVV.AX": PortfolioHolding(
      Stock("IShares Core\nS&P 500 ETF", 647.84),
      0.13,
    ),
    "IEU.AX": PortfolioHolding(
      Stock("Europe IShares\nS&P Europe 350", 74.27),
      0.13,
    ),
    "IAA.AX": PortfolioHolding(
      Stock("IShares Asia\n50 ETF", 109.94),
      0.13,
    ),
    "QAU.AX": PortfolioHolding(
      Stock(
        'BetaShares Gold Bullion\nETF Currency Hedged',
        15.75,
      ),
      0.05,
    ),
    "IAF.AX": PortfolioHolding(
      Stock('iShares Core Composite\nBond ETF', 109.61),
      0.05,
    ),
    "AAA.AX": PortfolioHolding(
      Stock('BetaShares Aus High\nInterest Cash ETF', 50.06),
      0.05,
    ),
  };
  // Stock that the mouse is over, either on the pie chart or table
  // Used to highlight the pie chart and table so its easy to correlate the values.
  // Matches just on ticker not code (e.g Code QAU.AX is only compared using the ticker QAU)
  final _stockHoveredOver = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    if (width < 600) {
      _maxContentWidth = 520;
    } else if (width < 800) {
      _maxContentWidth = 680;
    } else if (width < 1000) {
      _maxContentWidth = 780;
    } else {
      _maxContentWidth = 980;
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: _maxContentWidth,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Header(
                egpGreen: egpGreen,
                egpPink: egpPink,
                logoScale: _maxContentWidth == 520 ? 1.25 : 1),
            const PortfolioTitle(egpPink: egpPink),
            Description(
              maxContentWidth: _maxContentWidth,
            ),
            const PodcastButton(egpGreen: egpGreen),
            ConditionalParentWidget(
              condition: _maxContentWidth == 520,
              conditionalBuilder: (child) => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: child,
              ),
              child: Portfolio(
                stockHoveredOver: _stockHoveredOver,
                maxContentWidth: _maxContentWidth,
                // The portfolio table only needs a map of stocks
                stocks:
                    portfolio.map((key, value) => MapEntry(key, value.stock)),
              ),
            ),
            HoldingsPieChart(
              portfolio: portfolio,
              stockHoveredOver: _stockHoveredOver,
            )
          ]),
        ),
      ),
    ));
  }
}

class ConditionalParentWidget extends StatelessWidget {
  const ConditionalParentWidget({
    Key? key,
    required this.condition,
    required this.child,
    required this.conditionalBuilder,
  }) : super(key: key);

  final Widget child;
  final bool condition;
  final Widget Function(Widget child) conditionalBuilder;

  @override
  Widget build(BuildContext context) {
    return condition ? conditionalBuilder(child) : child;
  }
}
