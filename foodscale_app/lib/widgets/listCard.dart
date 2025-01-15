import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodscale_app/design/colors.dart';
import 'package:foodscale_app/design/fonts.dart';
import 'package:foodscale_app/widgets/customSlidableActionButton.dart';



class ListCard extends StatelessWidget {
  final List<dynamic>? data;
  final List<dynamic> rootRatings;

  const ListCard({super.key, required this.data, required this.rootRatings});

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const Center(
        child: Text(
          'Нет данных для отображения',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data!.length,
      itemBuilder: (context, index) {
        final item = data![index];

        final String title = (item['name'] ?? 'Без названия') as String;
        final String description =
            (item['description'] ?? 'Нет описания') as String;
        final String imageUrl =
            (item['imagePath'] ?? 'assets/images/default_image.png') as String;
        final String price =
            '${item['price'] ?? 'Цена не указана'} ₸';
        final String rating =
            getProductRatings(item['ratings'] as List<dynamic>?, rootRatings);

        return Slidable(
          key: ValueKey(item['id']),
          startActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              CustomSlidableActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Добавлено в корзину: $title')),
                  );
                },
                backgroundColor: primaryColor,
                foregroundColor: whiteColor,
                icon: Icons.add_shopping_cart,
                width: 82,
              ),
            ],
          ),
          endActionPane: ActionPane(
            extentRatio: 0.2,
            motion: const ScrollMotion(),
            children: [
              CustomSlidableActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Удалено: $title')),
                  );
                },
                backgroundColor: errorColor,
                foregroundColor: whiteColor,
                icon: Icons.delete,
                width: 82,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Stack(
                children: [
                  Row(
                    children: [
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
                                      primaryColor,
                                      BlendMode.srcIn,
                                    ),
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
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                      Expanded(
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
                            const SizedBox(height: 8),
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
                      ),
                    ],
                  ),
                  Positioned(
                    right: 8,
                    bottom: -5,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Кнопка Add нажата для $title')),
                        );
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
    );
  }

  String getProductRatings(
      List<dynamic>? productRatings, List<dynamic> rootRatings) {
    if (productRatings == null || productRatings.isEmpty) {
      return '';
    }

    List<String> ratingsList = [];
    for (var productRatingId in productRatings) {
      final rootRating = rootRatings.firstWhere(
        (r) =>
            r is Map<String, dynamic> && r['id'] == productRatingId,
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
