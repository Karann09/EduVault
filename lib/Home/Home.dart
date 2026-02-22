// Main HomePage with appbar and tabBar

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduvault/Components/Routes.dart';
import 'package:eduvault/Home/DefaultHome.dart';
import 'package:eduvault/Home/EditProfile.dart';
import 'package:eduvault/Home/Setting.dart';
import 'package:eduvault/Login/Login.dart';
import 'package:eduvault/Services(Features)/Notes.dart';
import 'package:eduvault/Services(Features)/Quiz.dart';
import 'package:eduvault/Services(Features)/Subject.dart';
import 'package:eduvault/Services(Features)/Textbooks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 2;
  final List<String> titles = [
    "Textbooks",
    "Notes",
    "EduVault", //For HomePage Itself
    "Quiz",
    "Timetable",
  ];

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return const Login();

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        int userClass = 9;
        String name = "User";
        String email = user.email ?? "";
        String firstLetter = "U";

        if (snapshot.hasData && snapshot.data!.exists) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          var rawClass = data['class'] ?? 9;
          userClass = (rawClass is int)
              ? rawClass
              : int.tryParse(rawClass.toString()) ?? 9;
          name = data['name'] ?? "User";
          email = data['email'] ?? email;
          firstLetter = name.isNotEmpty ? name[0].toUpperCase() : "U";
        }

        final List<Widget> pages = [
          Textbooks(selectedClass: userClass),
          Notes(selectedClass: userClass),
          const Defaulthome(),
          const Quiz(),
          const Subject(),
        ];

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                titles[_currentIndex],
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: Colors.blue,
              iconTheme: const IconThemeData(color: Colors.white),
              elevation: 0,
              actions: [
                IconButton(
                  padding: EdgeInsets.only(right: 15),
                  icon: const Icon(Icons.notifications_active_outlined),
                  tooltip: 'Notifications',
                  onPressed: () {},
                ),
              ],
            ),

            drawer: Drawer(
              width: 270,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.white,
                              child: Text(
                                firstLetter,
                                style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              email,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Drawer Menu Items
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.person),
                            title: const Text("Profile"),
                            splashColor: Colors.lightBlueAccent,
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {
                              Navigator.push(context, myRoute(EditProfile()));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.share_outlined),
                            trailing: const Icon(Icons.chevron_right),
                            splashColor: Colors.lightBlueAccent,
                            title: const Text("Share App"),
                            onTap: () {},
                          ),
                          ListTile(
                            leading: const Icon(Icons.feedback_outlined),
                            trailing: const Icon(Icons.chevron_right),
                            splashColor: Colors.lightBlueAccent,
                            title: const Text("Feedback"),
                            onTap: () {},
                          ),
                          const Divider(),
                          ListTile(
                            leading: const Icon(Icons.settings_outlined),
                            trailing: const Icon(Icons.chevron_right),
                            splashColor: Colors.lightBlueAccent,
                            title: const Text("Settings"),
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(context, myRoute(const Setting()));
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.info_outline),
                            trailing: const Icon(Icons.chevron_right),
                            splashColor: Colors.lightBlueAccent,
                            title: const Text("About Us"),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    const Divider(),
                    // Logout Button //
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                            context,
                            myRoute(const Login()),
                            (route) => false,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),

            body: IndexedStack(index: _currentIndex, children: pages),

            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.blueAccent,
              unselectedItemColor: Colors.black,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.book_outlined),
                  label: 'Textbook',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.note_alt_outlined),
                  label: 'Notes',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.quiz_outlined),
                  label: 'Quiz',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today_outlined),
                  label: 'Timetable',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
