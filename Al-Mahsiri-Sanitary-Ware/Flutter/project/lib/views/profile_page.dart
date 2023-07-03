// ignore_for_file: constant_identifier_names

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/Providers/category_provider.dart';
import 'package:project/Providers/city_provider.dart';
import 'package:project/Providers/user_provider.dart';
import 'package:project/controllers/api_helper.dart';
import 'package:project/controllers/user_controller.dart';
import 'package:project/models/city_model.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final VoidCallback onBack;
  const ProfilePage({required this.onBack, super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

enum SingingCharacter { Male, Female }

//enum SingingCharacter2 { User, Admin }

class _ProfilePageState extends State<ProfilePage> {
  final storage = FlutterSecureStorage();
  int typeId = 1;
  bool _isLoggedIn = false;
  String? idUser;
  String? phoneNumber2;
  String? userName2;
  String? email2;

  int checkemail = 0;
  int checkphoneNumber = 0;
  int checkuserName = 0;

  //UserModel? user;
  int? selectedName;
  int? checkgender;
  String? cityname;
  SingingCharacter? _character = SingingCharacter.Male;
  //SingingCharacter2? _character2 = SingingCharacter2.User;
  final dateController = TextEditingController();
  bool obscureText = false;
  bool obscureText2 = false;
  final _keyForm = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final addressController = TextEditingController();
  final dateofdateController = TextEditingController();
  final passwordController = TextEditingController();
  final repasswordController = TextEditingController();
  late bool visible = false;
  final RegExp jordanianPhoneNumberRegExp = RegExp(
    r'^(078|079|077)[0-9]{7}$',
    caseSensitive: false,
    multiLine: false,
  );
  bool validateJordanianPhoneNumber(String phoneNumber) {
    return jordanianPhoneNumberRegExp.hasMatch(phoneNumber);
  }

  @override
  void initState() {
    super.initState();
    var provider = Provider.of<CityProvider>(context, listen: false);
    provider.getAllCities();
    checkType();

    _checkLogin().then(
      (isLoggedIn) {
        setState(
          () {
            print(isLoggedIn);
            _isLoggedIn = isLoggedIn;
            if (_isLoggedIn) {
              EasyLoading.dismiss();
              EasyLoading.show(status: "Loading");
              _showUserInfo();
              EasyLoading.dismiss();
              EasyLoading.showSuccess("تسطيع هنا تحديث معلوماتك");
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CityProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    List<CityModel> cities = provider.cities;
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
              child: SingleChildScrollView(
                child: Form(
                  key: _keyForm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
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
                                  widget.onBack();
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextFormField(
                            controller: firstnameController,
                            maxLength: 15,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.name,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: const InputDecoration(
                              hintText: 'الإسم الأول',
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              border: OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                              counterText: '',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرجاء إدخال الإسم الأول";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextFormField(
                            controller: lastnameController,
                            maxLength: 15,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.name,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: const InputDecoration(
                              hintText: 'الإسم الأخير',
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              border: OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                              counterText: '',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرجاء إدخال الإسم الأخير";
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 115,
                          child: TextFormField(
                            controller: phoneNumberController,
                            maxLength: 10,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.phone,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: const InputDecoration(
                              hintText: 'رقم الهاتف',
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              border: OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                              errorMaxLines: 2,
                              counterText: '',
                            ),
                            validator: (value) {
                              checkPhoneNumber();
                              if (value == null || value.isEmpty) {
                                return "الرجاء إدخال رقم الهاتف";
                              } else if (!validateJordanianPhoneNumber(value)) {
                                return " الرجاء إدخال رقم الهاتف بطريقة صحيحة 07xxxxxxxx";
                              } else if (_isLoggedIn == false &&
                                  checkphoneNumber == 1) {
                                return "رقم الهاتف موجود مسبقا";
                              } else if (_isLoggedIn &&
                                  phoneNumberController.text != phoneNumber2) {
                                if (checkphoneNumber == 1) {
                                  return "رقم الهاتف موجود مسبقا";
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextFormField(
                            controller: emailController,
                            maxLength: 30,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.emailAddress,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: const InputDecoration(
                              hintText: 'البريد الإلكتروني',
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              border: OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                              counterText: '',
                            ),
                            validator: (value) {
                              checkEmail();
                              if (value == null || value.isEmpty) {
                                return "الرجاء إدخال البريد الإلكتروني";
                              } else if (!EmailValidator.validate(value)) {
                                return "الرجاء إدخال البريد الإلكتروني بطريقة صحيحة";
                              } else if (_isLoggedIn == false &&
                                  checkemail == 1) {
                                return "الايميل موجود مسبقا";
                              } else if (_isLoggedIn &&
                                  emailController.text != email2) {
                                if (checkemail == 1) {
                                  return "الايميل موجود مسبقا";
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextFormField(
                            controller: userNameController,
                            maxLength: 15,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w500),
                            keyboardType: TextInputType.name,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: const InputDecoration(
                              hintText: 'إسم المستخدم',
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              border: OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                              counterText: '',
                            ),
                            validator: (value) {
                              checkUserName();
                              if (value == null || value.isEmpty) {
                                return "الرجاء إدخال إسم المستخدم";
                              } else if (_isLoggedIn == false &&
                                  checkuserName == 1) {
                                return "إسم المستخدم موجود مسبقا";
                              } else if (_isLoggedIn &&
                                  userNameController.text != userName2) {
                                if (checkuserName == 1) {
                                  return "إسم المستخدم موجود مسبقا";
                                } else if (value.length < 8) {
                                  return "إسم المستخدم يجب ان يكون مكون من 8 خانات على الأقل";
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100,
                          child: TextFormField(
                            controller: addressController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            style: const TextStyle(
                                fontSize: 20,
                                height: 2,
                                fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.name,
                            cursorHeight: 50,
                            cursorWidth: 2,
                            decoration: const InputDecoration(
                              hintText: 'الموقع',
                              hintStyle: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w800),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              border: OutlineInputBorder(
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
                                  fontSize: 15.0, fontWeight: FontWeight.w700),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "الرجاء إدخال الموقع";
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: selectedName == null ? 1 : 0.4,
                              color: selectedName == null
                                  ? Colors.red
                                  : Colors.black,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 25),
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.black),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                value: selectedName,
                                hint: const Text(
                                  'تحديد المنطقة',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                items: cities.map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(
                                      e.city,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          height: 1.0),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  if (mounted) {
                                    setState(() {
                                      selectedName = value;
                                    });
                                  }
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  // if (value == null) {
                                  //   return 'الرجاء ادخال المدينة';
                                  // }
                                  return null;
                                },
                                onSaved: (value) {
                                  cityname = value.toString();
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: selectedName == null
                              ? Row(
                                  children: const [
                                    Padding(
                                      padding: EdgeInsets.only(right: 25),
                                      child: Text(
                                        'الرجاء ادخال المدينة',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : const SizedBox(),
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              style: BorderStyle.solid,
                              width: 0.4,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox.fromSize(
                                size: const Size.fromRadius(20),
                              ),
                              Expanded(
                                flex: 2,
                                child: ListTile(
                                  title: const Text(
                                    'ذكر',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  leading: Radio<SingingCharacter>(
                                    value: SingingCharacter.Male,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      if (mounted) {
                                        setState(() {
                                          _character = value;
                                        });
                                      }
                                    },
                                    activeColor: Colors.black,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ListTile(
                                  title: const Text(
                                    'انثى',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  leading: Radio<SingingCharacter>(
                                    value: SingingCharacter.Female,
                                    groupValue: _character,
                                    onChanged: (SingingCharacter? value) {
                                      if (mounted) {
                                        setState(() {
                                          _character = value;
                                        });
                                      }
                                    },
                                    activeColor: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        _isLoggedIn == false
                            ? SizedBox(
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
                                  obscureText: !obscureText,
                                  cursorHeight: 50,
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    hintText: 'كلمة المرور',
                                    hintStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
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
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
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
                              )
                            : Container(),
                        _isLoggedIn == false
                            ? SizedBox(
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
                                  obscureText: !obscureText2,
                                  cursorHeight: 50,
                                  cursorWidth: 2,
                                  decoration: InputDecoration(
                                    hintText: 'إعادة كلمة المرور',
                                    hintStyle: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
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
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w700),
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
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "الرجاء إعادة إدخال كلمة المرور";
                                    } else if (value !=
                                        passwordController.text) {
                                      return "كلمة المرور غير متطابقة";
                                    }
                                    return null;
                                  },
                                ),
                              )
                            : Container(),
                        Visibility(
                          // visible: visible,
                          child: SizedBox(
                            width: 220,
                            height: 50,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                if (mounted) {
                                  setState(() {
                                    if (_isLoggedIn == false &&
                                        _keyForm.currentState!.validate()) {
                                      try {
                                        _keyForm.currentState!.save();
                                        EasyLoading.show(status: "Loading");
                                        UserController()
                                            .create(userProvider.profileUser(
                                                "",
                                                firstnameController.text,
                                                lastnameController.text,
                                                phoneNumberController.text,
                                                emailController.text,
                                                userNameController.text,
                                                addressController.text,
                                                selectedName!.toString(),
                                                (_character!.index + 1)
                                                    .toString(),
                                                1.toString(),
                                                passwordController.text))
                                            .then((value) {
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
                                              // signup().then((value) => signin());
                                              // if (_character2!.index + 1 == 2) {
                                              //   Navigator
                                              //       .pushNamedAndRemoveUntil(
                                              //     context,
                                              //     "/bottomNavigationAdmin",
                                              //     (route) => false,
                                              //   );
                                              // }
                                              Navigator.pushReplacementNamed(
                                                context,
                                                "/bottomnavigation",
                                              );
                                            }).catchError((ex) {
                                              print("1$ex");
                                            });
                                          }).catchError((ex) {
                                            print("2$ex");
                                          });
                                        }).catchError((ex) {
                                          print("3$ex");
                                        });
                                        EasyLoading.dismiss();
                                        EasyLoading.showSuccess(
                                            "تم تسجيل الحساب");
                                      } catch (error) {
                                        EasyLoading.dismiss();
                                        EasyLoading.showError(error.toString());
                                      }
                                    } else if (_isLoggedIn == true &&
                                        _keyForm.currentState!.validate()) {
                                      try {
                                        _keyForm.currentState!.save();
                                        EasyLoading.show(status: "Loading");
                                        UserController()
                                            .update(userProvider.profileUser(
                                                idUser!,
                                                firstnameController.text,
                                                lastnameController.text,
                                                phoneNumberController.text,
                                                emailController.text,
                                                userNameController.text,
                                                addressController.text,
                                                selectedName!.toString(),
                                                (_character!.index + 1)
                                                    .toString(),
                                                typeId.toString(),
                                                passwordController.text))
                                            .then((value) {
                                          UserController()
                                              .informationUser(
                                            emailController.text,
                                          )
                                              .then((value) {
                                            EasyLoading.dismiss();
                                            EasyLoading.showSuccess(
                                                "تم تحديث معلومات الحساب");
                                            widget.onBack();
                                          }).catchError((ex) {
                                            print("1$ex");
                                          });
                                        }).catchError((ex) {
                                          print("2$ex");
                                        });
                                      } catch (error) {
                                        EasyLoading.dismiss();
                                        EasyLoading.showError(error.toString());
                                      }
                                    }
                                  });
                                }
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
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<void> checkType() async {
    if (await const FlutterSecureStorage().containsKey(key: 'token')) {
      String? type = await FlutterSecureStorage().read(key: 'typeId');
      if (int.parse(type!) == 2) {
        setState(() {
          typeId = 2;
        });
      }
    }
  }

  Future<void> checkEmail() async {
    final email = emailController.text;
    dynamic json = await ApiHelper().getRequest2("api/Users/email/$email");
    final count = json.isEmpty ? 0 : 1;
    if (mounted) {
      setState(() {
        checkemail = count;
      });
    }
  }

  Future<void> checkPhoneNumber() async {
    final phoneNumber = phoneNumberController.text;
    dynamic json =
        await ApiHelper().getRequest2("api/Users/phonenumber/$phoneNumber");
    final count = json.isEmpty ? 0 : 1;
    if (mounted) {
      setState(() {
        checkphoneNumber = count;
      });
    }
  }

  Future<void> checkUserName() async {
    final userName = userNameController.text;
    dynamic json =
        await ApiHelper().getRequest2("api/Users/username/$userName");
    final count = json.isEmpty ? 0 : 1;
    if (mounted) {
      setState(() {
        checkuserName = count;
      });
    }
  }

  Future<void> _showUserInfo() async {
    String? id = await storage.read(key: 'id');
    String? fistName = await storage.read(key: 'fistName');
    String? lastName = await storage.read(key: 'lastName');
    String? phoneNumber = await storage.read(key: 'phoneNumber');
    String? email = await storage.read(key: 'email');
    String? userName = await storage.read(key: 'userName');
    String? address = await storage.read(key: 'address');
    String? genderId = await storage.read(key: 'genderId');
    String? typeId2 = await storage.read(key: 'typeId');
    String? cityId = await storage.read(key: 'cityId');
    idUser = id;
    phoneNumber2 = phoneNumber;
    email2 = email;
    userName2 = userName;
    firstnameController.text = fistName!;
    lastnameController.text = lastName!;
    phoneNumberController.text = phoneNumber!;
    emailController.text = email!;
    userNameController.text = userName!;
    addressController.text = address!;
    selectedName = int.parse(cityId!);
    int checkgender = int.parse(genderId!);
    if (checkgender == 1) {
      _character = SingingCharacter.Male;
    } else {
      _character = SingingCharacter.Female;
    }
  }

  _checkLogin() async {
    bool hasToken = await storage.containsKey(key: "token");
    return hasToken;
  }

  Future signup() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  Future signin() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }
}
