// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/Providers/order_product_provider.dart';
import 'package:project/Providers/order_provider.dart';
import 'package:project/models/order_mpdel.dart';
import 'package:project/views/order_detail.dart';
import 'package:provider/provider.dart';

class MyOrederPage extends StatefulWidget {
  const MyOrederPage({super.key});

  @override
  State<MyOrederPage> createState() => _MyOrederPageState();
}

class _MyOrederPageState extends State<MyOrederPage> {
  Widget _currentPage = const MyOrederPage();
  final storage = const FlutterSecureStorage();
  String? idUser;
  bool _isLoading = true;
  bool _showEmptyMessage = false;
  @override
  void initState() {
    super.initState();
    _UserId();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OrderProvider>(context);
    final orders = provider.orders;
    final orderProvider = Provider.of<OrderProductProvider>(context);
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _currentPage is MyOrederPage
              ? _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    )
                  : orders.isEmpty
                      ? _showEmptyMessage
                          ? Container(
                              margin: EdgeInsets.only(bottom: 75),
                              child: const Center(
                                child: Text(
                                  "لم تقم باضافة أي طلب حتى الآن",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          : Container() //
                      : ListView.builder(
                          itemCount: orders.length,
                          itemBuilder: (context, index) {
                            OrderModel order = orders[index];
                            return SizedBox(
                              height: 95,
                              child: InkWell(
                                child: Card(
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          Text(order.createdAt!
                                              .substring(0, 10)),
                                          // const SizedBox(
                                          //   height: 10,
                                          // ),
                                          Text(order.createdAt!
                                              .substring(11, 19)),
                                        ],
                                      ),
                                    ),
                                    title: Text(
                                      "المجموع : ${order.total.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      "المجموع بدون الضريبة : ${order.subTotal.toStringAsFixed(2)}",
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                    trailing: Column(
                                      children: [
                                        SizedBox(
                                            width: 120,
                                            child: Text(
                                                "الحالة : ${order.status?.status}")),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    orderProvider.orderId = order.id;
                                    _currentPage = OrderDetailPage(
                                      onBack: () {
                                        setState(() {
                                          _currentPage = const MyOrederPage();
                                        });
                                      },
                                    );
                                  });
                                },
                              ),
                            );
                          },
                        )
              : OrderDetailPage(
                  onBack: () {
                    setState(
                      () {
                        _currentPage = const MyOrederPage();
                      },
                    );
                  },
                ),
        ));
  }

  Future<void> _UserId() async {
    String? idUser = await storage.read(key: 'id');
    final provider = Provider.of<OrderProvider>(context, listen: false);

    if (idUser != null) {
      provider.userId = idUser;
      provider.getAllOrders();
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _isLoading = false;
        _showEmptyMessage = provider.orders.isEmpty;
      });
    } else {
      setState(() {
        _isLoading = false;
        _showEmptyMessage = true;
      });
    }
  }
}
