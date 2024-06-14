import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'product_detail_screen.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    var favoriteProducts = productProvider.favoriteProducts;

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: favoriteProducts.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text(favoriteProducts[i].name),
          subtitle: Text(favoriteProducts[i].category),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) => ProductDetailScreen(product: favoriteProducts[i])));
          },
        ),
      ),
    );
  }
}
