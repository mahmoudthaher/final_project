import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/Providers/order_product_provider.dart';
import 'package:project/controllers/order_controller.dart';
import 'package:project/models/order.dart';
import 'package:project/models/order_mpdel.dart';
import 'package:project/models/order_product_model.dart';
import 'package:project/views/my_order_page.dart';
import 'package:project/views/order_detail.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  int? orderId;
  Widget _currentPage = const OrdersPage();
  List<OrderModel> orders = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
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
          body: _currentPage is OrdersPage
              ? _isLoading
                  ? orders.isEmpty
                      ? Container(
                          margin: EdgeInsets.only(bottom: 75),
                          child: const Center(
                            child: Text(
                              "لا يوجد طلبات جديدة",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : Container() //
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        OrderModel order = orders[index];
                        return SizedBox(
                          height: 120,
                          child: InkWell(
                            child: Card(
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      SizedBox(width: 20),
                                      Text(
                                        "المجموع : ${order.total.toStringAsFixed(2)}",
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(width: 50),
                                      Column(
                                        children: [
                                          Text(
                                            "رقم الهاتف : ${order.user?.phoneNumber}",
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                          Text(
                                            "ايميل : ${order.user?.email}",
                                            style:
                                                const TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            orderId = order.id;
                                            messageUpdate(context);
                                          });
                                        },
                                        child: const Text(
                                          "تاكيد الطلب",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () {
                                          setState(() {
                                            orderId = order.id;
                                            messageDelete(context);
                                          });
                                        },
                                        child: const Text("حذف الطلب",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {
                              setState(() {
                                orderProvider.orderId = order.id;
                                _currentPage = OrderDetailPage(
                                  onBack: () {
                                    setState(() {
                                      _currentPage = const OrdersPage();
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
                        _currentPage = const OrdersPage();
                      },
                    );
                  },
                )),
    );
  }

  messageUpdate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد الطلب'),
          content:
              const Text('يرجى قبل تأكيد الطلب الاتصال الرقم الظاهر اعلاه'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'رجوع',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 220,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'تأكيد',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    onTap: () async {
                      OrderController().modifyStatusOrder(OrderModel(
                          id: orderId!,
                          paymentMethodId: 1,
                          total: 1,
                          taxAmount: 1,
                          subTotal: 1));

                      Navigator.pop(context);
                      await fetchData();
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم تأكيد الطلب بنجاح");
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  messageDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تأكيد عملية حذف الطلب'),
          content: const Text(
              'يرجى قبل حذف الطلب الاتصال الرقم الظاهر اعلاه لتأكيد على عملية الغاء الطلب'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'رجوع',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 220,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'حذف',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    onTap: () async {
                      OrderController().delete(orderId!);

                      Navigator.pop(context);
                      await fetchData();
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم عملية حذف الطلب بنجاح");
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> fetchData() async {
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      List<OrderModel> fetch = await OrderController().callOrder();
      setState(() {
        _isLoading = false;
        orders = fetch;
      });
    } catch (error) {
      rethrow;
    }
  }
}
