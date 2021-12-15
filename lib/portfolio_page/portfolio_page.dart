import 'package:flutter/material.dart';

import 'description.dart';
import 'header.dart';
import 'podcast_button.dart';
import 'data_table.dart';
import 'title.dart';

const Color egpPink = Color.fromRGBO(242, 11, 249, 1);

const Color egpGreen = Color.fromRGBO(56, 88, 78, 1);

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  double _maxContentWidth = 980;

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
                maxContentWidth: _maxContentWidth,
              ),
            ),
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
