import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodscale_app/design/colors.dart';
import 'package:foodscale_app/design/fonts.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: backgroundColor, // Постоянный фон
      elevation: 0,
      pinned: true, // Закрепляем верхнюю часть AppBar
      automaticallyImplyLeading: false,
      expandedHeight: 50.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin, // Фиксируем контент при сжатии
        background: Container(
          color: backgroundColor, // Устанавливаем фон даже при скролле
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
                    ),
                    const SizedBox(width: 13),
                    Text(
                      'Выберите адрес',
                      style: TextStyle(
                        color: titleColor,
                        fontFamily: russianFont,
                        fontSize: 14,
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
