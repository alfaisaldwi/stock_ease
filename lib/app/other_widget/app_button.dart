import 'package:flutter/material.dart';
import 'package:stock_ease/app/theme/color.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.baseColor,
    this.icon,
    this.width,
  });

  final VoidCallback onTap;
  final String label;
  final Color baseColor;
  final Icon? icon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: primaryColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
