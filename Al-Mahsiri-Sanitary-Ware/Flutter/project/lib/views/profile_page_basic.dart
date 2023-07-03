// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/Providers/category_provider.dart';
import 'package:project/Providers/order_provider.dart';
import 'package:project/Providers/user_provider.dart';
import 'package:project/views/profile_page.dart';
import 'package:project/views/reset_password_page.dart';
import 'package:provider/provider.dart';

class ProfilePageBasic extends StatefulWidget {
  const ProfilePageBasic({super.key});

  @override
  State<ProfilePageBasic> createState() => _ProfilePageBasicState();
}

class _ProfilePageBasicState extends State<ProfilePageBasic> {
  Widget _currentPage = const ProfilePageBasic();
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
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
            child: _currentPage is ProfilePageBasic
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
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
                                  _currentPage = ProfilePage(onBack: () {
                                    setState(() {
                                      _currentPage = ProfilePageBasic();
                                    });
                                  });
                                });
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
                                    'تحديث المعلومات الشخصية',
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
                        SizedBox(
                          height: 90,
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
                                  _currentPage = RestPasswordPage(
                                    onBack: () {
                                      setState(() {
                                        _currentPage = ProfilePageBasic();
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
                                    'تغير كلمة المرور',
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
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 180, right: 230, left: 40),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            color: Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () async {
                                      FlutterSecureStorage storage =
                                          const FlutterSecureStorage();
                                      await storage.deleteAll();
                                      Provider.of<CategoryProvider>(context,
                                              listen: false)
                                          .name = "";
                                      userProvider.user = null;
                                      Provider.of<OrderProvider>(context,
                                              listen: false)
                                          .orders
                                          .clear();
                                      Navigator.pushReplacementNamed(
                                        context,
                                        "/bottomnavigation",
                                      );
                                      EasyLoading.dismiss();
                                      EasyLoading.showSuccess(
                                          "تم تسجيل الخروج بنجاح");
                                    },
                                    child: Row(
                                      children: const [
                                        Text(
                                          'لتسجيل خروج',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.login,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : _currentPage,
          ),
        ));
  }
}
