import 'dart:async';
import 'dart:ui'; 
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodscale_app/design/colors.dart';
import 'package:foodscale_app/design/fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:foodscale_app/pages/home_page.dart';

class FullscreenSlider extends StatefulWidget {
  final List<Map<String, String>> imagesWithText;
  final int initialIndex;

  const FullscreenSlider({
    super.key,
    required this.imagesWithText,
    required this.initialIndex,
  });

  @override
  State<FullscreenSlider> createState() => _FullscreenSliderState();
}

class _FullscreenSliderState extends State<FullscreenSlider> {
  late PageController _pageController;
  Timer? _autoScrollTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        final nextPage = _pageController.page!.toInt() + 1;
        if (nextPage < widget.imagesWithText.length) {
          _pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          _autoScrollTimer?.cancel();
          Future.delayed(const Duration(seconds: 3), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            }
          });
        }
      }
    });
  }

  void _stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: whiteColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: titleColor,
        body: GestureDetector(
          onPanDown: (_) => _stopAutoScroll(),
          onPanCancel: () => _startAutoScroll(),
          onPanEnd: (_) => _startAutoScroll(),
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagesWithText.length,
            itemBuilder: (context, index) {
              final item = widget.imagesWithText[index];
              final description = item["description"] ?? "";

              return Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item["fullscreenImagePath"] ?? item["imagePath"]!,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 30,
                    left: 125,
                    right: 16,
                    child: Row(
                      children: [
                        Expanded(
                          child: SmoothPageIndicator(
                            controller: _pageController,
                            count: widget.imagesWithText.length,
                            effect: const WormEffect(
                              dotWidth: 35,
                              dotHeight: 4,
                              activeDotColor: whiteColor,
                              dotColor: textColor,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: whiteColor),
                          onPressed: () {
                            _autoScrollTimer?.cancel();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                              child: Container(
                                width: MediaQuery.of(context).size.width - 32,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: titleColor.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  description.isNotEmpty
                                      ? description
                                      : "Нет описания",
                                  style: const TextStyle(
                                    color: whiteColor,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: russianFont,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 97), // Отступ от description до кнопки
                          ElevatedButton(
                            onPressed: () {
                              // Ваш код для кнопки
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(
                                MediaQuery.of(context).size.width - 32,
                                50,
                              ),
                              backgroundColor: whiteColor.withOpacity(0.4),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Заказать',
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                fontFamily: russianFont,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15), // Отступ от кнопки до нижнего края
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _autoScrollTimer?.cancel();
    super.dispose();
  }
}
