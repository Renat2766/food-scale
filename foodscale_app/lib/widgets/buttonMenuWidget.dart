import 'package:flutter/material.dart';
import 'package:foodscale_app/design/colors.dart'; // Цвета
import 'package:foodscale_app/design/fonts.dart'; // Шрифты

class ButtonMenuWidget extends StatefulWidget {
  final List<Map<String, dynamic>> categories;

  const ButtonMenuWidget({super.key, required this.categories});

  @override
  ButtonMenuWidgetState createState() => ButtonMenuWidgetState();
}

class ButtonMenuWidgetState extends State<ButtonMenuWidget> {
  String selectedItem = ''; // Для хранения выбранного элемента

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Горизонтальный скроллинг
      child: Row(
        children: widget.categories.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value['name']; // Исправлено на 'name', а не 'categoryId'

          if (category == null || category == '') {
            return Container(); // Возвращаем пустой контейнер, если categoryId или name отсутствует
          }

          final isSelected = selectedItem == category.toString(); // Приводим в строку, чтобы сравнить

          // Устанавливаем отступы для первого, последнего и остальных элементов
          final leftPadding = index == 0 ? 17.0 : 0.0;
          final rightPadding = index == widget.categories.length - 1 ? 17.0 : 12.0;

          return Padding(
            padding: EdgeInsets.only(
              left: leftPadding,
              right: rightPadding,
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedItem = category.toString(); // Приводим к строке перед присваиванием
                });
                print('Вы выбрали $category');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.grey[300] // Если выбрано, фон серый
                      : Colors.transparent, // Иначе прозрачный
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  category.toString(), // Приводим к строке при отображении
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: russianFont,
                    fontWeight: FontWeight.w600,
                    color: titleColor, // Цвет текста
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
