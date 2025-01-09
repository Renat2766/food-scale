import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodscale_app/design/colors.dart';
import 'package:foodscale_app/design/fonts.dart';

class ListCard extends StatelessWidget {
  final List<dynamic> data;
  final List<dynamic> rootRatings;

  const ListCard({super.key, required this.data, required this.rootRatings});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2, // Ограничиваем высоту
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];

          // Проверяем, что данные существуют и не равны null
          final String title = item['name'] ?? 'Без названия';
          final String description = item['description'] ?? 'Нет описания';
          final String imageUrl = item['imagePath'] ??
              'assets/images/default_image.png'; // Указываем изображение по умолчанию
          final String price = '${item['price'] ?? 'Цена не указана'} ₸';
          final String rating = getProductRatings(
            item['ratings'] as List<dynamic>?,
            rootRatings,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Slidable(
              key: ValueKey(item['id']),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Кнопка A нажата для $title')),
                      );
                    },
                    backgroundColor: primaryColor,
                    foregroundColor: whiteColor,
                    icon: Icons.shopping_cart,
                  ),
                ],
              ),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Кнопка B нажата для $title')),
                      );
                    },
                    backgroundColor: errorColor,
                    foregroundColor: whiteColor,
                    icon: Icons.delete,
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
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
                                if (rating.isNotEmpty)
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
                                const SizedBox(height: 8),
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
                                    maxLines: 2,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFEDEDED),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                    Positioned(
                      right: 8,
                      bottom: -5,
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
              ),
            ),
          );
        },
      ),
    );
  }

  // Метод получения рейтинга продукта
  String getProductRatings(
      List<dynamic>? productRatings, List<dynamic> rootRatings) {
    if (productRatings == null || productRatings.isEmpty) {
      return '';
    }

    List<String> ratingsList = [];
    for (var productRatingId in productRatings) {
      final rootRating = rootRatings.firstWhere(
        (r) =>
            r is Map<String, dynamic> &&
            r['id'] == productRatingId,
        orElse: () => null,
      );

      if (rootRating != null) {
        final ratingName = rootRating['name'] ?? '';
        if (ratingName.isNotEmpty) {
          ratingsList.add(ratingName);
        }
      }
    }
    return ratingsList.join(', ');
  }
}
