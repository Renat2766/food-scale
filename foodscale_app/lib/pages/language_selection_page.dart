import 'package:flutter/material.dart';
import 'package:foodscale_app/design/colors.dart';
import 'package:foodscale_app/design/dimensions.dart';
import 'package:foodscale_app/design/fonts.dart';
import 'package:foodscale_app/pages/home_page.dart';
import 'package:foodscale_app/widgets/customButton.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Получаем ширину экрана
    double screenWidth = MediaQuery.of(context).size.width;

    // Размер кнопки с учётом отступов
    double buttonWidth = screenWidth - 34; // 17px отступ с каждой стороны

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 377),
              child: const Text(
                'FoodScale',
                style: TextStyle(
                  fontSize: fontSize48,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'MontserratAlternates',
                  color: secondaryColor,
                ),
              ),
            ),
            const Text(
              'Demo Alfa V 1.0',
              style: TextStyle(
                fontSize: fontSize20,
                fontFamily: 'MontserratAlternates',
                fontWeight: FontWeight.w600,
                color: spanColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 200),
              child: const Text(
                'Тілді таңдаңыз / Выберите язык',
                style: TextStyle(
                  fontSize: fontSize16,
                  fontFamily: kazakhFont,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Кнопка "Қазақша" с правильными отступами
            Container(
              margin: const EdgeInsets.only(top: 17),
              child: CustomButton(
                text: 'Қазақша',
                fontFamily: kazakhFont,
                onPressed: () {},
                width: buttonWidth, // Устанавливаем точную ширину кнопки
              ),
            ),
            // Кнопка "Русский" с правильными отступами и отступом снизу
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: CustomButton(
                text: 'Русский',
                fontFamily: russianFont,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                width: buttonWidth, // Устанавливаем точную ширину кнопки
              ),
            ),
            const SizedBox(height: 34), // Отступ снизу
          ],
        ),
      ),
    );
  }
}
