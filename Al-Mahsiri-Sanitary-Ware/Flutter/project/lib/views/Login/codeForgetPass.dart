import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordPage extends StatefulWidget {
  final VoidCallback onBack;
  ForgetPasswordPage({required this.onBack, super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordRest() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                content: Text(
                    "تم ارسال رسالة بتفاصيل استعادة كلمة المرور عبر الايميل"));
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.message.toString()));
          });
    }
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
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 30, top: 30, bottom: 30),
                      child: Row(
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              widget.onBack();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              size: 35,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Row(
                        children: const [
                          Text(
                            'استعادة كلمة المرور',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: TextFormField(
                          controller: emailController,
                          maxLength: 30,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(fontSize: 20, height: 2),
                          keyboardType: TextInputType.emailAddress,
                          cursorHeight: 50,
                          cursorWidth: 2,
                          decoration: const InputDecoration(
                            hintText: 'البريد الإلكتروني',
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                            ),
                            errorStyle: TextStyle(
                              fontSize: 15.0,
                            ),
                            counterText: '',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "الرجاء إدخال البريد الإلكتروني";
                            }
                            // }
                            // else if (!EmailValidator.validate(value)) {
                            //   return "الرجاء إدخال البريد الإلكتروني بطريقة صحيحة";
                            // } else if (_isLoggedIn == false && checkemail == 1) {
                            //   return "الايميل موجود مسبقا";
                            // } else if (_isLoggedIn &&
                            //     emailController.text != email2) {
                            //   if (checkemail == 1) {
                            //     return "الايميل موجود مسبقا";
                            //   }
                            // }
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
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              backgroundColor: Colors.blue[700]),
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              passwordRest();
                              // Navigator.pushNamed(context, "/verificationPage");
                            }
                          },
                          child: const Text(
                            'ارسل',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                  ],
                ),
              )),
            ),
          ),
        ));
  }
}
