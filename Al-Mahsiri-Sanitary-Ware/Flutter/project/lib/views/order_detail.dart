import 'package:flutter/material.dart';
import 'package:project/Providers/order_product_provider.dart';
import 'package:project/models/order_product_model.dart';
import 'package:provider/provider.dart';

class OrderDetailPage extends StatefulWidget {
  final VoidCallback onBack;
  const OrderDetailPage({required this.onBack, super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<OrderProductProvider>(context, listen: false);
    provider.getAllOrderdetail();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProductProvider>(context);
    final orderProduct = provider.orderProducts;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          Provider.of<OrderProductProvider>(context,
                                  listen: false)
                              .orderProducts = [];
                          widget.onBack();
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: orderProduct.isEmpty
                      ? const Center(
                          child: SizedBox(
                            width: 80,
                            height: 80,
                            child:
                                CircularProgressIndicator(color: Colors.black),
                          ),
                        )
                      : ListView.builder(
                          itemCount: orderProduct.length,
                          itemBuilder: (context, index) {
                            OrderProductModel orderProducts =
                                orderProduct[index];
                            return SizedBox(
                              height: 100,
                              child: Card(
                                child: ListTile(
                                  leading: Image.network(
                                    orderProducts.products.image,
                                    width: 90,
                                  ),
                                  title: SizedBox(
                                    height: 60,
                                    child: Text(
                                      orderProducts.products.name,
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                      "السعر : ${orderProducts.products.price.toString()}"),
                                  trailing:
                                      Text("العدد : ${orderProducts.qty}"),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ));
  }
}
