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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          primary: isCTA ? Theme.of(context).primaryColor : kWhiteBlue,
          onPrimary: isCTA ? Theme.of(context).backgroundColor : kBlueBlack,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    );
  }
}

class BigButtonWithIcon extends StatelessWidget {
  final Function onPressed;
  final Widget buttonIcon;
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
          primary: isCTA ? Theme.of(context).primaryColor : kWhiteBlue,
          onPrimary: isCTA ? Theme.of(context).backgroundColor : kBlueBlack,
          minimumSize: const Size(double.infinity, 50),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
      ),
    );
  }
}
