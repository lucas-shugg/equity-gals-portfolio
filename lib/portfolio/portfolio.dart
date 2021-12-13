import 'package:flutter/material.dart';

class Portfolio extends StatelessWidget {
  final double maxContentWidth;

  const Portfolio({Key? key, required this.maxContentWidth}) : super(key: key);

  static const List<String> titleRow = [
    'ASSET CLASS',
    'CODE',
    '30 DAYS\nGROWTH %',
    'GROWTH\nSINCE INCEPTION %',
    'INFO'
  ];

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 16,
      columns: titleRow
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
          'blank',
          'blank',
          'blank',
        ),
        _dataRowBuilder(
          'BetaShares Aus High\nInterest Cash ETF',
          'AAA',
          'blank',
          'blank',
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
          'blank',
          'blank',
        ),
      ],
    );
  }

  DataRow _dataRowBuilder(String assetClass, String code,
      String thirtyDayGrowth, String growth, String info) {
    return DataRow(
        cells: [
      assetClass,
      code,
      thirtyDayGrowth,
      growth,
      info,
    ].map((data) => DataCell(SelectableText(data))).toList());
  }
}
