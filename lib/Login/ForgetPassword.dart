import 'package:eduvault/Components/Button.dart';
import 'package:eduvault/Components/InputValidator.dart';
import 'package:eduvault/Components/Routes.dart';
import 'package:eduvault/Login/OtpPage.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController email = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title:Text("Forget Password"),automaticallyImplyLeading: false),
        body: Container(
          decoration: BoxDecoration(color: Color(0xFFF7FAFF)),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.only(right: 20, left: 20),
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child:
                    TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                          hint: Text("Enter Email"),
                          border:OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email"
                      ),
                      validator: FormValidators.emailValidator,
                    )
                )
              ],
            ),
          ),
        ),

        bottomNavigationBar: SafeArea(
          child: Container(
            height: 90,
            padding: const EdgeInsets.all(20),
            color: Color(0xFFF7FAFF),
            child: Button(
              text: 'Next',
              onTap: () {
                if(_formKey.currentState!.validate()){
                  print('forget password');
                  Navigator.push(context, myRoute(OtpPage()));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
