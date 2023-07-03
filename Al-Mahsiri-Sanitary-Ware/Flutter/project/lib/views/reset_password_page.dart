// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/Providers/user_provider.dart';
import 'package:project/controllers/user_controller.dart';
import 'package:project/models/user_model.dart';
import 'package:provider/provider.dart';

class RestPasswordPage extends StatefulWidget {
  final VoidCallback onBack;

  const RestPasswordPage({required this.onBack, super.key});

  @override
  State<RestPasswordPage> createState() => _RestPasswordPageState();
}

class _RestPasswordPageState extends State<RestPasswordPage> {
  final storage = const FlutterSecureStorage();
  final _keyForm = GlobalKey<FormState>();
  bool obscureText = false;
  bool obscureText2 = false;

  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            resizeToAvoidBottomInset: false,
            body: Form(
              key: _keyForm,
              child: SingleChildScrollView(
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.black,
                                size: 30,
                              ),
                              onTap: () {
                                widget.onBack();
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextFormField(
                            controller: passwordController,
                            //maxLength: 20,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.name,
                            maxLength: 20,
                            obscureText: !obscureText,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور',
                              hintStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 30, left: 15),
                              border: const OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
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
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextFormField(
                            controller: repasswordController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.name,
                            maxLength: 20,
                            obscureText: !obscureText2,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: InputDecoration(
                              hintText: 'إعادة كلمة المرور',
                              hintStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: const EdgeInsets.only(
                                  top: 5, bottom: 5, right: 30, left: 15),
                              border: const OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                              suffix: InkWell(
                                onTap: () {
                                  setState(() {
                                    obscureText2 = !obscureText2;
                                  });
                                },
                                child: obscureText2
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                              counterText: '',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرجاء إعادة إدخال كلمة المرور";
                              } else if (value != passwordController.text) {
                                return "كلمة المرور غير متطابقة";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                if (_keyForm.currentState!.validate()) {
                                  _resetPassword();
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> _resetPassword() async {
    try {
      String? id = await storage.read(key: 'id');
      if (id != null) {
        String password = passwordController.text;
        UserController().resetPassword(UserModel(id: id, password: password));
        EasyLoading.dismiss();
        EasyLoading.showSuccess("تم نغير كلمة المرور بنجاح");

        widget.onBack();
      } else {
        String password = passwordController.text;
        final provider = Provider.of<UserProvider>(context, listen: false);
        UserController().resetPassword(
            UserModel(id: provider.forgetId.toString(), password: password));
        EasyLoading.dismiss();
        EasyLoading.showSuccess(
            "تم نغير كلمة المرور بنجاح يمكن التوجه الى حسابي لتسجيل الدخول");
        provider.forgetId = 0;
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/bottomnavigation",
          (route) => false,
        );
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError(e.toString());
    }
  }
}
