import 'package:flutter/material.dart';
import 'package:project/views/Admin/delete_admin.dart';
import 'package:project/views/Admin/delete_subadmin.dart';

class DeleteUsers extends StatefulWidget {
  final VoidCallback onBack;

  const DeleteUsers({required this.onBack, super.key});

  @override
  State<DeleteUsers> createState() => _DeleteUsersState();
}

class _DeleteUsersState extends State<DeleteUsers> {
  Widget currentPage = DeleteUsers(
    onBack: () {},
  );
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
          body: currentPage is DeleteUsers
              ? SingleChildScrollView(
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
                      const SizedBox(
                        height: 130,
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
                                currentPage = DeleteAdmin(
                                  onBack: () {
                                    setState(() {
                                      currentPage = DeleteUsers(
                                        onBack: () {},
                                      );
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
                                  'ادمن فرعي',
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
                                currentPage = DeleteSubAdmin(
                                  onBack: () {
                                    setState(() {
                                      currentPage = DeleteUsers(
                                        onBack: () {},
                                      );
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
                                  'عميل',
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
                )
              : currentPage,
        ),
      ),
    );
  }
}
