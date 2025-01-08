import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Для работы с SVG (иконками)
import 'package:foodscale_app/design/colors.dart'; // Цвета
import 'package:foodscale_app/design/fonts.dart'; // Шрифты

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String price;
  final String rating;

  const ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000), // Легкая тень
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Левая часть: изображение + рейтинг
                Container(
                  width: 100,
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/icon_star.svg',
                            height: 10,
                            width: 10,
                            colorFilter: const ColorFilter.mode(
                                primaryColor, BlendMode.srcIn),
                          ),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              rating,
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: russianFont,
                                fontWeight: FontWeight.w500,
                                color: primaryColor,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
                // Правая часть: текст и кнопка
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: russianFont,
                            fontWeight: FontWeight.w700,
                            color: titleColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          maxLines: 2, // Ограничение строк
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: russianFont,
                            fontWeight: FontWeight.w500,
                            color: textColor,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFEDEDED),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: kazakhFont,
                                  fontWeight: FontWeight.w700,
                                  color: titleColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned кнопка
          Positioned(
            right: 8, // Отступ справа
            bottom: -5, // Отступ снизу
            child: ElevatedButton(
              onPressed: () {
                // Логика кнопки
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: const CircleBorder(),
                backgroundColor: primaryColor,
                minimumSize: const Size(24, 24),
              ),
              child: const Icon(
                Icons.add,
                size: 20,
                color: whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
