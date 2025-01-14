import 'package:flutter/material.dart';

class CustomSlidableActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final double width;

  const CustomSlidableActionButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 82, // Динамическая ширина
      color: backgroundColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: foregroundColor),
        iconSize: 30,
      ),
    );
  }
}
