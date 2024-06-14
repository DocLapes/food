import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [
    Product(id: '1', name: 'Apple', category: 'Fruit', description: 'A juicy fruit'),
    Product(id: '2', name: 'Banana', category: 'Fruit', description: 'A yellow fruit'),
    // Добавьте больше продуктов по необходимости
  ];

  List<Product> get products => _products;

  List<Product> get favoriteProducts =>
      _products.where((product) => product.isFavorite).toList();

  void toggleFavorite(String productId) {
    final index = _products.indexWhere((product) => productId == product.id);
    if (index != -1) {
      _products[index] = _products[index].copyWith(
        isFavorite: !_products[index].isFavorite,
      );
      notifyListeners();
      _saveFavorites();
    }
  }

  void _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds = _products
        .where((product) => product.isFavorite)
        .map((product) => product.id)
        .toList();
    prefs.setStringList('favoriteProducts', favoriteIds);
  }

  void _loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favoriteProducts');
    if (favoriteIds != null) {
      _products = _products.map((product) {
        return product.copyWith(
          isFavorite: favoriteIds.contains(product.id),
        );
      }).toList();
      notifyListeners();
    }
  }

  ProductProvider() {
    _loadFavorites();
  }
}
