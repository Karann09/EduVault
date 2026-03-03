import 'package:eduvault/Components/Button.dart';
import 'package:eduvault/Components/Routes.dart';
import 'package:eduvault/Login/ChangePassword.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController num1 = TextEditingController();
  final TextEditingController num2 = TextEditingController();
  final TextEditingController num3 = TextEditingController();
  final TextEditingController num4 = TextEditingController();

  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final f4 = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Forget Password"),
        ),
        body: Container(
          decoration: BoxDecoration(color: Color(0xFFF7FAFF)),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Padding(
                padding: EdgeInsetsGeometry.all(10),
                child: Form(
                  key: _formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OtpField(num: num1, currentFocus: f1, nextFocus: f2),
                      OtpField(
                        num: num2,
                        currentFocus: f2,
                        previousFocus: f1,
                        nextFocus: f3,
                      ),
                      OtpField(
                        num: num3,
                        currentFocus: f3,
                        previousFocus: f2,
                        nextFocus: f4,
                      ),
                      OtpField(num: num4, currentFocus: f4, previousFocus: f3),
                    ],
                  ),
                ),
              ),

              Row(
                children: [
                  Text(
                    '     Resend OTP',
                    style: TextStyle(color: Colors.blueAccent.shade700),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            width: double.infinity,
            height: 90,
            color: Color(0xFFF7FAFF),
            child: Button(
              text: 'Next',
              onTap: () {
                final otp = [];
                otp.add(int.parse(num1.text));
                otp.add(int.parse(num2.text));
                otp.add(int.parse(num3.text));
                otp.add(int.parse(num4.text));

                print(otp);
                if (_formKey.currentState!.validate()) {
                  if (listEquals(otp, [1, 2, 3, 4])) {
                    Navigator.pushReplacement(
                      context,
                      myRoute(ChangePassword()),
                    );
                  } else {
                    print("Invalid Otp");
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class OtpField extends StatelessWidget {
  final TextEditingController num;
  final FocusNode currentFocus;
  final FocusNode? nextFocus;
  final FocusNode? previousFocus;

  const OtpField({
    super.key,
    required this.num,
    required this.currentFocus,
    this.nextFocus,
    this.previousFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      width: 70,
      height: 50,
      child: TextFormField(
        controller: num,
        focusNode: currentFocus,
        decoration: InputDecoration(
          counterText: '',
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          contentPadding: EdgeInsets.all(10),
        ),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, color: Colors.black),
        cursorColor: Colors.black,
        keyboardType: TextInputType.number,
        cursorHeight: 20,
        maxLength: 1,
        onChanged: (value) {
          if (value.isNotEmpty && nextFocus != null) {
            nextFocus!.requestFocus();
          } else if (value.isEmpty && previousFocus != null) {
            previousFocus!.requestFocus();
          }
        },
      ),
    );
  }
}
