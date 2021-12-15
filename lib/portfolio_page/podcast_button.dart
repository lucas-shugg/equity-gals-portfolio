import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class PodcastButton extends StatelessWidget {
  const PodcastButton({
    Key? key,
    required this.egpGreen,
  }) : super(key: key);

  final Color egpGreen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(egpGreen)),
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  // Window.location.assign open in the same tab
                  html.window.location.assign(
                      "https://www.equitygals.com/podcast/episode/32d4f780/egps-balanced-etf-portfolio-how-to-construct-a-balanced-etf-portfolio-or-ep9");
                },
                child: Text(
                  'LISTEN HERE',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(fontFamily: 'Impact', color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
