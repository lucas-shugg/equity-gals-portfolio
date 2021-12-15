import 'dart:convert';
import 'portfolio_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Portfolio extends StatefulWidget {
  final double maxContentWidth;

  const Portfolio({Key? key, required this.maxContentWidth}) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  // 3rd Dec 2021 are when the prices have been recorded
  Map<String, Stock> stocks = {
    "AASF.AX": Stock('Airlie Australian\nShare Fund', 3.56),
    "IVV.AX": Stock("IShares Core\nS&P 500 ETF", 647.84),
    "IAA.AX": Stock("IShares Asia\n50 ETF", 109.94),
    "IEU.AX": Stock("Europe IShares\nS&P Europe 350", 74.27),
    "IAF.AX": Stock('iShares Core Composite\nBond ETF', 109.61),
    "AAA.AX": Stock('BetaShares Aus High\nInterest Cash ETF', 50.06),
    "VAP.AX": Stock('Vanguard Australian\nProperty Secs ETF', 93.82),
    "QAU.AX": Stock('BetaShares Gold Bullion\nETF Currency Hedged', 15.75)
  };

  // Stateful widgets have access to this method which can be used to run code on
  // the initial load of a widget just once.
  @override
  void initState() {
    super.initState();

    const String mainEndpoint = "https://equity-gals-bff.herokuapp.com/yahoo";
    const String quoteEndPoint = "v6/finance/quote";
    const historyEndpoint = "v8/finance/spark";

    final String symbols = stocks.keys.join(",");
    // Get the current prices
    http
        .get(Uri.parse("$mainEndpoint/$quoteEndPoint?symbols=$symbols"))
        .then((value) {
      List<dynamic> stockQuoteResponses =
          jsonDecode(value.body)["quoteResponse"]["result"];

      // Added the currentPrices to the stock object
      for (Map stockQuote in stockQuoteResponses) {
        stocks[stockQuote["symbol"]]?.setCurrentPriceAndPercentageGrowth(
            stockQuote["regularMarketPrice"]);
      }

      // Get the last thirty days of prices
      http
          .get(Uri.parse(
              "$mainEndpoint/$historyEndpoint?symbols=$symbols&range=30d&interval=1d"))
          .then((value) {
        Map stockHistoryResponse = jsonDecode(value.body);
        // Adds the price 30 days ago to the stock objects
        stockHistoryResponse.forEach((ticker, history) {
          if (history["close"].length >= 0) {
            stocks[ticker]?.setPriceThirtyDaysAgo(history["close"][0]);
          }
        });

        // Rebuilds the widget now we have the data
        setState(() {});
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> titleRow = [
      const SelectableText('ASSET CLASS'),
      const SelectableText('CODE'),
      const SelectableText('30 DAYS\nGROWTH %'),
      const SelectableText('GROWTH SINCE\nINCEPTION %'),
      HyperLink(
          text: "PDF LINKS",
          onPressed: () {
            // Open in a new tab
            html.window
                .open("equity-gals-portfolio.pdf", "Equity Gals Portfolio Pdf");
          })
    ];
    return DataTable(
        columnSpacing: 16,
        columns: titleRow
            .map((titleWidget) =>
                DataColumn(label: Flexible(child: titleWidget)))
            .toList(),
        rows: stocks.entries
            .map((stock) => _dataRowBuilder(
                stock.value.name,
                stock.key,
                stock.value.thirtyDayGrowth,
                stock.value.percentageGrowth,
                stock.value.info))
            .toList());
  }

  DataRow _dataRowBuilder(String assetClass, String code,
      String? thirtyDayGrowth, String? growth, String info) {
    return DataRow(
        cells: [
      SelectableText(assetClass),
      SelectableText(code.split(".").first),
      thirtyDayGrowth != null
          ? SelectableText(thirtyDayGrowth)
          : const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(egpGreen)),
      growth != null
          ? SelectableText(growth)
          : const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(egpGreen),
            ),
      HyperLink(
        text: "Info",
        onPressed: () {
          // Open in a new tab
          html.window.open(
              "${code.split(".").first}.pdf", "Equity Gals Portfolio Pdf");
        },
      ),
    ].map((data) => DataCell(data)).toList());
  }
}

class Stock {
  final String name;
  //final String ticker;
  String? percentageGrowth;
  String? thirtyDayGrowth;
  final String info = "PDF";
  final double priceBoughtAt;

  double? currentPrice, priceThirtyDaysAgo;

  Stock(this.name, this.priceBoughtAt);

  void setCurrentPriceAndPercentageGrowth(double newCurrentPrice) {
    currentPrice = newCurrentPrice;

    percentageGrowth =
        _calculateGrowthPercentage(newCurrentPrice, priceBoughtAt)
                .toStringAsFixed(2) +
            "%";
  }

  void setPriceThirtyDaysAgo(double newPriceThirtyDaysAgo) {
    priceThirtyDaysAgo = newPriceThirtyDaysAgo;

    if (currentPrice == null) {
      return;
    }
    thirtyDayGrowth =
        _calculateGrowthPercentage(currentPrice!, newPriceThirtyDaysAgo)
                .toStringAsFixed(2) +
            "%";
  }

  double _calculateGrowthPercentage(double currentPrice, double previousPrice) {
    return (currentPrice - previousPrice) * 100 / previousPrice;
  }
}

class HyperLink extends StatelessWidget {
  final String text;

  final void Function()? onPressed;

  const HyperLink({Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text,
          style: Theme.of(context)
              .dataTableTheme
              .dataTextStyle
              ?.copyWith(color: Colors.blue[800], fontWeight: FontWeight.bold)),
      onPressed: onPressed,
    );
  }
}
