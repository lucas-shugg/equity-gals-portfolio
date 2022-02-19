import 'dart:convert';

import '../models/portfolio_holding.dart';

import 'portfolio_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Portfolio extends StatefulWidget {
  final double maxContentWidth;
  final Map<String, PortfolioHolding> portfolio;
  final ValueNotifier<String?> stockHoveredOver;
  final ValueNotifier<double?> totalGrowth;

  const Portfolio({
    Key? key,
    required this.maxContentWidth,
    required this.portfolio,
    required this.stockHoveredOver,
    required this.totalGrowth,
  }) : super(key: key);

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  void stockBeingHoveredOverListener() {
    setState(() {});
  }

  // Stateful widgets have access to this method which can be used to run code on
  // the initial load of a widget just once.
  @override
  void initState() {
    super.initState();

    // Rebuild the Datatable when the onHoveredStockChanges to reflect the updated
    // highlight state of the data table.
    widget.stockHoveredOver.addListener(stockBeingHoveredOverListener);

    const String mainEndpoint = "https://equity-gals-bff.herokuapp.com/yahoo";
    const String quoteEndPoint = "v6/finance/quote";
    const historyEndpoint = "v8/finance/spark";

    final String symbols = widget.portfolio.keys.join(",");
    // Get the current prices
    http
        .get(Uri.parse("$mainEndpoint/$quoteEndPoint?symbols=$symbols"))
        .then((value) {
      List<dynamic> stockQuoteResponses =
          jsonDecode(value.body)["quoteResponse"]["result"];

      // Added the currentPrices to the stock object
      for (Map stockQuote in stockQuoteResponses) {
        widget.portfolio[stockQuote["symbol"]]?.stock
            .setCurrentPriceAndPercentageGrowth(
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
            widget.portfolio[ticker]?.stock
                .setPriceThirtyDaysAgo(history["close"][0]);
          }
        });

        widget.totalGrowth.value = _calculateTotalGrowth();

        // Rebuilds the widget now we have the data
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.stockHoveredOver.removeListener(stockBeingHoveredOverListener);
  }

  double? _calculateTotalGrowth() {
    double growth = 0;
    for (PortfolioHolding holding in widget.portfolio.values) {
      if (holding.stock.percentageGrowth == null) {
        // If any are null we dip bc calc will be wrong
        return null;
      }
      growth += holding.holdingWeight * holding.stock.percentageGrowth!;
    }
    return growth;
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
          .map((titleWidget) => DataColumn(label: Flexible(child: titleWidget)))
          .toList(),
      rows: widget.portfolio.entries
          .map((portfolioHolding) => _dataRowBuilder(
              portfolioHolding.value.stock.name,
              portfolioHolding.key,
              portfolioHolding.value.stock.thirtyDayGrowth,
              portfolioHolding.value.stock.percentageGrowthAsString,
              portfolioHolding.value.stock.info))
          .toList(),
    );
  }

  DataRow _dataRowBuilder(String name, String code, String? thirtyDayGrowth,
      String? growth, String info) {
    void _onTap() {
      widget.stockHoveredOver.value = code.split(".").first;
    }

    void _onHover(bool isHovering) {
      if (isHovering) {
        _onTap();
      } else {
        widget.stockHoveredOver.value = null;
      }
    }

    bool isStockBeingHoveredOver =
        widget.stockHoveredOver.value == code.split(".").first;

    return DataRow(
        cells: [
      InkWell(
        onTap: _onTap,
        onHover: _onHover,
        child: SelectableText(
          name,
          style: isStockBeingHoveredOver
              ? highlightedText.copyWith(fontStyle: FontStyle.italic)
              : null,
        ),
      ),
      InkWell(
          onTap: _onTap,
          onHover: _onHover,
          child: SelectableText(
            code.split(".").first,
            style: isStockBeingHoveredOver
                ? highlightedText.copyWith(fontStyle: FontStyle.italic)
                : null,
          )),
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
