import 'package:flutter/material.dart';
import 'package:thristy/utils/constants.dart';

class BigButton extends StatelessWidget {
  final Function onPressed;
  final Widget buttonChild;
  final bool isCTA;
  const BigButton(
      {Key? key,
      required this.onPressed,
      required this.buttonChild,
      required this.isCTA})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: buttonChild,
        style: ElevatedButton.styleFrom(
          primary: isCTA ? kLightBlue : kWhiteBlue,
          onPrimary: isCTA ? kWhiteBlue : kLightBlue,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}

class BigButtonWithIcon extends StatelessWidget {
  final Function onPressed;
  final Icon buttonIcon;
  final Widget buttonLable;
  final bool isCTA;
  const BigButtonWithIcon(
      {Key? key,
      required this.onPressed,
      required this.buttonIcon,
      required this.buttonLable,
      required this.isCTA})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () => onPressed(),
        icon: buttonIcon,
        label: buttonLable,
        style: ElevatedButton.styleFrom(
          primary: isCTA ? kLightBlue : kWhiteBlue,
          onPrimary: isCTA ? kWhiteBlue : kLightBlue,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}
