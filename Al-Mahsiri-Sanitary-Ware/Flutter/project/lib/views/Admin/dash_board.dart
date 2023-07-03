import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/Providers/category_provider.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/views/Admin/categories_page.dart';
import 'package:project/views/Admin/create_subAdmin.dart';
import 'package:project/views/Admin/delete_subadmin.dart';
import 'package:project/views/Admin/delete_users.dart';
import 'package:project/views/Admin/order.dart';
import 'package:project/views/Admin/product_page.dart';
import 'package:project/views/profile_page_basic.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Widget currentPage = const DashBoard();
  bool _isDisposed = false;
  bool isLoading = true;
  String? name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkTypeA();
  }

  _checkTypeA() async {
    if (await const FlutterSecureStorage().containsKey(key: "token")) {
      String? id = await const FlutterSecureStorage().read(key: 'id');

      setState(() {
        if (int.parse(id!) != 41) {
          currentPage = DeleteSubAdmin(
            onBack: () {},
          );
        }
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showName();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            body: Container(),
          ));
    } else {
      return Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: currentPage is DashBoard
                ? Column(
                    children: [
                      const SizedBox(
                        height: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                currentPage = CreateSubAdmin(
                                  onBack: () {
                                    setState(() {
                                      currentPage = const DashBoard();
                                    });
                                  },
                                );
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(40),
                                //
                              ),
                              child: const Center(
                                child: Text(
                                  'اضافة ادمن فرعي',
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
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                currentPage = DeleteUsers(
                                  onBack: () {
                                    setState(() {
                                      currentPage = const DashBoard();
                                    });
                                  },
                                );
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black,
                                  width: 3.0,
                                ),
                                borderRadius: BorderRadius.circular(40),
                                //
                              ),
                              child: const Center(
                                child: Text(
                                  'إدارة الحسابات',
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
                    ],
                  )
                : currentPage,
          ));
    }
  }

  Future<void> showName() async {
    if (_isDisposed) return;

    if (await const FlutterSecureStorage().containsKey(key: 'token')) {
      String? fistName = await FlutterSecureStorage().read(key: 'fistName');
      String? gender = await FlutterSecureStorage().read(key: 'genderId');
      if (int.parse(gender!) == 1) {
        name = "اهلا السيد $fistName";
      } else if (int.parse(gender) == 2) {
        name = "اهلا السيدة $fistName";
      }

      if (!_isDisposed) {
        setState(() {
          final provider =
              Provider.of<CategoryProvider>(context, listen: false);
          provider.name = name!;
        });
      }
    }
  }
}

class BottomNavigationAdmin extends StatefulWidget {
  const BottomNavigationAdmin({super.key});

  @override
  State<BottomNavigationAdmin> createState() => _BottomNavigationAdminState();
}

class _BottomNavigationAdminState extends State<BottomNavigationAdmin> {
  List pages = [
    const DashBoard(),
    const OrdersPage(),
    const CategoriesAdmin(),
    const ProductAdmin(),
    const ProfilePageBasic(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
      _currentPage = pages[currentIndex];
    });
  }

  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _connectedToInternet = true;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        setState(() {
          _connectedToInternet = result != ConnectivityResult.none;
        });
      },
    );
    _currentPage = pages[currentIndex];
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  void checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      _connectedToInternet = connectivityResult != ConnectivityResult.none;
    });
  }

  Widget? _currentPage;
  DateTime timeBackPressed = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    setState(() {
      _currentPage ??= pages[currentIndex];
    });
    return WillPopScope(
      onWillPop: () async {
        final differnce = DateTime.now().difference(timeBackPressed);
        final isExitWarning = differnce >= const Duration(seconds: 2);
        timeBackPressed = DateTime.now();
        if (isExitWarning) {
          const message = "انقر مرتين للخروج";
          Fluttertoast.showToast(msg: message, fontSize: 18);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: Scaffold(
          appBar: productProvider.hideAppBar
              ? null
              : AppBar(
                  backgroundColor: Colors.blue[700],
                  toolbarHeight: 47,
                  title: Row(
                    children: [
                      SizedBox(
                        width: 149,
                        child: Provider.of<CategoryProvider>(context,
                                    listen: false)
                                .name
                                .isNotEmpty
                            ? Text(
                                Provider.of<CategoryProvider>(context,
                                        listen: false)
                                    .name,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                              )
                            : Container(),
                      ),
                      Center(
                        child: SizedBox(
                          width: 150,
                          // height: 150,
                          child: Image.asset(
                            'assets/images/logoAppBar.png',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          body: _connectedToInternet
              ? _currentPage
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.cloud_off,
                        size: 80,
                        color: Colors.grey,
                      ),
                      Text(
                        'لا يوجد اتصال بالإنترنت',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'يرجى التحقق من اتصالك بالإنترنت وحاول مرة أخرى',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
          bottomNavigationBar: productProvider.hideNavigationBar
              ? null
              : BottomNavigationBar(
                  unselectedLabelStyle:
                      const TextStyle(fontSize: 15, color: Colors.black),
                  selectedLabelStyle:
                      TextStyle(fontSize: 15, color: Colors.blue[700]),
                  showUnselectedLabels: true,
                  unselectedItemColor: Colors.grey,
                  selectedItemColor: Colors.blue[700],
                  type: BottomNavigationBarType.fixed,
                  //type: BottomNavigationBarType.shifting,طريقة الكبسة
                  onTap: onTap,
                  currentIndex: currentIndex,
                  // elevation: 0,الخط الفوق
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "الرئيسة",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.request_page,
                      ),
                      label: "الطلبات",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.category),
                      label: "التصنيفات",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_bag_rounded,
                      ),
                      label: "المنتجات",
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_rounded,
                      ),
                      label: "حسابي",
                    ),
                  ],
                )),
    );
  }
}
