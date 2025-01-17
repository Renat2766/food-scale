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
    return SizedBox(
      height: 120, // Явно указаны размеры
      width: width, // Ширина передается параметром
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Icon(icon, color: foregroundColor, size: 30),
          ),
        ),
      ),
    );
  }
}
