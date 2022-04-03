import 'package:flutter/material.dart';

class InputSection extends StatelessWidget {
  const InputSection({
    Key? key,
    required this.controller,
    required this.descriptor,
    this.prefixIcon,
    this.action,
    this.isPasword,
  }) : super(key: key);

  final TextEditingController controller;
  final String descriptor;
  final Icon? prefixIcon;
  final TextInputAction? action;
  final bool? isPasword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: isPasword ?? false,
        keyboardType: TextInputType.name,
        textInputAction: action ?? TextInputAction.next,
        decoration: InputDecoration(
          label: Text(descriptor),
          prefixIcon: prefixIcon,
        ),
      ),
    );
  }
}
