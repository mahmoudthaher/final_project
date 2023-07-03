import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/models/product_model.dart';
import 'package:provider/provider.dart';

class FliterPage extends StatefulWidget {
  final VoidCallback onBack;
  const FliterPage({required this.onBack, super.key});

  @override
  State<FliterPage> createState() => _FliterPageState();
}

class _FliterPageState extends State<FliterPage> {
  final fliterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    var products = productProvider.productsFilter;

    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (txt) {
                      setState(() {
                        if (txt.isNotEmpty) {
                          productProvider.checkFliter = true;
                          productProvider.name = txt;
                          productProvider.filterProduct();
                        } else {
                          productProvider.checkFliter = false;
                          products.clear();
                        }
                      });
                    },
                    keyboardType: TextInputType.name,
                    style: const TextStyle(
                        fontSize: 20, height: 2, fontWeight: FontWeight.w600),
                    cursorHeight: 40,
                    cursorWidth: 2,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Wrap(
                          alignment: WrapAlignment.end,
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.grey,
                              size: 30,
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                                size: 30,
                              ),
                              onTap: () {
                                productProvider.checkFliter = false;
                                products.clear();
                                productProvider.hideAppBar = false;
                                productProvider.hideNavigationBar = false;
                                widget.onBack();
                              },
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                      hintText: 'بحث',
                      hintStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w800),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1,
                    width: double.infinity,
                    child: Container(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  productProvider.checkFliter == true
                      ? products.isEmpty
                          ? const Expanded(
                              child: Center(
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(
                                      color: Colors.black),
                                ),
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Card(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                              side: BorderSide(
                                                  color: Colors.black26)),
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
                                                    placeholder:
                                                        (context, url) =>
                                                            const Align(
                                                      alignment:
                                                          Alignment.center,
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
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  child: Text(
                                                    product.name,
                                                    maxLines: 2,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Text(
                                                        "${product.finalPrice.toStringAsFixed(2)} د.أ",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    IconButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              // borderRadius:
                                                              //     BorderRadius.circular(40),
                                                              ),
                                                          backgroundColor:
                                                              Colors.white,
                                                        ),
                                                        onPressed: () {
                                                          productProvider
                                                              .addToCart(
                                                                  product);
                                                          EasyLoading.dismiss();
                                                          EasyLoading.showSuccess(
                                                              "تم الاضافة الى السلة");
                                                        },
                                                        icon: const Icon(
                                                          Icons
                                                              .add_shopping_cart,
                                                          size: 30,
                                                        )),
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
                      : Container()
                ],
              ),
            ),
          ),
        ));
  }
}
