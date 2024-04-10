import 'package:flutter/material.dart';
import 'package:vvims/constants/constants.dart';


class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
    this.activeColor = kSecondaryColor,
    this.inActiveColor = const Color(0xFFF7F7F7),
  }) : super(key: key);

  final bool isActive;
  final Color activeColor, inActiveColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kDefaultDuration,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 5),
      height: 10,
      width: isActive ? 30 : 10,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inActiveColor.withOpacity(0.25),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}
