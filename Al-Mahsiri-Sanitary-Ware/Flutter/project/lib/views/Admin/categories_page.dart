import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/Providers/category_provider.dart';
import 'package:project/controllers/api_helper.dart';
import 'package:project/controllers/category_controller.dart';
import 'package:project/models/category_model.dart';
import 'package:provider/provider.dart';

class CategoriesAdmin extends StatefulWidget {
  const CategoriesAdmin({super.key});

  @override
  State<CategoriesAdmin> createState() => _CategoriesAdminState();
}

class _CategoriesAdminState extends State<CategoriesAdmin> {
  final createController = TextEditingController();
  final updateController = TextEditingController();
  String _create = "";
  String update = "";

  final _keyFormCreate = GlobalKey<FormState>();
  final _keyFormUpdate = GlobalKey<FormState>();
  final _keyFormDelete = GlobalKey<FormState>();

  int? selectedCategoryU;
  String? categorynameU;
  int? selectedCategoryD;
  String? categorynameD;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<CategoryProvider>(context, listen: false);
    provider.getAllCategoryAdmin();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);
    List<CategoryModel> category = provider.categoriesAdmin;

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
                          "انشاء تصنيف",
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
                              controller: createController,
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
                                hintText: 'اسم التصنيف',
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
                                checkCategory();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال التصنيف";
                                } else if (checkcategory == 1) {
                                  return "إسم التصنيف موجود مسبقا";
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  _create = createController.text;
                                });
                              },
                            ),
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
                          "تحديث تصنيف",
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
                                        selectedCategoryU = value;
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
                                    categorynameU = value.toString();
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: TextFormField(
                              controller: updateController,
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
                                hintText: 'اسم التصنيف الجديد',
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
                              onChanged: (value) {
                                setState(() {
                                  update = updateController.text;
                                });
                              },
                              validator: (value) {
                                checkCategory2();
                                if (value == null || value.isEmpty) {
                                  return "الرجاء إدخال التصنيف";
                                } else if (checkcategory2 == 1) {
                                  return "إسم التصنيف موجود مسبقا";
                                }
                                return null;
                              },
                            ),
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
                                        print(selectedCategoryU);
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
                          "حذف تصنيف",
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
                      CategoryController()
                          .create(CategoryModel(category: _create));
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم اضافة التصنيف بنجاح");
                      createController.text = "";
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
                      CategoryController().delete(selectedCategoryD!);
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم حذف التصنيف بنجاح");
                      createController.text = "";
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
                      CategoryController().update(CategoryModel(
                          id: selectedCategoryU!, category: update));
                      Navigator.pop(context);
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم تحديث التصنيف بنجاح");
                      updateController.text = "";
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

  int checkcategory = 0;
  Future<void> checkCategory() async {
    final category = createController.text;
    dynamic json =
        await ApiHelper().getRequest2("api/Categories/category/$category");
    final count = json.isEmpty ? 0 : 1;
    if (mounted) {
      setState(() {
        checkcategory = count;
      });
    }
  }

  int checkcategory2 = 0;
  Future<void> checkCategory2() async {
    final category = updateController.text;
    dynamic json =
        await ApiHelper().getRequest2("api/Categories/category/$category");
    final count = json.isEmpty ? 0 : 1;
    if (mounted) {
      setState(() {
        checkcategory2 = count;
      });
    }
  }
}
