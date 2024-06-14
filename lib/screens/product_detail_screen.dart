import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(product.category),
            SizedBox(height: 10),
            Text(product.description),
            Spacer(),
            IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: product.isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                productProvider.toggleFavorite(product.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
