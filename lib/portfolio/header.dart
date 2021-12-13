import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
    required this.egpGreen,
    required this.egpPink,
  }) : super(key: key);

  final Color egpGreen;
  final Color egpPink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/equity-gals-logo.webp"),
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
          const Icon(Icons.camera_alt_outlined)
        ],
      ),
    );
  }
}
