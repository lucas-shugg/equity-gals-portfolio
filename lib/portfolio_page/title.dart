import 'package:flutter/material.dart';

class PortfolioTitle extends StatelessWidget {
  const PortfolioTitle({
    Key? key,
    required this.egpPink,
  }) : super(key: key);

  final Color egpPink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: SelectableText(
        "EGP GROWTH ETF PORTFOLIO",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(fontFamily: 'Impact', color: egpPink),
      ),
    );
  }
}
