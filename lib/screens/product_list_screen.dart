import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'favorite_screen.dart';
import 'barcode_scan_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    List<Product> displayedProducts = productProvider.products.where((product) {
      return (_selectedCategory == 'All' || product.category == _selectedCategory) &&
          product.name.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Guide'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => FavoriteScreen()));
            },
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => BarcodeScanScreen()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Search'),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                });
              },
              items: <String>['All', 'Fruit', 'Vegetable', 'Dairy']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: displayedProducts.length,
                itemBuilder: (ctx, i) => ListTile(
                  title: Text(displayedProducts[i].name),
                  subtitle: Text(displayedProducts[i].category),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: displayedProducts[i])));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
