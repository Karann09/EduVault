// For changing class and account deletion

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduvault/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String selectedClass = "10";

  @override
  void initState() {
    super.initState();
    fetchUserClass();
  }

  void fetchUserClass() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        var doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .get();
        if (doc.exists && doc.data()?['class'] != null) {
          setState(() {
            selectedClass = doc.data()?['class'];
          });
        }
      }
    } catch (e) {
      print("Error fetching class: $e");
    }
  }

  Widget _buildClassItem(String number, String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.blue.withOpacity(0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          if (isSelected) const Icon(Icons.check_circle, color: Colors.blue),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(),
              ),
              child: ListTile(
                title: const Text("Change Class"),
                subtitle: Text(
                  "Current Class : $selectedClass",
                  style: TextStyle(fontSize: 12),
                ),
                leading: const Icon(Icons.school),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25),
                      ),
                    ),
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setModalState) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Icon(
                                  Icons.school_outlined,
                                  size: 50,
                                  color: Colors.blue,
                                ),
                                const Text(
                                  "Select Your Class",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "Choose your standard to continue",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                const SizedBox(height: 20),

                                // Option 9
                                GestureDetector(
                                  onTap: () {
                                    setModalState(() => selectedClass = "9");
                                    setState(() {});
                                  },
                                  child: _buildClassItem(
                                    "9",
                                    "9th class",
                                    selectedClass == "9",
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setModalState(() => selectedClass = "10");
                                    setState(() {});
                                  },
                                  child: _buildClassItem(
                                    "10",
                                    "10th class",
                                    selectedClass == "10",
                                  ),
                                ),

                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );

                                      try {
                                        String? uid = FirebaseAuth
                                            .instance
                                            .currentUser
                                            ?.uid;
                                        if (uid != null) {
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(uid)
                                              .update({
                                                'class':
                                                    selectedClass, // Updates the class field
                                              });
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Class Updated Successfully!!!",
                                              ),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        Navigator.pop(context);
                                        print("Update failed: $e");
                                      }
                                    },
                                    child: const Text("Confirm Selection"),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            GestureDetector(
              onTap: () {
                _showDeleteConfirmation(context);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                ),
                child: const ListTile(
                  title: Text(
                    "Delete Account",
                    style: TextStyle(color: Colors.red),
                  ),
                  leading: Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDeleteConfirmation(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Delete Account?"),
        content: const Text(
          "Are you sure you want to delete your account? This action cannot be undone and all your data will be lost.",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel button
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Dialog band karein
              await _deleteUserAccount(context); // Delete function call
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}

Future<void> _deleteUserAccount(BuildContext context) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    String uid = user.uid;
    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .delete()
        .then((_) {
          user
              .delete()
              .then((_) {
                print("User deleted from DB and Auth in background");
              })
              .catchError((e) {
                print("Auth delete error: $e");
              });
        })
        .catchError((e) {
          print("Firestore delete error: $e");
        });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account Deleted Successfully!!!")),
    );
  }
}
