import 'package:eduvault/Components/Button.dart';
import 'package:eduvault/Components/InputValidator.dart';
import 'package:eduvault/Components/Routes.dart';
import 'package:eduvault/Login/Login.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  bool eye = true;
  final TextEditingController newPassword1 = TextEditingController();
  final TextEditingController newPassword2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Change Password'),
        ),
        body: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(color: Color(0xFFF7FAFF)),
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30,right: 5,left: 5),
                  child: Column(
                    spacing: 12,
                    children: [
                      TextFormField(
                        controller: newPassword1,
                        validator: FormValidators.passwordValidator,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                eye = !eye;
                              });
                            },
                            icon: Icon(
                              eye ? Icons.visibility_off : Icons.remove_red_eye,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        obscureText: eye,
                        obscuringCharacter: "*",
                      ),

                      TextFormField(
                        controller: newPassword2,
                        validator: (value) =>
                            FormValidators.confirmPasswordValidator(
                              value,
                              newPassword1,
                            ),
                        decoration: InputDecoration(
                          labelText: "Cofirm Password",
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                eye = !eye;
                              });
                            },
                            icon: Icon(
                              eye ? Icons.visibility_off : Icons.remove_red_eye,
                            ),
                          ),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.name,
                        obscureText: eye,
                        obscuringCharacter: "*",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 90,
            padding: EdgeInsets.all(20),
            color: Color(0xFFF7FAFF),
            child: Button(
              text: 'Change Password',
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade50,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            spacing: 20,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Password Changed Successfully ✔️",
                                style: TextStyle(fontSize: 20),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    myRoute(Login()),
                                        (Route) => false,
                                  );
                                },
                                child: Text("Done"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 150,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  elevation: 5, // Shadow
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  print("Error");
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

