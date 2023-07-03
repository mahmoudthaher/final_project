import 'package:flutter/material.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:provider/provider.dart';

class ShoppingCartIcon extends StatefulWidget {
  const ShoppingCartIcon({super.key});

  @override
  State<ShoppingCartIcon> createState() => _ShoppingCartIconState();
}

class _ShoppingCartIconState extends State<ShoppingCartIcon> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Stack(
      children: [
        const Icon(Icons.shopping_cart),
        int.parse(productProvider.selectedProducts.length.toString()) > 0
            ? Positioned(
                top: -3,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    productProvider.selectedProducts.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
