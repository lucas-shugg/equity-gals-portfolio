import 'package:flutter/material.dart';

import 'portfolio_page.dart';

class TotalGrowth extends StatelessWidget {
  const TotalGrowth({Key? key, required this.totalGrowth}) : super(key: key);
  final ValueNotifier<double?> totalGrowth;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: totalGrowth,
        builder: (context, double? value, widget) {
          if (value == null) {
            return Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Total Growth",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: egpGreen),
                  ),
                ),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(egpGreen),
                ),
              ],
            );
          }
          return Text("Total Growth ${value.toStringAsFixed(2)}%",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  ?.copyWith(color: egpGreen));
        });
  }
}
