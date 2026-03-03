// // Default Home Screen where user will be redirected
//
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:eduvault/Components/Routes.dart';
// import 'package:eduvault/Home/Setting.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
//
// class Defaulthome extends StatefulWidget {
//   const Defaulthome({super.key});
//
//   @override
//   State<Defaulthome> createState() => _DefaulthomeState();
// }
//
// class _DefaulthomeState extends State<Defaulthome> {
//   @override
//   void initState() {
//     super.initState();
//     // Start the timer when the page loads
//     Timer.periodic(const Duration(seconds: 3), (Timer timer) {
//       if (_controller.hasClients) {
//         int nextPage = _controller.page!.toInt() + 1;
//         if (nextPage >= images.length) {
//           nextPage = 0;
//         }
//         _controller.animateToPage(
//           nextPage,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   int _currentPage = 0;
//   final PageController _controller = PageController();
//   List<String> images = [
//     'assets/images/SliderImage1.jpg',
//     'assets/images/SliderImage1.jpg',
//     'assets/images/SliderImage1.jpg',
//   ];
//
//   String name = "Guest";
//   String email = "No Email";
//   String firstLetter = "U";
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         drawer: Drawer(
//           width: 260,
//           backgroundColor: Color(0xFFF7FAFF),
//           child: Column(
//             children: [
//               // StreamBuilder listens to Firestore changes
//               StreamBuilder<DocumentSnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(FirebaseAuth.instance.currentUser?.uid)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   // 1. Handle Loading State
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return DrawerHeader(
//                       decoration: BoxDecoration(color: Colors.blue.shade100),
//                       child: const Center(child: CircularProgressIndicator()),
//                     );
//                   }
//
//                   // 2. Extract Data (provide defaults if data is missing)
//                   if (snapshot.hasData && snapshot.data!.exists) {
//                     var data = snapshot.data!.data() as Map<String, dynamic>;
//                     name = data['name'] ?? "User";
//                     email =
//                         data['email'] ??
//                             FirebaseAuth.instance.currentUser?.email ??
//                             "";
//                     firstLetter = name.isNotEmpty ? name[0].toUpperCase() : "U";
//                   }
//
//                   return DrawerHeader(
//                     decoration: BoxDecoration(color: Colors.blue.shade100),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CircleAvatar(
//                             radius: 35,
//                             backgroundColor: Colors.blueAccent,
//                             child: Text(
//                               firstLetter,
//                               style: const TextStyle(
//                                 fontSize: 24,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             name,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           Text(
//                             email,
//                             style: TextStyle(
//                               color: Colors.grey.shade700,
//                               fontSize: 12,
//                             ),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     ListTile(
//                       leading: const Icon(Icons.person_outline),
//                       trailing: Icon(Icons.chevron_right),
//                       title: const Text("Profile"),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.share),
//                       trailing: Icon(Icons.chevron_right),
//                       title: const Text("Share"),
//                       onTap: () {},
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.settings),
//                       trailing: Icon(Icons.chevron_right),
//                       title: const Text("Setting"),
//                       onTap: () {
//                         Navigator.push(context, myRoute(Setting()));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//
//               // 3. Logout Section (at the bottom)
//               Divider(color: Colors.black),
//               ListTile(
//                 leading: Icon(Icons.logout, color: Colors.red),
//                 title: Text("Logout", style: TextStyle(color: Colors.red)),
//                 onTap: () {},
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//
//         backgroundColor: Color(0xFFF7FAFF),
//         body: SingleChildScrollView(
//           child: Container(
//             padding: EdgeInsets.only(left: 20, right: 20, top: 10),
//             child: Column(
//               spacing: 8,
//               children: [
//                 Column(
//                   children: [
//                     SizedBox(
//                       height: 160, // Height of slider
//                       child: PageView.builder(
//                         onPageChanged: (index) {
//                           setState(() {
//                             _currentPage = index;
//                           });
//                         },
//                         controller: _controller,
//                         itemCount: images.length,
//                         itemBuilder: (context, index) {
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 8.0,
//                             ),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(12),
//                               child: Image.asset(
//                                 images[index],
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Center(
//                       child: SmoothPageIndicator(
//                         controller: _controller,
//                         count: images.length,
//                         effect: ExpandingDotsEffect(
//                           dotHeight: 8,
//                           dotWidth: 8,
//                           activeDotColor: Colors.blue.shade300,
//                           dotColor: Colors.grey.shade400,
//                         ),
//                       ),
//                     ),
//
//
//                     Row(children: [
//                       const _FloatingIcon(icon: Icons.flash_on, color: Color(0xFF4F7EFF), size: 20, delay: Duration(milliseconds: 200)),
//                       const SizedBox(width: 6),
//                       const Text("Quick Access", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1F3C))),
//                     ]),
//                     const SizedBox(height: 12),
//
//                     GridView.count(
//                       crossAxisCount: 4,
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       crossAxisSpacing: 10,
//                       mainAxisSpacing: 10,
//                       childAspectRatio: 0.82,
//                       children: [
//                         _quickIconCard(icon: Icons.play_circle_fill, label: "Videos",      color: const Color(0xFF4F7EFF), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoListPage()))),
//                         _quickIconCard(icon: Icons.book_outlined,       label: "Textbooks", color: const Color(0xFFFF9F43), onTap: () {}),
//                         _quickIconCard(icon: Icons.note_alt_outlined,   label: "Notes",     color: const Color(0xFF4ADE80), onTap: () {}),
//                         _quickIconCard(icon: Icons.quiz_outlined,        label: "Quiz",      color: const Color(0xFFA855F7), onTap: () {}),
//                         _quickIconCard(icon: Icons.calendar_today,       label: "Timetable", color: const Color(0xFF06B6D4), onTap: () {}),
//                         _quickIconCard(icon: Icons.leaderboard,          label: "Leaders",   color: const Color(0xFFFF6B6B), onTap: () {}),
//                         _quickIconCard(icon: Icons.assignment_outlined,  label: "Tasks",     color: const Color(0xFF10B981), onTap: () {}),
//                         _quickIconCard(icon: Icons.timer_outlined,       label: "Pomodoro",  color: const Color(0xFFF43F5E), onTap: () {}),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// Widget _quickIconCard({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
//   return GestureDetector(
//     onTap: onTap,
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 8, spreadRadius: 1)],
//       ),
//       child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle), child: Icon(icon, color: color, size: 22)),
//         const SizedBox(height: 6),
//         Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
//       ]),
//     ),
//   );
// }
//
// class _FloatingIconState extends State<_FloatingIcon> with SingleTickerProviderStateMixin {
//   late AnimationController _ctrl;
//   late Animation<double> _anim;
//   @override
//   void initState() {
//     super.initState();
//     _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));
//     _anim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
//     Future.delayed(widget.delay, () { if (mounted) _ctrl.repeat(reverse: true); });
//   }
//   @override
//   void dispose() { _ctrl.dispose(); super.dispose(); }
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _anim,
//       builder: (_, __) => Transform.translate(
//         offset: Offset(0, -6 * _anim.value),
//         child: Icon(widget.icon, color: widget.color, size: widget.size),
//       ),
//     );
//   }
// }
