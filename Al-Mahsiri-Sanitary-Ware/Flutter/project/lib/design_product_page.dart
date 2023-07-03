import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/controllers/product_controller.dart';
import 'package:project/models/product_model.dart';
import 'package:provider/provider.dart';

class DesignProductsPage extends StatefulWidget {
  DesignProductsPage({super.key, required this.future});
  dynamic future;
  @override
  State<DesignProductsPage> createState() => _DesignProductsPageState();
}

class _DesignProductsPageState extends State<DesignProductsPage> {
  @override
  void initState() {
    super.initState();
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    widget.future;
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final products = productProvider.products;

    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          ProductModel product = products[index];
          return Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: SizedBox(
              width: 150,
              height: 300,
              child: Card(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    side: BorderSide(color: Colors.black26)),
                child: Wrap(
                  children: [
                    Row(
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Image.network(
                      product.image,
                      width: 200,
                      height: 100,
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: 55,
                      child: Text(
                        product.name,
                        maxLines: 2,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18),
                      ),
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: Text(
                        "${product.finalPrice.toStringAsFixed(2)} دينار اردني",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12)),
                              width: 40,
                              height: 40,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      product.selectedQty++;
                                    });
                                  },
                                  child: const Text(
                                    "+",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child:
                                Center(child: Text("${product.selectedQty}")),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(12)),
                              width: 40,
                              height: 40,
                              child: Center(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (product.selectedQty > 0) {
                                        product.selectedQty--;
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "-",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: SizedBox(
                        height: 30,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Color(0xFF222766)),
                          onPressed: () {
                            if (product.selectedQty > 0) {
                              productProvider.addToCart(product);
                              EasyLoading.dismiss();
                              EasyLoading.showSuccess("تم الاضافة الى السلة");
                              // Navigator.pop(context);
                            } else {
                              EasyLoading.dismiss();
                              EasyLoading.showError(
                                  "الرجاء اختيار الكمية التي تريدها");
                            }
                          },
                          child: const Text(
                            'أضف للسلة',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FutureBuilder<List<ProductModel>> newMethod() {
    return FutureBuilder(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: SizedBox(
                  width: 80, height: 80, child: CircularProgressIndicator()));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              ProductModel product = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: SizedBox(
                  width: 150,
                  height: 300,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        side: BorderSide(color: Colors.black26)),
                    child: Wrap(
                      children: [
                        Row(
                          children: const [
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Image.network(
                          product.image,
                          width: 200,
                          height: 100,
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          child: Text(
                            product.name,
                            maxLines: 2,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                          ),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            "${product.finalPrice.toStringAsFixed(2)} دينار اردني",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12)),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          product.selectedQty++;
                                        });
                                      },
                                      child: const Text(
                                        "+",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Center(
                                    child: Text("${product.selectedQty}")),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12)),
                                  width: 40,
                                  height: 40,
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (product.selectedQty > 0) {
                                            product.selectedQty--;
                                          }
                                        });
                                      },
                                      child: const Text(
                                        "-",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: const [
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: SizedBox(
                            height: 30,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  backgroundColor: Color(0xFF222766)),
                              onPressed: () {
                                if (product.selectedQty > 0) {
                                  var productProvider =
                                      Provider.of<ProductProvider>(context,
                                          listen: false);

                                  productProvider.addToCart(product);
                                  EasyLoading.dismiss();
                                  EasyLoading.showSuccess(
                                      "تم الاضافة الى السلة");
                                  // Navigator.pop(context);
                                } else {
                                  EasyLoading.dismiss();
                                  EasyLoading.showError(
                                      "الرجاء اختيار الكمية التي تريدها");
                                }
                              },
                              child: const Text(
                                'أضف للسلة',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
