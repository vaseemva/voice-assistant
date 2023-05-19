import 'package:flutter/material.dart';
import 'package:voice_assistant/palette.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String description;
  const FeatureBox(
      {Key? key,
      required this.color,
      required this.headerText,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 9, horizontal: 35),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: color),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20).copyWith(left: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                    fontFamily: 'Cera pro',
                    color: Pallete.mainFontColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Cera pro',
                  color: Pallete.mainFontColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
