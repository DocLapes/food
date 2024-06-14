import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import 'product_detail_screen.dart';

class BarcodeScanScreen extends StatefulWidget {
  @override
  _BarcodeScanScreenState createState() => _BarcodeScanScreenState();
}

class _BarcodeScanScreenState extends State<BarcodeScanScreen> {
  String _barcode = '';

  Future<void> _scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      setState(() {
        _barcode = result.rawContent;
      });
      _searchProductByBarcode(_barcode);
    } catch (e) {
      setState(() {
        _barcode = 'Failed to get barcode';
      });
    }
  }

  void _searchProductByBarcode(String barcode) {
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    var product = productProvider.products.firstWhere(
      (product) => product.id == barcode,
      orElse: () => Product(
          id: barcode,
          name: 'Unknown',
          category: 'Unknown',
          description: 'No description available'),
    );

    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Barcode'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Scan result: $_barcode'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scanBarcode,
              child: Text('Start Barcode Scan'),
            ),
          ],
        ),
      ),
    );
  }
}
