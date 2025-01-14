import 'dart:convert';
import 'package:flutter/services.dart';

class DataService {
  // Загрузка данных из JSON файла
  static Future<Map<String, dynamic>> loadJsonData(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  // Преобразование данных для слайдера
  static List<Map<String, String>> parseSliderData(Map<String, dynamic> jsonData) {
    return (jsonData['slider'] as List<dynamic>)
        .map((item) => {
              'id': item['id'].toString(),
              'imagePath': item['imagePath'] as String,
              'title': item['title'] as String,
              'fullscreenImagePath': item['fullscreenImagePath'] as String,
              'description': item['description'] as String,
            })
        .toList();
  }

  // Преобразование данных категорий
  static List<Map<String, dynamic>> parseCategoriesData(Map<String, dynamic> jsonData) {
    return (jsonData['categories'] as List<dynamic>)
        .map((item) => {
              'id': item['id'],
              'name': item['name'] as String,
            })
        .toList();
  }

  // Поиск лучшего продукта по идентификатору рейтинга
  static Map<String, dynamic>? findBestProduct(Map<String, dynamic> jsonData, int ratingId) {
    final products = jsonData['products'] as List<dynamic>;
    return products.firstWhere(
      (product) {
        final ratingIds = (product['ratings'] as List<dynamic>).map((id) => id as int).toList();
        return ratingIds.contains(ratingId);
      },
      orElse: () => products.isNotEmpty ? products.first : null,
    );
  }
}