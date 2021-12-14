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
  @override
  void initState() {
    super.initState();
    const String quoteEndPoint =
        "https://query1.finance.yahoo.com/v7/finance/quote";
    http
        .get(Uri.parse(
            "$quoteEndPoint?corsDomain=localhost.com&symbols=AASF.AX,IVV,IAA.AX,IAF.AX,AAA.AX,VAP.AX,QAU.AX"))
        .then((value) => print(value));
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
          'blank',
          'blank',
          'blank',
        ),
        _dataRowBuilder(
          'IShares Core\nS&P 500 ETF',
          'IVV',
          'blank',
          'blank',
          'blank',
        ),
        _dataRowBuilder(
          'IShares Asia\n50 ETF',
          'IAA',
          'blank',
          'blank',
          'blank',
        ),
        _dataRowBuilder(
          'Europe IShares\nS&P Europe 350',
          'IEU',
          'blank',
          'blank',
          'blank',
        ),
        _dataRowBuilder(
          'iShares Core Composite\nBond ETF',
          'IAF',
          null,
          'blank',
          'blank',
        ),
        _dataRowBuilder(
          'BetaShares Aus High\nInterest Cash ETF',
          'AAA',
          'blank',
          null,
          'blank',
        ),
        _dataRowBuilder(
          'Vanguard Australian\nProperty Secs ETF',
          'VAP',
          'blank',
          'blank',
          'blank',
        ),
        _dataRowBuilder(
          'BetaShares Gold Bullion\nETF Currency  Hedged',
          'QAU',
          'blank',
          null,
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
