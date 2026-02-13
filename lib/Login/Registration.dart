import 'package:eduvault/Components/InputValidator.dart';
import 'package:eduvault/Components/Routes.dart';
import 'package:eduvault/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final TextEditingController name = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  String? selectedClass;
  bool eye = true;

  final List<String> classList = ["9", "10", "11", "12"];
  final _formKey = GlobalKey<FormState>();

  Future<void> createUser() async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: username.text.trim(),
        password: password.text.trim(),
      );

      String uid = userCredential.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name.text.trim(),
        'class': selectedClass,
        'email': username.text.trim(),
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Registration Successful")),
      );

      Navigator.pushReplacement(
        context,
        myRoute(Login()),
      );

    } on FirebaseAuthException catch (e) {
      String message = "Registration Failed";

      if (e.code == 'email-already-in-use') {
        message = "Email already registered";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email format";
      } else if (e.code == 'weak-password') {
        message = "Password too weak";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    name.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xFFF7FAFF),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/Registration.png",
                    height: 150,
                    width: 250,
                  ),

                  const SizedBox(height: 20),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Create Account,",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: name,
                            validator: FormValidators.nameValidator,
                            decoration: const InputDecoration(
                              labelText: "Name",
                              border: OutlineInputBorder(),
                            ),
                          ),

                          const SizedBox(height: 12),

                          DropdownButtonFormField<String>(
                            value: selectedClass,
                            hint: const Text("Select Class"),
                            validator: FormValidators.classValidator,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            items: classList
                                .map(
                                  (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                selectedClass = val;
                              });
                            },
                          ),

                          const SizedBox(height: 12),

                          TextFormField(
                            controller: username,
                            validator: FormValidators.emailValidator,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),

                          const SizedBox(height: 12),

                          TextFormField(
                            controller: password,
                            validator: FormValidators.passwordValidator,
                            obscureText: eye,
                            obscuringCharacter: "*",
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    eye = !eye;
                                  });
                                },
                                icon: Icon(
                                  eye
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                              border: const OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await createUser();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 120,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    style: ButtonStyle(
                      overlayColor: .all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        myRoute(Login()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Already A Member? ",
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          " Login",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
