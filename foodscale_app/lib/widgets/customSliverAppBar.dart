import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodscale_app/design/colors.dart';
import 'package:foodscale_app/design/fonts.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: whiteColor,
      elevation: 0,
      pinned: true,
      automaticallyImplyLeading: false,
      expandedHeight: 80.0,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Узнаем высоту AppBar (сжатая или расширенная)
          final double appBarHeight = constraints.biggest.height;
          final double appBarMaxHeight = 80.0;
          final bool isExpanded = appBarHeight >= appBarMaxHeight;

          return Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          // Действие для кнопки локации
                        },
                        icon: SvgPicture.asset(
                          'assets/images/icon_location.svg',
                          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                        ),
                        splashRadius: 20,
                        iconSize: isExpanded ? 24 : 20, // Регулируем размер
                      ),
                      const SizedBox(width: 13),
                      Text(
                        'Выберите адрес',
                        style: TextStyle(
                          color: titleColor,
                          fontFamily: russianFont,
                          fontSize: isExpanded ? 14 : 12, // Регулируем размер
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          // Действие для кнопки уведомлений
                        },
                        icon: SvgPicture.asset(
                          'assets/images/icon_notification.svg',
                          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                        ),
                        splashRadius: 20,
                        iconSize: isExpanded ? 24 : 20, // Регулируем размер
                      ),
                      const SizedBox(width: 3),
                      IconButton(
                        onPressed: () {
                          // Действие для кнопки профиля
                        },
                        icon: SvgPicture.asset(
                          'assets/images/icon_profile-circle.svg',
                          colorFilter: const ColorFilter.mode(primaryColor, BlendMode.srcIn),
                        ),
                        splashRadius: 20,
                        iconSize: isExpanded ? 24 : 20, // Регулируем размер
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
