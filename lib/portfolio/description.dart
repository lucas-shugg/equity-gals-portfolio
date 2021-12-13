import 'package:equity_gals_portfolio/portfolio/portfolio_page.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final double maxContentWidth;

  const Description({Key? key, required this.maxContentWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxContentWidth),
      child: SelectableText(
        "EGP's Growth ETF Portfolio has been constructed as an educational resource.\n The aim is to highlight the importance of diversification, provide examples of ETFs, and to help you understand asset classes and what they mean.",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontFamily: 'AvenirLight', color: egpGreen),
      ),
    );
  }
}
