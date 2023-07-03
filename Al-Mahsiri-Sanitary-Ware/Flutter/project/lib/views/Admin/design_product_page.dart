// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/Providers/category_provider.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/models/category_model.dart';
import 'package:project/models/product_model.dart';
import 'package:provider/provider.dart';

class DesignProductsPage extends StatefulWidget {
  const DesignProductsPage({super.key});

  @override
  State<DesignProductsPage> createState() => _DesignProductsPageState();
}

class _DesignProductsPageState extends State<DesignProductsPage> {
  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    productProvider.getAllProductsByCategoryID();
  }

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final category = categoryProvider.categories;
    final productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.products;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context, index) {
                        CategoryModel categories = category[index];
                        return Consumer(
                          builder: (context, ProductProvider productProvider,
                              child) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  productProvider.id = categories.id!;
                                  productProvider.getAllProductsByCategoryID();
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: productProvider.id ==
                                                      categories.id
                                                  ? Colors.black
                                                  : Colors.transparent,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          categories.category,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            color: productProvider.id ==
                                                    categories.id
                                                ? Colors.black
                                                : Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 590,
                child: products.isEmpty
                    ? const Center(
                        child: SizedBox(
                        width: 80,
                        height: 80,
                        child: CircularProgressIndicator(),
                      ))
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          ProductModel product = products[index];

                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      side: BorderSide(color: Colors.black26)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, top: 10, right: 10),
                                    child: Wrap(
                                      children: [
                                        SizedBox(
                                          width: 200,
                                          height: 100,
                                          child: CachedNetworkImage(
                                            imageUrl: product.image,
                                            placeholder: (context, url) =>
                                                const Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                width: 70,
                                                height: 70,
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error,
                                              size: 50,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: const [
                                            SizedBox(
                                              height: 20,
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 70,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            product.name,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Row(
                                          children: const [
                                            SizedBox(
                                              height: 35,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 10),
                                              child: Text(
                                                "${product.price.toStringAsFixed(2)} د.أ",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
              )
            ],
          ),
        ));
  }
}
