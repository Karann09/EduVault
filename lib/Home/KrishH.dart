// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class T {
//   T._();
//   static const pageBg   = Color(0xFFF4F7FF);
//   static const white    = Color(0xFFFFFFFF);
//   static const blue     = Color(0xFF3D6EFF);
//   static const blueDark = Color(0xFF254FDB);
//   static const blueSoft = Color(0xFFEBF0FF);
//   static const ink      = Color(0xFF0D1B40);
//   static const inkMid   = Color(0xFF7886A0);
//   static const inkLight = Color(0xFFCDD5E4);
//   static const line     = Color(0xFFECF0FB);
//   static const green    = Color(0xFF1DB97B);
//   static const red      = Color(0xFFEF4444);
//
//   static const r10 = 10.0;
//   static const r14 = 14.0;
//   static const r18 = 18.0;
//   static const r20 = 20.0;
//   static const r22 = 22.0;
//   static const r28 = 28.0;
//
//   static BoxDecoration card({double r = r20}) => BoxDecoration(
//     color: white,
//     borderRadius: BorderRadius.circular(r),
//     border: Border.all(color: line, width: 1),
//     boxShadow: [
//       BoxShadow(color: blue.withOpacity(0.07), blurRadius: 18, offset: const Offset(0, 5)),
//     ],
//   );
// }
//
// TextStyle ts(double sz, FontWeight w, [Color c = T.ink]) =>
//     TextStyle(color: c, fontSize: sz, fontWeight: w, letterSpacing: -0.2);
//
// class ChapterVideo {
//   final String chapterTitle;
//   final String videoTitle;
//   final String youtubeUrl;
//   const ChapterVideo({
//     required this.chapterTitle,
//     required this.videoTitle,
//     required this.youtubeUrl,
//   });
// }
//
// class Subject {
//   final String name;
//   final IconData icon;
//   final Color color;
//   final List<ChapterVideo> chapters;
//   const Subject({
//     required this.name,
//     required this.icon,
//     required this.color,
//     required this.chapters,
//   });
// }
//
// // update these URLs with real video links
// const List<Subject> kSubjects = [
//   Subject(
//     name: 'Science',
//     icon: Icons.science_outlined,
//     color: Color(0xFF3D6EFF),
//     chapters: [
//       ChapterVideo(chapterTitle: 'Chapter 1 – Matter',            videoTitle: 'Introduction to Matter',         youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
//       ChapterVideo(chapterTitle: 'Chapter 2 – Force & Motion',    videoTitle: 'Force and Laws of Motion',       youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
//       ChapterVideo(chapterTitle: 'Chapter 3 – Atoms & Molecules', videoTitle: 'Atoms and Molecules',            youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
//       ChapterVideo(chapterTitle: 'Chapter 4 – Cell Structure',    videoTitle: 'The Fundamental Unit of Life',   youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI'),
//     ],
//   ),
//   Subject(
//     name: 'Maths',
//     icon: Icons.calculate_outlined,
//     color: Color(0xFF0AAFC9),
//     chapters: [
//       ChapterVideo(chapterTitle: 'Chapter 1 – Number Systems',       videoTitle: 'Number System Basics',             youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
//       ChapterVideo(chapterTitle: 'Chapter 2 – Polynomials',          videoTitle: 'Introduction to Polynomials',      youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
//       ChapterVideo(chapterTitle: 'Chapter 3 – Coordinate Geometry',  videoTitle: 'Coordinate Geometry',              youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
//       ChapterVideo(chapterTitle: 'Chapter 4 – Linear Equations',     videoTitle: 'Linear Equations in 2 Variables',  youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI'),
//     ],
//   ),
//   Subject(
//     name: 'English',
//     icon: Icons.menu_book_outlined,
//     color: Color(0xFF7C5CDB),
//     chapters: [
//       ChapterVideo(chapterTitle: 'Chapter 1 – The Fun They Had',   videoTitle: 'The Fun They Had – Explanation',  youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
//       ChapterVideo(chapterTitle: 'Chapter 2 – The Sound of Music', videoTitle: 'The Sound of Music',              youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
//       ChapterVideo(chapterTitle: 'Chapter 3 – The Little Girl',    videoTitle: 'The Little Girl – Analysis',      youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
//     ],
//   ),
//   Subject(
//     name: 'Hindi',
//     icon: Icons.translate,
//     color: Color(0xFF0FB97A),
//     chapters: [
//       ChapterVideo(chapterTitle: 'Chapter 1 – Do Bailon ki Katha',      videoTitle: 'Do Bailon ki Katha',       youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
//       ChapterVideo(chapterTitle: 'Chapter 2 – Lhasa ki Aur',            videoTitle: 'Lhasa ki Aur',             youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
//       ChapterVideo(chapterTitle: 'Chapter 3 – Upbhog wadi Sanskriti',   videoTitle: 'Upbhog wadi Sanskriti',    youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
//     ],
//   ),
//   Subject(
//     name: 'Marathi',
//     icon: Icons.language_outlined,
//     color: Color(0xFFF5A623),
//     chapters: [
//       ChapterVideo(chapterTitle: 'Chapter 1 – Vaara',           videoTitle: 'Vaara – Explanation',       youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
//       ChapterVideo(chapterTitle: 'Chapter 2 – Maza Abhyas',     videoTitle: 'Maza Abhyas',               youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
//       ChapterVideo(chapterTitle: 'Chapter 3 – Shivaji Maharaj', videoTitle: 'Shivaji Maharaj – Chapter', youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
//     ],
//   ),
//   Subject(
//     name: 'Social Science',
//     icon: Icons.public_outlined,
//     color: Color(0xFFEF4444),
//     chapters: [
//       ChapterVideo(chapterTitle: 'Chapter 1 – French Revolution',    videoTitle: 'French Revolution',             youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
//       ChapterVideo(chapterTitle: 'Chapter 2 – Socialism in Europe',  videoTitle: 'Socialism in Europe',           youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
//       ChapterVideo(chapterTitle: 'Chapter 3 – Nazism',               videoTitle: 'Nazism and the Rise of Hitler', youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
//       ChapterVideo(chapterTitle: 'Chapter 4 – Forest Society',       videoTitle: 'Forest Society and Colonialism',youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI'),
//     ],
//   ),
// ];
//
// AppBar _appBar(String title, [List<Widget>? actions]) => AppBar(
//   title: Text(title, style: ts(17, FontWeight.w600)),
//   backgroundColor: T.white,
//   foregroundColor: T.ink,
//   elevation: 0,
//   systemOverlayStyle: SystemUiOverlayStyle.dark,
//   bottom: PreferredSize(
//     preferredSize: const Size.fromHeight(1),
//     child: Container(color: T.line, height: 1),
//   ),
//   actions: actions,
// );
//
// Route _slideRoute(Widget page) => PageRouteBuilder(
//   pageBuilder: (_, __, ___) => page,
//   transitionsBuilder: (_, a, __, child) => SlideTransition(
//     position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
//         .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
//     child: child,
//   ),
//   transitionDuration: const Duration(milliseconds: 300),
// );
//
// // pages
// class VideoPlayerPage extends StatefulWidget {
//   final String title;
//   final String youtubeUrl;
//   const VideoPlayerPage({super.key, required this.title, required this.youtubeUrl});
//
//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }
//
// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late YoutubePlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     final id = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';
//     _controller = YoutubePlayerController(
//       initialVideoId: id,
//       flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//     );
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//       player: YoutubePlayer(
//         controller: _controller,
//         showVideoProgressIndicator: true,
//         progressIndicatorColor: T.blue,
//         progressColors: const ProgressBarColors(
//           playedColor: T.blue,
//           handleColor: T.blueDark,
//         ),
//         onReady: () => _controller.play(),
//       ),
//       builder: (context, player) {
//         return Scaffold(
//           backgroundColor: T.pageBg,
//           appBar: _appBar(widget.title),
//           body: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               player,
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(18),
//                   decoration: T.card(),
//                   child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     Text(widget.title, style: ts(16, FontWeight.w600)),
//                     const SizedBox(height: 6),
//                     Text('Tap the video to play or pause.',
//                         style: ts(12, FontWeight.w400, T.inkMid)),
//                   ]),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class ChapterListPage extends StatelessWidget {
//   final Subject subject;
//   const ChapterListPage({super.key, required this.subject});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: T.pageBg,
//       appBar: _appBar(subject.name),
//       body: ListView.builder(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//         itemCount: subject.chapters.length,
//         itemBuilder: (_, i) {
//           final ch = subject.chapters[i];
//           return GestureDetector(
//             onTap: () => Navigator.push(context,
//                 _slideRoute(VideoPlayerPage(
//                   title: ch.videoTitle,
//                   youtubeUrl: ch.youtubeUrl,
//                 ))),
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(16),
//               decoration: T.card(),
//               child: Row(children: [
//                 Container(
//                   width: 44, height: 44,
//                   decoration: BoxDecoration(
//                     color: subject.color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(T.r14),
//                   ),
//                   child: Center(
//                     child: Text('${i + 1}',
//                         style: ts(16, FontWeight.w700, subject.color)),
//                   ),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text(ch.chapterTitle, style: ts(14, FontWeight.w600)),
//                   const SizedBox(height: 3),
//                   Text(ch.videoTitle, style: ts(12, FontWeight.w400, T.inkMid)),
//                 ])),
//                 Container(
//                   width: 32, height: 32,
//                   decoration: BoxDecoration(
//                     color: subject.color.withOpacity(0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.play_arrow_rounded, color: subject.color, size: 18),
//                 ),
//               ]),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class SubjectListPage extends StatelessWidget {
//   const SubjectListPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: T.pageBg,
//       appBar: _appBar('Select Subject'),
//       body: ListView.builder(
//         padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//         itemCount: kSubjects.length,
//         itemBuilder: (_, i) {
//           final sub = kSubjects[i];
//           return GestureDetector(
//             onTap: () => Navigator.push(context,
//                 _slideRoute(ChapterListPage(subject: sub))),
//             child: Container(
//               margin: const EdgeInsets.only(bottom: 12),
//               padding: const EdgeInsets.all(16),
//               decoration: T.card(),
//               child: Row(children: [
//                 Container(
//                   width: 48, height: 48,
//                   decoration: BoxDecoration(
//                     color: sub.color.withOpacity(0.1),
//                     borderRadius: BorderRadius.circular(T.r14),
//                   ),
//                   child: Icon(sub.icon, color: sub.color, size: 24),
//                 ),
//                 const SizedBox(width: 14),
//                 Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text(sub.name, style: ts(15, FontWeight.w600)),
//                   const SizedBox(height: 2),
//                   Text('${sub.chapters.length} chapters',
//                       style: ts(12, FontWeight.w400, T.inkMid)),
//                 ])),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   decoration: BoxDecoration(
//                     color: sub.color.withOpacity(0.08),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Row(mainAxisSize: MainAxisSize.min, children: [
//                     Icon(Icons.play_circle_outline_rounded, color: sub.color, size: 14),
//                     const SizedBox(width: 4),
//                     Text('Watch', style: ts(11, FontWeight.w600, sub.color)),
//                   ]),
//                 ),
//               ]),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class _Float extends StatefulWidget {
//   final Widget child;
//   final double amplitude;
//   const _Float({required this.child, this.amplitude = 5});
//   @override
//   State<_Float> createState() => _FloatState();
// }
//
// class _FloatState extends State<_Float> with SingleTickerProviderStateMixin {
//   late final AnimationController _c;
//   @override
//   void initState() {
//     super.initState();
//     _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 2800));
//     _c.repeat(reverse: true);
//   }
//   @override
//   void dispose() { _c.dispose(); super.dispose(); }
//   @override
//   Widget build(BuildContext context) => AnimatedBuilder(
//     animation: _c,
//     builder: (_, child) => Transform.translate(
//       offset: Offset(0, -widget.amplitude *
//           CurvedAnimation(parent: _c, curve: Curves.easeInOut).value),
//       child: child,
//     ),
//     child: widget.child,
//   );
// }
//
// class _HeroCard extends StatelessWidget {
//   final String name, firstLetter;
//   const _HeroCard({required this.name, required this.firstLetter});
//
//   String get _greet {
//     final h = DateTime.now().hour;
//     if (h < 12) return 'Good morning ☀️';
//     if (h < 17) return 'Good afternoon 🌤️';
//     return 'Good evening 🌙';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(24),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFF3D6EFF), Color(0xFF254FDB)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(T.r28),
//         boxShadow: [
//           BoxShadow(color: T.blue.withOpacity(0.30), blurRadius: 28, offset: const Offset(0, 10)),
//         ],
//       ),
//       child: Stack(children: [
//         Positioned(top: -20, right: -20,
//             child: Container(width: 100, height: 100,
//                 decoration: BoxDecoration(shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.05)))),
//         Positioned(bottom: -28, right: 50,
//             child: Container(width: 70, height: 70,
//                 decoration: BoxDecoration(shape: BoxShape.circle,
//                     color: Colors.white.withOpacity(0.04)))),
//         Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Row(children: [
//             Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(_greet, style: ts(13, FontWeight.w400, Colors.white.withOpacity(0.75))),
//               const SizedBox(height: 4),
//               Text(name, style: ts(26, FontWeight.w700, Colors.white)),
//             ])),
//             _Float(child: Container(
//               width: 52, height: 52,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.15),
//                 border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
//               ),
//               child: Center(child: Text(firstLetter, style: ts(22, FontWeight.w700, Colors.white))),
//             )),
//           ]),
//           const SizedBox(height: 20),
//           Container(height: 1, color: Colors.white.withOpacity(0.15)),
//           const SizedBox(height: 16),
//           Row(children: [
//             _pill('📚', 'Keep learning'),
//             const SizedBox(width: 10),
//             _pill('🎯', 'Stay focused'),
//           ]),
//         ]),
//       ]),
//     );
//   }
//
//   Widget _pill(String emoji, String label) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//     decoration: BoxDecoration(
//       color: Colors.white.withOpacity(0.14),
//       borderRadius: BorderRadius.circular(30),
//       border: Border.all(color: Colors.white.withOpacity(0.2)),
//     ),
//     child: Row(mainAxisSize: MainAxisSize.min, children: [
//       Text(emoji, style: const TextStyle(fontSize: 13)),
//       const SizedBox(width: 6),
//       Text(label, style: ts(12, FontWeight.w500, Colors.white)),
//     ]),
//   );
// }
//
// class _QuoteCard extends StatefulWidget {
//   const _QuoteCard();
//   @override
//   State<_QuoteCard> createState() => _QCSt();
// }
//
// class _QCSt extends State<_QuoteCard> with TickerProviderStateMixin {
//   int _i = 0;
//   late final AnimationController _fade, _float;
//
//   static const _q = [
//     ['Education is the most powerful weapon\nto change the world.',           'Nelson Mandela'],
//     ['The beautiful thing about learning is\nnobody can take it from you.',   'B.B. King'],
//     ['An investment in knowledge\npays the best interest.',                    'Benjamin Franklin'],
//     ['Success comes from hard work,\nperseverance and learning.',              'Pelé'],
//     ["Don't watch the clock —\ndo what it does. Keep going.",                  'Sam Levenson'],
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _fade  = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
//     _float = AnimationController(vsync: this, duration: const Duration(milliseconds: 3200));
//     _fade.forward();
//     _float.repeat(reverse: true);
//     Timer.periodic(const Duration(seconds: 9), (_) {
//       if (!mounted) return;
//       _fade.reverse().then((_) {
//         if (!mounted) return;
//         setState(() => _i = (_i + 1) % _q.length);
//         _fade.forward();
//       });
//     });
//   }
//
//   @override
//   void dispose() { _fade.dispose(); _float.dispose(); super.dispose(); }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _float,
//       builder: (_, child) => Transform.translate(
//         offset: Offset(0, -4 * CurvedAnimation(parent: _float, curve: Curves.easeInOut).value),
//         child: child,
//       ),
//       child: FadeTransition(
//         opacity: CurvedAnimation(parent: _fade, curve: Curves.easeIn),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [T.blue.withOpacity(0.92), T.blueDark],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             borderRadius: BorderRadius.circular(T.r22),
//             boxShadow: [
//               BoxShadow(color: T.blue.withOpacity(0.28), blurRadius: 24, offset: const Offset(0, 8)),
//             ],
//           ),
//           child: Column(children: [
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text('"', style: TextStyle(
//                 color: Colors.white.withOpacity(0.25),
//                 fontSize: 72,
//                 height: 0.7,
//                 fontWeight: FontWeight.w700,
//               )),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               _q[_i][0],
//               textAlign: TextAlign.center,
//               style: ts(18, FontWeight.w600, Colors.white).copyWith(height: 1.55),
//             ),
//             const SizedBox(height: 16),
//             Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Container(width: 24, height: 1.5, color: Colors.white38),
//               const SizedBox(width: 10),
//               Text('— ${_q[_i][1]}', style: ts(12, FontWeight.w500, Colors.white70)),
//               const SizedBox(width: 10),
//               Container(width: 24, height: 1.5, color: Colors.white38),
//             ]),
//             const SizedBox(height: 18),
//             Row(mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(_q.length, (j) => AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   margin: const EdgeInsets.symmetric(horizontal: 3),
//                   width: j == _i ? 18 : 5, height: 5,
//                   decoration: BoxDecoration(
//                     color: j == _i ? Colors.white : Colors.white30,
//                     borderRadius: BorderRadius.circular(3),
//                   ),
//                 ))),
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// class _QuickGrid extends StatelessWidget {
//   final VoidCallback onVideosTap;
//   const _QuickGrid({required this.onVideosTap});
//
//   static const _items = <List>[
//     [Icons.play_circle_outline_rounded, 'Videos',      Color(0xFF3D6EFF)],
//     [Icons.book_outlined,               'Textbooks',   Color(0xFF7C5CDB)],
//     [Icons.note_alt_outlined,           'Notes',       Color(0xFF0FB97A)],
//     [Icons.quiz_outlined,               'Quiz',        Color(0xFFF5A623)],
//     [Icons.calendar_today_outlined,     'Timetable',   Color(0xFF0AAFC9)],
//     [Icons.timer_outlined,              'Pomodoro',    Color(0xFFEF4444)],
//     [Icons.assignment_outlined,         'Assignments', Color(0xFF3D6EFF)],
//     [Icons.bar_chart_rounded,           'Progress',    Color(0xFF0FB97A)],
//   ];
//
//   @override
//   Widget build(BuildContext context) => GridView.builder(
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     itemCount: _items.length,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 4, mainAxisSpacing: 10,
//       crossAxisSpacing: 10, childAspectRatio: 0.9,
//     ),
//     itemBuilder: (_, i) {
//       final icon  = _items[i][0] as IconData;
//       final label = _items[i][1] as String;
//       final color = _items[i][2] as Color;
//       return GestureDetector(
//         onTap: label == 'Videos' ? onVideosTap : () {},
//         child: Container(
//           decoration: T.card(r: T.r18),
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Container(
//               width: 42, height: 42,
//               decoration: BoxDecoration(
//                 color: color.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(T.r14),
//               ),
//               child: Icon(icon, color: color, size: 21),
//             ),
//             const SizedBox(height: 7),
//             Text(label, textAlign: TextAlign.center, style: ts(10, FontWeight.w600)),
//           ]),
//         ),
//       );
//     },
//   );
// }
//
// // tasks
// class TaskItem {
//   String title;
//   bool done;
//   TaskItem(this.title, {this.done = false});
// }
//
// class _TasksCard extends StatefulWidget {
//   const _TasksCard();
//   @override
//   State<_TasksCard> createState() => _TCSt();
// }
//
// class _TCSt extends State<_TasksCard> {
//   final List<TaskItem> _tasks = [
//     TaskItem('Complete Maths Chapter 5', done: true),
//     TaskItem('Revise Science Notes'),
//     TaskItem('Practice Hindi Grammar'),
//     TaskItem('Solve 10 Quiz Questions'),
//   ];
//
//   void _openAddSheet() {
//     final ctrl = TextEditingController();
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Container(
//           margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
//           padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
//           decoration: BoxDecoration(
//             color: T.white,
//             borderRadius: BorderRadius.circular(T.r22),
//             border: Border.all(color: T.line),
//           ),
//           child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Center(child: Container(width: 36, height: 4,
//                 decoration: BoxDecoration(color: T.inkLight,
//                     borderRadius: BorderRadius.circular(2)))),
//             const SizedBox(height: 18),
//             Text('Add New Task', style: ts(17, FontWeight.w700)),
//             const SizedBox(height: 14),
//             Container(
//               decoration: BoxDecoration(
//                 color: T.pageBg,
//                 borderRadius: BorderRadius.circular(T.r14),
//                 border: Border.all(color: T.line),
//               ),
//               child: TextField(
//                 controller: ctrl,
//                 autofocus: true,
//                 style: ts(14, FontWeight.w500),
//                 decoration: InputDecoration(
//                   hintText: 'e.g. Read History Chapter 3',
//                   hintStyle: ts(14, FontWeight.w400, T.inkMid),
//                   contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//                   border: InputBorder.none,
//                 ),
//                 onSubmitted: (v) {
//                   _addTask(ctrl.text);
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             const SizedBox(height: 16),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () { _addTask(ctrl.text); Navigator.pop(context); },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: T.blue,
//                   foregroundColor: Colors.white,
//                   elevation: 0,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(T.r14)),
//                 ),
//                 child: Text('Add Task', style: ts(14, FontWeight.w600, Colors.white)),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
//
//   void _addTask(String text) {
//     final t = text.trim();
//     if (t.isEmpty) return;
//     setState(() => _tasks.add(TaskItem(t)));
//   }
//
//   void _removeTask(int index) {
//     setState(() => _tasks.removeAt(index));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final done  = _tasks.where((t) => t.done).length;
//     final total = _tasks.length;
//     final pct   = total == 0 ? 0.0 : done / total;
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: T.card(r: T.r22),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//
//         Row(children: [
//           Container(width: 36, height: 36,
//               decoration: BoxDecoration(color: T.blueSoft, borderRadius: BorderRadius.circular(T.r10)),
//               child: const Icon(Icons.checklist_rounded, color: T.blue, size: 20)),
//           const SizedBox(width: 12),
//           Expanded(child: Text("Today's Tasks", style: ts(15, FontWeight.w700))),
//           if (total > 0)
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               decoration: BoxDecoration(
//                 color: done == total ? T.green.withOpacity(0.1) : T.blueSoft,
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: Text('$done / $total',
//                   style: ts(12, FontWeight.w700, done == total ? T.green : T.blue)),
//             ),
//           const SizedBox(width: 8),
//           GestureDetector(
//             onTap: _openAddSheet,
//             child: Container(
//               width: 32, height: 32,
//               decoration: BoxDecoration(color: T.blue, borderRadius: BorderRadius.circular(T.r10)),
//               child: const Icon(Icons.add, color: Colors.white, size: 18),
//             ),
//           ),
//         ]),
//
//         if (total > 0) ...[
//           const SizedBox(height: 14),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: Stack(children: [
//               Container(height: 5, color: T.line),
//               FractionallySizedBox(
//                 widthFactor: pct,
//                 child: Container(
//                   height: 5,
//                   decoration: BoxDecoration(
//                     color: done == total ? T.green : T.blue,
//                     borderRadius: BorderRadius.circular(4),
//                     boxShadow: [BoxShadow(
//                       color: (done == total ? T.green : T.blue).withOpacity(0.3),
//                       blurRadius: 5,
//                     )],
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           const SizedBox(height: 16),
//
//           ..._tasks.asMap().entries.map((e) {
//             final idx = e.key;
//             final t   = e.value;
//             return Padding(
//               padding: EdgeInsets.only(bottom: idx < _tasks.length - 1 ? 12 : 0),
//               child: Row(children: [
//                 GestureDetector(
//                   onTap: () => setState(() => t.done = !t.done),
//                   child: AnimatedContainer(
//                     duration: const Duration(milliseconds: 200),
//                     width: 22, height: 22,
//                     decoration: BoxDecoration(
//                       color: t.done ? T.blue : Colors.transparent,
//                       border: Border.all(
//                           color: t.done ? T.blue : T.inkLight, width: 1.5),
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: t.done
//                         ? const Icon(Icons.check, size: 14, color: Colors.white)
//                         : null,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(child: GestureDetector(
//                   onTap: () => setState(() => t.done = !t.done),
//                   child: Text(t.title,
//                       style: ts(13, FontWeight.w400, t.done ? T.inkMid : T.ink)
//                           .copyWith(
//                         decoration: t.done ? TextDecoration.lineThrough : null,
//                         decorationColor: T.inkMid,
//                       )),
//                 )),
//                 GestureDetector(
//                   onTap: () => _removeTask(idx),
//                   child: Container(
//                     width: 26, height: 26,
//                     decoration: BoxDecoration(
//                       color: T.red.withOpacity(0.08),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: const Icon(Icons.remove, color: T.red, size: 15),
//                   ),
//                 ),
//               ]),
//             );
//           }),
//         ] else ...[
//           const SizedBox(height: 24),
//           Center(child: Column(children: [
//             Icon(Icons.check_circle_outline, color: T.inkLight, size: 42),
//             const SizedBox(height: 8),
//             Text('No tasks yet', style: ts(13, FontWeight.w400, T.inkMid)),
//             const SizedBox(height: 2),
//             Text('Tap + to add your first task',
//                 style: ts(12, FontWeight.w400, T.inkLight)),
//           ])),
//           const SizedBox(height: 12),
//         ],
//       ]),
//     );
//   }
// }
//
// // home screen
// class Defaulthome extends StatefulWidget {
//   const Defaulthome({super.key});
//   @override
//   State<Defaulthome> createState() => _DHSt();
// }
//
// class _DHSt extends State<Defaulthome> with SingleTickerProviderStateMixin {
//
//   static const String _name        = 'Rohan';
//   static const String _email       = 'rohan@eduvault.app';
//   static const String _firstLetter = 'R';
//
//   int _navIndex = 2;
//
//   late final AnimationController _entry;
//   late final Animation<double>   _entryFade;
//   late final Animation<Offset>   _entrySlide;
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ));
//     _entry = AnimationController(vsync: this, duration: const Duration(milliseconds: 520));
//     _entryFade  = CurvedAnimation(parent: _entry, curve: Curves.easeOut);
//     _entrySlide = Tween<Offset>(begin: const Offset(0, 0.025), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _entry, curve: Curves.easeOut));
//     _entry.forward();
//   }
//
//   @override
//   void dispose() { _entry.dispose(); super.dispose(); }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.dark,
//       child: Scaffold(
//         backgroundColor: T.pageBg,
//         drawer: _drawer(),
//         appBar: _homeAppBar(),
//         bottomNavigationBar: _bottomNav(),
//         body: FadeTransition(
//           opacity: _entryFade,
//           child: SlideTransition(
//             position: _entrySlide,
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.fromLTRB(18, 18, 18, 36),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const _HeroCard(name: _name, firstLetter: _firstLetter),
//                   const SizedBox(height: 16),
//                   const _QuoteCard(),
//                   const SizedBox(height: 22),
//                   Text('Quick Access', style: ts(15, FontWeight.w700)),
//                   const SizedBox(height: 12),
//                   _QuickGrid(
//                     onVideosTap: () => Navigator.push(
//                       context, _slideRoute(const SubjectListPage()),
//                     ),
//                   ),
//                   const SizedBox(height: 22),
//                   const _TasksCard(),
//                   const SizedBox(height: 4),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   PreferredSizeWidget _homeAppBar() => AppBar(
//     backgroundColor: T.white,
//     foregroundColor: T.ink,
//     elevation: 0,
//     systemOverlayStyle: SystemUiOverlayStyle.dark,
//     bottom: PreferredSize(
//       preferredSize: const Size.fromHeight(1),
//       child: Container(color: T.line, height: 1),
//     ),
//     title: Row(children: [
//       Container(
//         width: 30, height: 30,
//         decoration: BoxDecoration(color: T.blue, borderRadius: BorderRadius.circular(9)),
//         child: const Center(child: Text('E',
//             style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16))),
//       ),
//       const SizedBox(width: 10),
//       Text('EduVault', style: ts(20, FontWeight.w700)),
//     ]),
//     actions: [
//       Stack(children: [
//         IconButton(
//           icon: const Icon(Icons.notifications_outlined, size: 23, color: T.inkMid),
//           onPressed: () {},
//         ),
//         Positioned(right: 10, top: 11,
//             child: Container(width: 7, height: 7,
//                 decoration: const BoxDecoration(shape: BoxShape.circle, color: T.red))),
//       ]),
//       const SizedBox(width: 4),
//     ],
//   );
//
//   Widget _drawer() => Drawer(
//     width: 272,
//     backgroundColor: T.white,
//     child: Column(children: [
//       Container(
//         padding: const EdgeInsets.fromLTRB(20, 56, 20, 26),
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF3D6EFF), Color(0xFF254FDB)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Row(children: [
//           Container(
//             width: 52, height: 52,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.white.withOpacity(0.18),
//               border: Border.all(color: Colors.white.withOpacity(0.35), width: 1.5),
//             ),
//             child: Center(child: Text(_firstLetter,
//                 style: ts(22, FontWeight.w700, Colors.white))),
//           ),
//           const SizedBox(width: 14),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(_name, style: ts(16, FontWeight.w700, Colors.white)),
//             const SizedBox(height: 2),
//             Text(_email, style: ts(11, FontWeight.w400, Colors.white70),
//                 overflow: TextOverflow.ellipsis),
//           ])),
//         ]),
//       ),
//       Expanded(child: ListView(padding: const EdgeInsets.symmetric(vertical: 10), children: [
//         _dItem(Icons.person_outline,   'Profile'),
//         _dItem(Icons.bar_chart,         'Progress Report'),
//         _dItem(Icons.share_outlined,    'Share App'),
//         _dItem(Icons.settings_outlined, 'Settings'),
//         _dItem(Icons.help_outline,      'Help & Support'),
//       ])),
//       Container(height: 1, color: T.line),
//       ListTile(
//         leading: Container(width: 36, height: 36,
//             decoration: BoxDecoration(color: T.red.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(T.r10)),
//             child: const Icon(Icons.logout, color: T.red, size: 18)),
//         title: Text('Logout', style: ts(14, FontWeight.w500, T.red)),
//         onTap: () {},
//       ),
//       const SizedBox(height: 18),
//     ]),
//   );
//
//   Widget _dItem(IconData icon, String title) => ListTile(
//     leading: Container(width: 36, height: 36,
//         decoration: BoxDecoration(color: T.blueSoft,
//             borderRadius: BorderRadius.circular(T.r10)),
//         child: Icon(icon, color: T.blue, size: 18)),
//     title: Text(title, style: ts(13, FontWeight.w500)),
//     trailing: const Icon(Icons.chevron_right, color: T.inkLight, size: 18),
//     onTap: () {},
//   );
//
//   Widget _bottomNav() => Container(
//     decoration: const BoxDecoration(
//       color: T.white,
//       border: Border(top: BorderSide(color: T.line, width: 1)),
//     ),
//     child: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//           _nItem(0, Icons.book_outlined,           'Textbook'),
//           _nItem(1, Icons.note_alt_outlined,       'Notes'),
//           _nItem(2, Icons.home_rounded,            'Home'),
//           _nItem(3, Icons.quiz_outlined,           'Quiz'),
//           _nItem(4, Icons.calendar_today_outlined, 'Schedule'),
//         ]),
//       ),
//     ),
//   );
//
//   Widget _nItem(int i, IconData icon, String label) {
//     final active = i == _navIndex;
//     return GestureDetector(
//       onTap: () => setState(() => _navIndex = i),
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
//         decoration: BoxDecoration(
//           color: active ? T.blueSoft : Colors.transparent,
//           borderRadius: BorderRadius.circular(T.r14),
//         ),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Icon(icon, color: active ? T.blue : T.inkMid, size: 22),
//           const SizedBox(height: 3),
//           Text(label, style: ts(9,
//               active ? FontWeight.w700 : FontWeight.w400,
//               active ? T.blue : T.inkMid)),
//         ]),
//       ),
//     );
//   }
// }
