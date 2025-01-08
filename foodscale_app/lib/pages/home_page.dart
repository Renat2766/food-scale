import 'package:flutter/material.dart';
import 'package:foodscale_app/widgets/listCard.dart';
import 'package:foodscale_app/widgets/promokodBanner.dart';
import 'package:foodscale_app/widgets/buttonMenuWidget.dart';
import 'package:foodscale_app/widgets/bestOfferWidget.dart';
import 'package:foodscale_app/widgets/customSliverAppBar.dart';
import 'package:foodscale_app/widgets/imageSlider.dart';
import 'package:foodscale_app/services/data_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String jsonPath = 'assets/data.json';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: DataService.loadJsonData(jsonPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Произошла ошибка при загрузке данных: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Данные отсутствуют.'));
          }

          final jsonData = snapshot.data!;
          final sliderData = jsonData['slider'] as List<dynamic>? ?? [];

          // Преобразуем sliderData в List<Map<String, String>>
          final sliderList = sliderData.map((data) {
            return {
              "imagePath": data["imagePath"]?.toString() ?? '',
              "title": data["title"]?.toString() ?? '',
              "description": data["description"]?.toString() ?? '',
            };
          }).toList();

          final categoriesData = jsonData['categories'] as List<dynamic>? ?? [];
          final bestProduct = DataService.findBestProduct(jsonData, 1);
          final ratings = jsonData['ratings'] as List<dynamic>? ?? [];
          final products = jsonData['products'] as List<dynamic>? ?? [];

          return CustomScrollView(
            slivers: [
              const CustomSliverAppBar(),
              if (sliderList.isNotEmpty)
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      ImageSlider(imageTextList: sliderList), // Передаем только один список
                      const SizedBox(height: 10),
                      const PromokodBanner(),
                      const SizedBox(height: 11),
                      if (bestProduct != null)
                        BestOfferWidget(productData: bestProduct, rootRatings: ratings),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  minHeight: 60.0,
                  maxHeight: 60.0,
                  child: ButtonMenuWidget(categories: (categoriesData).cast<Map<String, dynamic>>()),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    if (index < products.length) {
                      final product = products[index];
                      if (product is Map<String, dynamic>) {
                        return ListCard(
                          data: [product], // Передача данных в виде списка для совместимости с ListCard
                          rootRatings: ratings,
                        );
                      }
                    }
                    return const SizedBox(); // Avoid crashing
                  },
                  childCount: products.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
