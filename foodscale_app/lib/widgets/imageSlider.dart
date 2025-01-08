import 'package:flutter/material.dart';
import 'package:foodscale_app/widgets/fullScreenSlider.dart';
import 'package:foodscale_app/design/fonts.dart';
import 'package:foodscale_app/design/colors.dart';

class ImageSlider extends StatelessWidget {
  final List<Map<String, String>> imageTextList;

  const ImageSlider({super.key, required this.imageTextList});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 17.0),
        child: Row(
          children: imageTextList.map((item) {
            String imagePath = item["imagePath"] ?? 'assets/default_image.png';
            String title = item["title"] ?? 'No Title';

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullscreenSlider(
                      imagesWithText: imageTextList,
                      initialIndex: imageTextList.indexOf(item),
                    ),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(
                  right: item == imageTextList.last ? 17.0 : 10.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                width: 100,
                height: 105,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: 8,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7.0,
                            vertical: 7.0,
                          ),
                          child: Text(
                            title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: whiteColor,
                              fontFamily: russianFont,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}