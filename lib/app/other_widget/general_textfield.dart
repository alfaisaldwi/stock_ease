import 'package:flutter/material.dart';

class GeneralTextfield extends StatelessWidget {
  final String label;
  final String hint;
  final bool enable;
  final bool readOnly;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType keyboardType;

  const GeneralTextfield({
    Key? key,
    required this.label,
    required this.hint,
    this.controller,
    this.enable = true,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enable,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        focusColor: Colors.black,
        hoverColor: Colors.black,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8)),
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      ),
    );
  }
}
