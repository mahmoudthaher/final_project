// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/controllers/location_controller.dart';
import 'package:project/models/product_model.dart';
import 'package:project/views/order_checkout_page.dart';
import 'package:project/views/summery_widget.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer(
          builder: (context, ProductProvider productProvider, child) {
            if (productProvider.selectedProducts.isEmpty) {
              return Container(
                margin: EdgeInsets.only(bottom: 75),
                child: const Center(
                    child: Text(
                  "لا يوجد منتجات في السلة",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )),
              );
            }
            return Column(
              children: [
                Expanded(
                  flex: 5,
                  child: _productsListWidget(productProvider),
                ),
                SummeryWidget(),
                _buttonCheckoutWidget(context)
              ],
            );
          },
        ),
      ),
    );
  }

  SizedBox _buttonCheckoutWidget(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              _handleBeginCheckoutAction(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Center(
                child: Text(
                  'أرسل',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView _productsListWidget(ProductProvider productProvider) {
    return ListView.builder(
      itemCount: productProvider.selectedProducts.length,
      itemBuilder: (context, index) {
        ProductModel product = productProvider.selectedProducts[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            leading: Container(
              width: 60,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(product.image),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "المجموع : ${product.total.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            trailing: Container(
              margin: const EdgeInsets.only(top: 12),
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      try {
                        productProvider.updateQty(
                            product, product.selectedQty + 1);
                      } catch (ex) {
                        print(ex);
                      }
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "${product.selectedQty}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (product.selectedQty == 1) {
                        productProvider.removeProduct(index);
                        return;
                      }
                      productProvider.updateQty(
                          product, product.selectedQty - 1);
                    },
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color:
                            product.selectedQty == 1 ? Colors.red : Colors.blue,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        product.selectedQty == 1 ? Icons.delete : Icons.remove,
                        color: Colors.white,
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

  _handleBeginCheckoutAction(BuildContext context) async {
    bool exists = await FlutterSecureStorage().containsKey(key: "token");

    if (exists) {
      _handleGoToOrderCheckout(context);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('غير مسجل'),
            content: const Text(
                'انتا غير مسجل يرجى الذهاب الى حسابي لتسجيل الدخول ويمكنك العودة مرة اخرى الى السلة لاتمام عملية الطلب'),
            actions: [
              // InkWell(
              //   splashColor: Colors.transparent,
              //   highlightColor: Colors.transparent,
              //   child: const Text(
              //     'الذهاب الى صفحة تسجيل الدخول',
              //     style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              //   ),
              //   onTap: () {
              //     Navigator.pushNamed(context, "/loginPage");
              //   },
              // ),
              const SizedBox(
                width: 30,
              ),
              InkWell(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: const Text(
                  'حسنا',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  _handleGoToOrderCheckout(BuildContext context) async {
    try {
      EasyLoading.show(status: "جاري تحديد الموقع");
      Position location = await LocationController().determinePosition();
      if (mounted) {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderCheckoutPage(location),
            ),
          );
        });
      }

      EasyLoading.dismiss();
    } catch (ex) {
      EasyLoading.dismiss();
      EasyLoading.showError(ex.toString());
    }
  }
}
