import 'package:flutter/material.dart';
import 'package:foodscale_app/design/colors.dart';
import 'package:foodscale_app/design/dimensions.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final String fontFamily;
  final double? width; // Добавляем параметр для ширины

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.fontFamily,
    this.width, // Опциональный параметр ширины
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Устанавливаем ширину кнопки
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(341, 50), // Устанавливаем минимальный размер
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: fontSize16,
            fontWeight: FontWeight.w500,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
