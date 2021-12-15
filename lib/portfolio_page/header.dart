import 'package:flutter/material.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class Header extends StatelessWidget {
  final double logoScale;

  const Header(
      {Key? key,
      required this.egpGreen,
      required this.egpPink,
      required this.logoScale})
      : super(key: key);

  final Color egpGreen;
  final Color egpPink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                // Open in current tab
                html.window.location.assign("https://www.equitygals.com/");
              },
              child: Image.asset(
                "assets/images/equity-gals-logo.webp",
                scale: logoScale,
              )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                "MENU",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontFamily: 'Impact', color: egpGreen),
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                // window.open opens in a new tab
                html.window
                    .open("https://www.instagram.com/equitygals/", "Instagram");
              },
              icon: Image.asset("assets/images/instagram.webp"))
        ],
      ),
    );
  }
}
