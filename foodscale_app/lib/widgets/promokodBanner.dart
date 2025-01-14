import 'package:flutter/material.dart';
import 'package:foodscale_app/design/colors.dart';

class PromokodBanner extends StatelessWidget {
  const PromokodBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(17.0, 0, 17.0, 0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 1.0,
                    child: Stack(
                      children: [
                        // Полупрозрачный фон
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            color: Colors.black.withOpacity(0.3),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            constraints: const BoxConstraints(
                              minWidth: 375,
                              maxHeight: 472,
                            ),
                            padding: const EdgeInsets.all(24.0),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Заголовок "Не упустите промокод" по центру
                                const Text(
                                  'Не упустите промокод',
                                  style: TextStyle(
                                    fontFamily: 'Manrope',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: titleColor,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                const Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Ваш промокод',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: titleColor,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'JAZ15',
                                        style: TextStyle(
                                          fontFamily: 'Manrope',
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Активировать промокод',
                                      style: TextStyle(
                                        fontFamily: 'Manrope',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 345,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/images/banner-promo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}