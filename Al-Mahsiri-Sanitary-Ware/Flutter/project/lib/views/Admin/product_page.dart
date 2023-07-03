import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/Providers/category_provider.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/controllers/api_helper.dart';
import 'package:project/controllers/category_controller.dart';
import 'package:project/controllers/product_controller.dart';
import 'package:project/models/category_model.dart';
import 'package:project/models/product_model.dart';
import 'package:provider/provider.dart';

class ProductAdmin extends StatefulWidget {
  const ProductAdmin({super.key});

  @override
  State<ProductAdmin> createState() => _ProductAdminState();
}

class _ProductAdminState extends State<ProductAdmin> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final quantityInSstockController = TextEditingController();
  final imageontroller = TextEditingController();
  final selectedCategoryController = TextEditingController();
  final nameController2 = TextEditingController();
  final priceController2 = TextEditingController();
  final quantityInSstockController2 = TextEditingController();
  final imageontroller2 = TextEditingController();
  final selectedCategoryController2 = TextEditingController();
  String? name;
  double? price;
  int? quantityInSstock;
  String? image;
  int? selectedCategory;
  String? name2;
  double? price2;
  int? quantityInSstock2;
  String? image2;
  int? selectedCategory2;
  ProductModel? product2;

  final _keyFormCreate = GlobalKey<FormState>();
  final _keyFormUpdate = GlobalKey<FormState>();
  final _keyFormDelete = GlobalKey<FormState>();
  int? selectedCategoryC;
  String? categorynameC;
  int? selectedCategoryU;
  String? categorynameU;
  int? selectedCategoryU2;
  String? categorynameU2;
  int? selectedCategoryD;
  String? categorynameD;
  String? uniqueNameUpdate;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<CategoryProvider>(context, listen: false);
    provider.getAllCategoryAdmin();
    var providerProduct = Provider.of<ProductProvider>(context, listen: false);
    providerProduct.getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);
    List<CategoryModel> category = provider.categoriesAdmin;
    var providerProduct = Provider.of<ProductProvider>(context);
    List<ProductModel> product = providerProduct.productsAll;

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
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Text(
                          "انشاء منتج",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Form(
                      key: _keyFormCreate,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: nameController,
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
                                hintText: 'اسم المنتج',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                checkProduct();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال المنتج";
                                } else if (checkproduct == 1) {
                                  return "إسم المنتج موجود مسبقا";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  name = nameController.text;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: priceController,
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
                                hintText: 'السعر',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                // checkCategory();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال السعر";
                                } else if (double.tryParse(value) == null) {
                                  return "الرجاء إدخال رقم بشكل صحيح";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (double.tryParse(value) != null) {
                                    price = double.parse(priceController.text);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: quantityInSstockController,
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
                                hintText: 'عدد الكمية الموجودة',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                // checkCategory();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال عدد الكمية الموجودة";
                                } else if (int.tryParse(value) == null) {
                                  return "الرجاء إدخال رقم بشكل صحيح";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (int.tryParse(value) != null) {
                                    quantityInSstock = int.parse(
                                        quantityInSstockController.text);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: imageontroller,
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
                                hintText: 'رابط الصورة',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                // checkCategory();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال رابط الصورة";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  image = imageontroller.text;
                                });
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                style: BorderStyle.solid,
                                width: 0.4,
                                color: Colors.black,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 25),
                              child: SizedBox(
                                child: DropdownButtonFormField(
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    errorStyle: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700),
                                    border: InputBorder.none,
                                  ),
                                  value: selectedCategoryC,
                                  hint: const Text(
                                    'تحديد التصنيف',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  items: category.map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.category,
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
                                        selectedCategoryC = value;
                                      });
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'الرجاء ادخال التصنيف';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    categorynameC = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                  if (mounted) {
                                    setState(() {
                                      if (_keyFormCreate.currentState!
                                          .validate()) {
                                        messageCreate(context);
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
                                      'إنشاء',
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
                            height: 20,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 0.1,
                            child: Divider(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          "تحديث المنتج",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Form(
                      key: _keyFormUpdate,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                style: BorderStyle.solid,
                                width: 0.4,
                                color: Colors.black,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 25),
                              child: SizedBox(
                                child: DropdownButtonFormField(
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    errorStyle: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700),
                                    border: InputBorder.none,
                                  ),
                                  value: selectedCategoryU,
                                  hint: const Text(
                                    'تحديد المنتج',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  items: product.map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.name,
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
                                        selectedCategoryU = value;

                                        ProductController()
                                            .getProductsById(selectedCategoryU!)
                                            .then((value) {
                                          setState(() {
                                            product2 = value;
                                          });
                                        }).then((value) {
                                          uniqueNameUpdate = product2!.name;
                                          nameController2.text = product2!.name;
                                          priceController2.text =
                                              product2!.price.toString();
                                          quantityInSstockController2.text =
                                              product2!.quantityInStock
                                                  .toString();
                                          imageontroller2.text =
                                              product2!.image;
                                          selectedCategoryU2 =
                                              product2!.categoryId;
                                        });
                                      });
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'الرجاء ادخال المنتج';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    categorynameU = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: nameController2,
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
                                hintText: 'اسم المنتج',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                checkProduct2();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال المنتج";
                                } else if (nameController2.text !=
                                    uniqueNameUpdate) {
                                  if (checkproduct2 == 1) {
                                    return "إسم المنتج موجود مسبقا";
                                  }
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  name2 = nameController2.text;
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: priceController2,
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
                                hintText: 'السعر',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                // checkCategory();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال السعر";
                                } else if (double.tryParse(value) == null) {
                                  return "الرجاء إدخال رقم بشكل صحيح";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (double.tryParse(value) != null) {
                                    price2 =
                                        double.parse(priceController2.text);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: quantityInSstockController2,
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
                                hintText: 'عدد الكمية الموجودة',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                // checkCategory();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال عدد الكمية الموجودة";
                                } else if (int.tryParse(value) == null) {
                                  return "الرجاء إدخال رقم بشكل صحيح";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  if (int.tryParse(value) != null) {
                                    quantityInSstock2 = int.parse(
                                        quantityInSstockController2.text);
                                  }
                                });
                              },
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: imageontroller2,
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
                                hintText: 'رابط الصورة',
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
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.w700),
                                counterText: '',
                              ),
                              validator: (value) {
                                // checkCategory();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال رابط الصورة";
                                }

                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  image2 = imageontroller2.text;
                                });
                              },
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                style: BorderStyle.solid,
                                width: 0.4,
                                color: Colors.black,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 25),
                              child: SizedBox(
                                child: DropdownButtonFormField(
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    errorStyle: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700),
                                    border: InputBorder.none,
                                  ),
                                  value: selectedCategoryU2,
                                  hint: const Text(
                                    'تحديد التصنيف',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  items: category.map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.category,
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
                                        selectedCategoryU2 = value;
                                      });
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'الرجاء ادخال التصنيف';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    categorynameU2 = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                  if (mounted) {
                                    setState(() {
                                      if (_keyFormUpdate.currentState!
                                          .validate()) {
                                        messageUpdate(context);
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
                                      'تحديث',
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
                            height: 20,
                          ),
                          const SizedBox(
                            width: double.infinity,
                            height: 0.1,
                            child: Divider(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: const [
                        Text(
                          "حذف المنتج",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Form(
                      key: _keyFormDelete,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                style: BorderStyle.solid,
                                width: 0.4,
                                color: Colors.black,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 25),
                              child: SizedBox(
                                child: DropdownButtonFormField(
                                  icon: const Icon(Icons.arrow_drop_down,
                                      color: Colors.black),
                                  decoration: const InputDecoration(
                                    errorStyle: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w700),
                                    border: InputBorder.none,
                                  ),
                                  value: selectedCategoryD,
                                  hint: const Text(
                                    'تحديد المنتج',
                                    style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  items: product.map((e) {
                                    return DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.name,
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
                                        selectedCategoryD = value;
                                      });
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'الرجاء ادخال المدينة';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    categorynameD = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
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
                                  if (mounted) {
                                    setState(() {
                                      if (_keyFormDelete.currentState!
                                          .validate()) {
                                        messageDelete(context);
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
                                      'حذف',
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
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  messageCreate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تاكيد عملية الانشاء'),
          content: const Text('يرجى التاكيد على عملية الانشاء'),
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
                    width: 200,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'انشاء',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    onTap: () {
                      ProductController().create(ProductModel(
                          name: name!,
                          price: price!,
                          quantityInStock: quantityInSstock!,
                          image: image!,
                          categoryId: selectedCategoryC!));
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم اضافة المنتج بنجاح");
                      nameController.text = "";
                      priceController.text = "";
                      quantityInSstockController.text = "";
                      imageontroller.text = "";
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
          title: const Text('تاكيد عملية الحذف'),
          content: const Text('يرجى التاكيد على عملية الحذف'),
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
                    width: 200,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'حذف',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    onTap: () {
                      ProductController().delete(selectedCategoryD!);
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم حذف المنتج بنجاح");
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

  messageUpdate(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تاكيد عملية التحديث'),
          content: const Text('يرجى التاكيد على عملية التحديث'),
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
                    width: 200,
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    child: const Text(
                      'تحديث',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    onTap: () {
                      ProductController().update(ProductModel(
                          id: selectedCategoryU!,
                          name: nameController2.text,
                          price: double.parse(priceController2.text),
                          quantityInStock:
                              int.parse(quantityInSstockController2.text),
                          image: imageontroller2.text,
                          categoryId: selectedCategoryU2!));
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم تحديث التصنيف بنجاح");
                      nameController2.text = "";
                      priceController2.text = "";
                      quantityInSstockController2.text = "";
                      imageontroller2.text = "";
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

  int checkproduct = 0;
  Future<void> checkProduct() async {
    final product = name;
    dynamic json =
        await ApiHelper().getRequest2("api/Products/product/$product");
    final count = json.isEmpty ? 0 : 1;
    if (mounted) {
      setState(() {
        checkproduct = count;
      });
    }
  }

  int checkproduct2 = 0;
  Future<void> checkProduct2() async {
    final product = name2;
    dynamic json =
        await ApiHelper().getRequest2("api/Products/product/$product");
    final count = json.isEmpty ? 0 : 1;
    if (mounted) {
      setState(() {
        checkproduct2 = count;
      });
    }
  }
}
