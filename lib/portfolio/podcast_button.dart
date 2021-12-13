import 'package:flutter/material.dart';

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
      ],
    );
  }
}
