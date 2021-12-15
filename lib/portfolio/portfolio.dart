import 'dart:convert';

import 'package:equity_gals_portfolio/portfolio/portfolio_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Portfolio extends StatefulWidget {
  final double maxContentWidth;

  const Portfolio({Key? key, required this.maxContentWidth}) : super(key: key);

  static const List<String> titleRow = [
    'ASSET CLASS',
    'CODE',
    '30 DAYS\nGROWTH %',
    'GROWTH SINCE\nINCEPTION %',
    'INFO'
  ];

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<double> prices = [];
  // 3rd  Dec
  List pricesBoughtAt = [
    3.56,
    459.26,
    109.94,
    74.27,
    109.61,
    50.06,
    93.82,
    15.75
  ];

  List<String?> percentageGrowth = List.filled(8, null);
  List<String?> thirtyDayGrowth = List.filled(8, null);

  @override
  void initState() {
    super.initState();

    const String mainEndpoint = "https://equity-gals-bff.herokuapp.com/yahoo";
    const String quoteEndPoint = "v6/finance/quote";

    const String symbols =
        "AASF.AX,IVV,IAA.AX,IEU.AX,IAF.AX,AAA.AX,VAP.AX,QAU.AX";
    // Get the current prices
    http
        .get(Uri.parse("$mainEndpoint/$quoteEndPoint?symbols=$symbols"))
        .then((value) {
      final json = jsonDecode(value.body);
      for (int i = 0; i < json["quoteResponse"]["result"].length; i++) {
        prices.add(json["quoteResponse"]["result"][i]["regularMarketPrice"]);
      }

      for (int i = 0; i < prices.length && i < pricesBoughtAt.length; i++) {
        percentageGrowth[i] =
            ((prices[i] - pricesBoughtAt[i]) * 100 / pricesBoughtAt[i])
                    .toStringAsFixed(2) +
                "%";
      }
      setState(() {});
    });

    const historyEndpoint = "v8/finance/spark";
    // Get the last thirty days of prices
    http
        .get(Uri.parse(
            "$mainEndpoint/$historyEndpoint?symbols=$symbols&range=30d&interval=1d"))
        .then((value) {
      final json = jsonDecode(value.body);
      // Get the price thirty days ago
      List thirtyDayPrices = [
        json["AASF.AX"]["close"][0],
        json["IVV"]["close"][0],
        json["IAA.AX"]["close"][0],
        json["IEU.AX"]["close"][0],
        json["IAF.AX"]["close"][0],
        json["AAA.AX"]["close"][0],
        json["VAP.AX"]["close"][0],
        json["QAU.AX"]["close"][0],
      ];

      for (int i = 0; i < thirtyDayPrices.length && i < prices.length; i++) {
        // Extract the percentage
        thirtyDayGrowth[i] =
            ((prices[i] - thirtyDayPrices[i]) * 100 / thirtyDayPrices[i])
                    .toStringAsFixed(2) +
                "%";
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 16,
      columns: Portfolio.titleRow
          .map((title) =>
              DataColumn(label: Flexible(child: SelectableText(title))))
          .toList(),
      rows: [
        _dataRowBuilder(
          'Airlie Australian\nShare Fund',
          'AASF',
          thirtyDayGrowth[0],
          percentageGrowth[0],
          'blank',
        ),
        _dataRowBuilder(
          'IShares Core\nS&P 500 ETF',
          'IVV',
          thirtyDayGrowth[1],
          percentageGrowth[1],
          'blank',
        ),
        _dataRowBuilder(
          'IShares Asia\n50 ETF',
          'IAA',
          thirtyDayGrowth[2],
          percentageGrowth[2],
          'blank',
        ),
        _dataRowBuilder(
          'Europe IShares\nS&P Europe 350',
          'IEU',
          thirtyDayGrowth[3],
          percentageGrowth[3],
          'blank',
        ),
        _dataRowBuilder(
          'iShares Core Composite\nBond ETF',
          'IAF',
          thirtyDayGrowth[4],
          percentageGrowth[4],
          'blank',
        ),
        _dataRowBuilder(
          'BetaShares Aus High\nInterest Cash ETF',
          'AAA',
          thirtyDayGrowth[5],
          percentageGrowth[5],
          'blank',
        ),
        _dataRowBuilder(
          'Vanguard Australian\nProperty Secs ETF',
          'VAP',
          thirtyDayGrowth[6],
          percentageGrowth[6],
          'blank',
        ),
        _dataRowBuilder(
          'BetaShares Gold Bullion\nETF Currency  Hedged',
          'QAU',
          thirtyDayGrowth[7],
          percentageGrowth[7],
          'blank',
        ),
      ],
    );
  }

  DataRow _dataRowBuilder(String assetClass, String code,
      String? thirtyDayGrowth, String? growth, String info) {
    return DataRow(
        cells: [
      SelectableText(assetClass),
      SelectableText(code),
      thirtyDayGrowth != null
          ? SelectableText(thirtyDayGrowth)
          : const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(egpGreen)),
      growth != null
          ? SelectableText(growth)
          : const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(egpGreen),
            ),
      SelectableText(info),
    ].map((data) => DataCell(data)).toList());
  }
}
