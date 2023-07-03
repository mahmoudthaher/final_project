import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({super.key});

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  TextEditingController textFieldController1 = TextEditingController();
  TextEditingController textFieldController2 = TextEditingController();
  TextEditingController textFieldController3 = TextEditingController();
  TextEditingController textFieldController4 = TextEditingController();
  FocusNode textField2FocusNode = FocusNode();
  FocusNode textField3FocusNode = FocusNode();
  FocusNode textField1FocusNode = FocusNode();
  bool isButtonDisabled = true;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textFieldController1.addListener(_checkInput);
    textFieldController2.addListener(_checkInput);
    textFieldController3.addListener(_checkInput);
    textFieldController4.addListener(_checkInput);
  }

  void _checkInput() {
    setState(() {
      isButtonDisabled = textFieldController1.text.isEmpty ||
          textFieldController2.text.isEmpty ||
          textFieldController3.text.isEmpty ||
          textFieldController4.text.isEmpty;
    });
    if (textFieldController4.text.length == 1) {
      FocusScope.of(context).requestFocus(textField3FocusNode);
    } else if (textFieldController3.text.length == 1) {
      FocusScope.of(context).requestFocus(textField2FocusNode);
    } else if (textFieldController2.text.length == 1) {
      FocusScope.of(context).requestFocus(textField1FocusNode);
    }
  }

  @override
  void dispose() {
    textFieldController1.dispose();
    textFieldController2.dispose();
    textFieldController3.dispose();
    textFieldController4.dispose();
    textField2FocusNode.dispose();
    textField3FocusNode.dispose();
    textField1FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, "/forgetPassword");
                      },
                      child: const Padding(
                        padding: const EdgeInsets.all(20),
                        child: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Verification',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 25),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    children: [
                      const Text(
                        '    Kami telah mengirimkan kode verifikasi ke\n    +628*******716 Ganti?',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(25.0),
                      child: Text(
                        'Verification Code',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      width: 130,
                    ),
                    Text(
                      'Re-send Code',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF3669C9),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 74,
                      child: TextFormField(
                        controller: textFieldController1,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        enabled: textFieldController2.text.isNotEmpty,
                        //autofocus: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          counterText: '',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 74,
                      child: TextFormField(
                        controller: textFieldController2,
                        enabled: textFieldController3.text.isNotEmpty,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          counterText: '',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 74,
                      child: TextFormField(
                        controller: textFieldController3,
                        enabled: textFieldController4.text.isNotEmpty,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          counterText: '',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 74,
                      child: TextFormField(
                        controller: textFieldController4,
                        focusNode: textField1FocusNode,
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          counterText: '',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Row(
                    children: const [
                      Text(
                        'Kirim kode ulang dalam',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color(0xFF838589)),
                      ),
                      SizedBox(
                        width: 150,
                      ),
                      Text(
                        '03:05',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: Color(0xFF838589)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Color(0xFF3669C9)),
                      onPressed: isButtonDisabled
                          ? null
                          : () {
                              Navigator.pushNamed(context, "/fordotPassword");
                            },
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
