import 'package:flutter/material.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:provider/provider.dart';

class SummeryWidget extends StatelessWidget {
  const SummeryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ProductProvider productProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "ملخص الفاتورة",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            const SizedBox(height: 10),
            Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "عدد المنتجات",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  productProvider.selectedProducts.length.toString(),
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "المجموع قبل الضريبة",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  productProvider.subTotal.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "الضريبة 16%",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  productProvider.taxAmount.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Divider(),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "المجموع",
                  style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  productProvider.total.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
