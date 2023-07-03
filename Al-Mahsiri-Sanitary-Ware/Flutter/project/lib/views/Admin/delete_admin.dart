import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:project/controllers/user_controller.dart';
import 'package:project/models/user_model.dart';

class DeleteAdmin extends StatefulWidget {
  final VoidCallback onBack;

  const DeleteAdmin({required this.onBack, super.key});

  @override
  State<DeleteAdmin> createState() => _DeleteAdminState();
}

class _DeleteAdminState extends State<DeleteAdmin> {
  List<UserModel> users = [];
  int? id;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });
  }

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
          body: SingleChildScrollView(
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
                Row(
                  children: const [
                    SizedBox(width: 20),
                    Text(
                      "الأسم\nالأول",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(width: 40),
                    Text(
                      "الأسم\nالأخير",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(width: 70),
                    Text("الايميل",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800)),
                    SizedBox(width: 70),
                    Text("رقم الهاتف",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w800)),
                  ],
                ),
                SizedBox(
                  height: 600,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        UserModel user = users[index];
                        return Column(
                          children: [
                            InkWell(
                              splashColor: Colors.grey,
                              onTap: () {
                                setState(() {
                                  id = int.parse(user.id!);
                                  messageDelete(context);
                                });
                              },
                              child: SizedBox(
                                height: 60,
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        user.firstName!,
                                        textDirection: TextDirection.ltr,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      width: 50,
                                      child: Text(
                                        user.lastName!,
                                        textDirection: TextDirection.ltr,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    SizedBox(
                                      width: 130,
                                      child: Text(
                                        user.email!,
                                        textDirection: TextDirection.ltr,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                    const SizedBox(width: 35),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        user.phoneNumber!,
                                        style: const TextStyle(fontSize: 17),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: Divider(
                                color: Colors.black,
                                thickness: 1,
                              ),
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ),
      ),
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
                    onTap: () async {
                      UserController().delete(id!);

                      Navigator.pop(context);
                      await fetchData();
                      EasyLoading.dismiss();
                      EasyLoading.showSuccess("تم حذف الادمن بنجاح");
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
      List<UserModel> updatedUsers = await UserController().getUserByTypeId2();
      setState(() {
        users = updatedUsers;
      });
    } catch (error) {
      rethrow;
    }
  }
}
