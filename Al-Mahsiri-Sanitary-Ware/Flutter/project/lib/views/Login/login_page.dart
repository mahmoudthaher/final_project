// ignore_for_file: use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/Providers/user_provider.dart';
import 'package:project/controllers/user_controller.dart';
import 'package:project/main.dart';
import 'package:project/views/Login/forget_password.dart';
import 'package:project/views/profile_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _currentPage = const LoginPage();
  final _keyForm = GlobalKey<FormState>();
  bool obscureText = false;
  final emailController = TextEditingController();
  bool enable = false;
  final passwordController = TextEditingController();
  final loginController = TextEditingController();

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
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: _currentPage is LoginPage
                ? SafeArea(
                    child: SingleChildScrollView(
                      child: Form(
                        key: _keyForm,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 40),
                              child: const Image(
                                image:
                                    AssetImage('assets/images/logoLogin.png'),
                                height: 175,
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      height: 2,
                                      fontWeight: FontWeight.w500),
                                  maxLength: 30,
                                  //cursorColor: const Color(0xFF009688),
                                  cursorHeight: 50,
                                  cursorWidth: 2,
                                  decoration: const InputDecoration(
                                      hintText: 'البريد الإلكتروني',
                                      hintStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 5),
                                      border: OutlineInputBorder(
                                        //borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 3.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                      ),
                                      errorStyle: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700),
                                      counterText: '',
                                      errorMaxLines: 2),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "الرجاء إدخال البريد الإلكتروني";
                                    } else if (!EmailValidator.validate(
                                        value)) {
                                      return "الرجاء إدخال البريد الإلكتروني بطريقة صحيحة";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 50),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  maxLength: 20,
                                  controller: passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: !obscureText,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      height: 2,
                                      fontWeight: FontWeight.w500),
                                  //cursorColor: const Color(0xFF009688),
                                  cursorHeight: 50,
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    hintText: 'كلمة المرور',
                                    hintStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                    contentPadding: const EdgeInsets.only(
                                        left: 25, right: 30, top: 5, bottom: 5),
                                    border: const OutlineInputBorder(
                                      //borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 3.0,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                    ),
                                    errorStyle: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
                                    errorMaxLines: 2,
                                    suffix: InkWell(
                                      onTap: () {
                                        setState(() {
                                          obscureText = !obscureText;
                                        });
                                      },
                                      child: obscureText
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "الرجاء إدخال كلمة المرور";
                                    } else if (value.length < 8) {
                                      return "كلمة المرور يجب ان تكون مكونة من 8 خانات على الأقل";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  child: const Text(
                                    "إستعادة كلمة المرور",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _currentPage = ForgetPasswordPage(
                                        onBack: () {
                                          setState(() {
                                            _currentPage = const LoginPage();
                                          });
                                        },
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      if (_keyForm.currentState!.validate()) {
                                        try {
                                          UserController()
                                              .login(userProvider.login(
                                                  emailController.text,
                                                  passwordController.text))
                                              .then((value) {
                                            UserController()
                                                .informationUser(
                                              emailController.text,
                                            )
                                                .then((value) {
                                              checkType();
                                              // setState(() {
                                              // Navigator.pushNamedAndRemoveUntil(
                                              //   context,
                                              //   "/bottomnavigation",
                                              //   (route) => false,
                                              // );
                                              // _currentPage = BottomNavigation();
                                              // });
                                              EasyLoading.dismiss();
                                              EasyLoading.showSuccess(
                                                  "تم تسجيل الدخول بنجاح");
                                            }).catchError((ex) {
                                              print(ex);
                                            });
                                          }).catchError((ex) {
                                            loginController.text =
                                                "إسم المستخدم او كلمة المرور غير صحيحة";
                                          });
                                        } catch (ex) {
                                          EasyLoading.dismiss();
                                          EasyLoading.showError(ex.toString());
                                        }
                                      }
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
                                        'تسجيل الدخول',
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: TextField(
                                style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w800),
                                controller: loginController,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: const [
                                Text(
                                  "غير مسجل حتى الآن؟",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            Row(
                              children: const [
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 100),
                              child: SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    setState(() {
                                      _currentPage = ProfilePage(
                                        onBack: () {
                                          setState(() {
                                            _currentPage = const LoginPage();
                                          });
                                        },
                                      );
                                    });

                                    //   Navigator.pushNamed(context, '/profilePage');
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
                                        'تسجيل حساب',
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
                            Row(
                              children: const [
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : _currentPage,
          ),
        ));
  }

  // int? typeId;
  Future<void> checkType() async {
    if (await const FlutterSecureStorage().containsKey(key: 'token')) {
      String? type = await FlutterSecureStorage().read(key: 'typeId');

      if (int.parse(type!) == 1) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/bottomnavigation",
          (route) => false,
        );
        // typeId = int.parse(type);
      } else if (int.parse(type) == 2) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/bottomNavigationAdmin",
          (route) => false,
        );
        // typeId = int.parse(type);
      }
    }
  }
}
