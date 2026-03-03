// Default Home Screen where user will be redirected

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eduvault/Login/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class T {
  T._();
  static const pageBg = Color(0xFFF4F7FF);
  static const white = Color(0xFFFFFFFF);
  static const blue = Color(0xFF3D6EFF);
  static const blueDark = Color(0xFF254FDB);
  static const blueSoft = Color(0xFFEBF0FF);
  static const ink = Color(0xFF0D1B40);
  static const inkMid = Color(0xFF7886A0);
  static const inkLight = Color(0xFFCDD5E4);
  static const line = Color(0xFFECF0FB);
  static const green = Color(0xFF1DB97B);
  static const red = Color(0xFFEF4444);

  static const r10 = 10.0;
  static const r14 = 14.0;
  static const r18 = 18.0;
  static const r20 = 20.0;
  static const r22 = 22.0;
  static const r28 = 28.0;

  static BoxDecoration card({double r = r20}) => BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(r),
    border: Border.all(color: line, width: 1),
    boxShadow: [
      BoxShadow(
        color: blue.withOpacity(0.07),
        blurRadius: 18,
        offset: const Offset(0, 5),
      ),
    ],
  );
}

TextStyle ts(double sz, FontWeight w, [Color c = T.ink]) =>
    TextStyle(color: c, fontSize: sz, fontWeight: w, letterSpacing: -0.2);

class Defaulthome extends StatefulWidget {
  const Defaulthome({super.key});

  @override
  State<Defaulthome> createState() => _DefaulthomeState();
}

class _DefaulthomeState extends State<Defaulthome> {
  @override
  int _currentPage = 0;
  final PageController _controller = PageController();
  List<String> images = [
    'assets/images/SliderImage1.jpg',
    'assets/images/SliderImage1.jpg',
    'assets/images/SliderImage1.jpg',
  ];

  int _currentIndex = 2;
  int? _userClass;
  String _name = "User";
  String _email = "";
  String _firstLetter = "U";

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
        if (snapshot.connectionState == ConnectionState.waiting &&
            _userClass == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData && snapshot.data!.exists) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          var rawClass = data['class'] ?? 9;
          _userClass = (rawClass is int)
              ? rawClass
              : int.tryParse(rawClass.toString()) ?? 9;
          _name = data['name'] ?? "User";
          _email = data['email'] ?? user.email ?? "";
          _firstLetter = _name.isNotEmpty ? _name[0].toUpperCase() : "U";
        }

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            backgroundColor: Color(0xFFF7FAFF),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  spacing: 8,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 10),
                        _HeroCard(name: _name, firstLetter: _firstLetter),
                        const SizedBox(height: 25),

                        SizedBox(
                          height: 170, // Height of slider
                          child: PageView.builder(
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            controller: _controller,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    images[index],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Center(
                          child: SmoothPageIndicator(
                            controller: _controller,
                            count: images.length,
                            effect: ExpandingDotsEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: Colors.blue,
                              dotColor: Colors.grey.shade400,
                            ),
                          ),
                        ),


                        const SizedBox(height: 25),
                        Text('Quick Access', style: ts(15, FontWeight.w700)),
                        const SizedBox(height: 17),
                        _QuickGrid(
                          onVideosTap: () => Navigator.push(
                            context, _slideRoute(const SubjectListPage()),
                          ),
                        ),


                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _HeroCard extends StatelessWidget {
  final String name, firstLetter;
  const _HeroCard({required this.name, required this.firstLetter});

  String get _greet {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning 🌄';
    if (h < 17) return 'Good Afternoon ☀️';
    return 'Good Evening 🌇';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 107,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.blueAccent],
        ),
        borderRadius: BorderRadius.circular(T.r18),
        boxShadow: [
          BoxShadow(
            color: T.blue.withOpacity(0.30),
            blurRadius: 28,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -28,
            right: 50,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 10.0, top: 5),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 20,
                          left: 5,
                          top: 5,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _greet,
                              style: ts(13, FontWeight.w400, Colors.white70),
                            ),
                            Text(
                              name.toUpperCase(),
                              style: ts(18, FontWeight.w700, Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.15),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          firstLetter,
                          style: ts(22, FontWeight.w700, Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 5),
              Container(
                height: 1,
                width: 300,
                color: Colors.white.withOpacity(0.15),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    _pill('📚', 'Keep learning'),
                    const SizedBox(width: 10),
                    _pill('🎯', 'Stay focused'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String emoji, String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.14),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 13)),
        const SizedBox(width: 6),
        Text(label, style: ts(12, FontWeight.w500, Colors.white)),
      ],
    ),
  );
}



class _QuickGrid extends StatelessWidget {
  final VoidCallback onVideosTap;
  const _QuickGrid({required this.onVideosTap});

  static const _items = <List>[
    [Icons.play_circle_outline_rounded, 'Videos',      Color(0xFF3D6EFF)],
    [Icons.book_outlined,               'Textbooks',   Color(0xFF7C5CDB)],
    [Icons.note_alt_outlined,           'Notes',       Color(0xFF0FB97A)],
    [Icons.quiz_outlined,               'Quiz',        Color(0xFFF5A623)],
    [Icons.calendar_today_outlined,     'Timetable',   Color(0xFF0AAFC9)],
    [Icons.timer_outlined,              'Pomodoro',    Color(0xFFEF4444)],
    [Icons.assignment_outlined,         'Assignments', Color(0xFF3D6EFF)],
    [Icons.bar_chart_rounded,           'Progress',    Color(0xFF0FB97A)],
  ];

  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: _items.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 4, mainAxisSpacing: 10,
      crossAxisSpacing: 10, childAspectRatio: 0.9,
    ),
    itemBuilder: (_, i) {
      final icon  = _items[i][0] as IconData;
      final label = _items[i][1] as String;
      final color = _items[i][2] as Color;
      return GestureDetector(
        onTap: label == 'Videos' ? onVideosTap : () {},
        child: Container(
          decoration: T.card(r: T.r18),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 42, height: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(T.r14),
              ),
              child: Icon(icon, color: color, size: 21),
            ),
            const SizedBox(height: 7),
            Text(label, textAlign: TextAlign.center, style: ts(10, FontWeight.w600)),
          ]),
        ),
      );
    },
  );
}


class ChapterVideo {
  final String chapterTitle;
  final String videoTitle;
  final String youtubeUrl;
  const ChapterVideo({
    required this.chapterTitle,
    required this.videoTitle,
    required this.youtubeUrl,
  });
}

class Subject {
  final String name;
  final IconData icon;
  final Color color;
  final List<ChapterVideo> chapters;
  const Subject({
    required this.name,
    required this.icon,
    required this.color,
    required this.chapters,
  });
}

// update these URLs with real video links
const List<Subject> kSubjects = [
  Subject(
    name: 'Science',
    icon: Icons.science_outlined,
    color: Color(0xFF3D6EFF),
    chapters: [
      ChapterVideo(chapterTitle: 'Chapter 1 – Matter',            videoTitle: 'Introduction to Matter',         youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
      ChapterVideo(chapterTitle: 'Chapter 2 – Force & Motion',    videoTitle: 'Force and Laws of Motion',       youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
      ChapterVideo(chapterTitle: 'Chapter 3 – Atoms & Molecules', videoTitle: 'Atoms and Molecules',            youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
      ChapterVideo(chapterTitle: 'Chapter 4 – Cell Structure',    videoTitle: 'The Fundamental Unit of Life',   youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI'),
    ],
  ),
  Subject(
    name: 'Maths',
    icon: Icons.calculate_outlined,
    color: Color(0xFF0AAFC9),
    chapters: [
      ChapterVideo(chapterTitle: 'Chapter 1 – Number Systems',       videoTitle: 'Number System Basics',             youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
      ChapterVideo(chapterTitle: 'Chapter 2 – Polynomials',          videoTitle: 'Introduction to Polynomials',      youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
      ChapterVideo(chapterTitle: 'Chapter 3 – Coordinate Geometry',  videoTitle: 'Coordinate Geometry',              youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
      ChapterVideo(chapterTitle: 'Chapter 4 – Linear Equations',     videoTitle: 'Linear Equations in 2 Variables',  youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI'),
    ],
  ),
  Subject(
    name: 'English',
    icon: Icons.menu_book_outlined,
    color: Color(0xFF7C5CDB),
    chapters: [
      ChapterVideo(chapterTitle: 'Chapter 1 – The Fun They Had',   videoTitle: 'The Fun They Had – Explanation',  youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
      ChapterVideo(chapterTitle: 'Chapter 2 – The Sound of Music', videoTitle: 'The Sound of Music',              youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
      ChapterVideo(chapterTitle: 'Chapter 3 – The Little Girl',    videoTitle: 'The Little Girl – Analysis',      youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
    ],
  ),
  Subject(
    name: 'Hindi',
    icon: Icons.translate,
    color: Color(0xFF0FB97A),
    chapters: [
      ChapterVideo(chapterTitle: 'Chapter 1 – Do Bailon ki Katha',      videoTitle: 'Do Bailon ki Katha',       youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
      ChapterVideo(chapterTitle: 'Chapter 2 – Lhasa ki Aur',            videoTitle: 'Lhasa ki Aur',             youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
      ChapterVideo(chapterTitle: 'Chapter 3 – Upbhog wadi Sanskriti',   videoTitle: 'Upbhog wadi Sanskriti',    youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
    ],
  ),
  Subject(
    name: 'Marathi',
    icon: Icons.language_outlined,
    color: Color(0xFFF5A623),
    chapters: [
      ChapterVideo(chapterTitle: 'Chapter 1 – Vaara',           videoTitle: 'Vaara – Explanation',       youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
      ChapterVideo(chapterTitle: 'Chapter 2 – Maza Abhyas',     videoTitle: 'Maza Abhyas',               youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
      ChapterVideo(chapterTitle: 'Chapter 3 – Shivaji Maharaj', videoTitle: 'Shivaji Maharaj – Chapter', youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
    ],
  ),
  Subject(
    name: 'Social Science',
    icon: Icons.public_outlined,
    color: Color(0xFFEF4444),
    chapters: [
      ChapterVideo(chapterTitle: 'Chapter 1 – French Revolution',    videoTitle: 'French Revolution',             youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4'),
      ChapterVideo(chapterTitle: 'Chapter 2 – Socialism in Europe',  videoTitle: 'Socialism in Europe',           youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o'),
      ChapterVideo(chapterTitle: 'Chapter 3 – Nazism',               videoTitle: 'Nazism and the Rise of Hitler', youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc'),
      ChapterVideo(chapterTitle: 'Chapter 4 – Forest Society',       videoTitle: 'Forest Society and Colonialism',youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI'),
    ],
  ),
];

AppBar _appBar(String title, [List<Widget>? actions]) => AppBar(
  title: Text(title, style: ts(17, FontWeight.w600)),
  backgroundColor: T.white,
  foregroundColor: T.ink,
  elevation: 0,
  systemOverlayStyle: SystemUiOverlayStyle.dark,
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(1),
    child: Container(color: T.line, height: 1),
  ),
  actions: actions,
);

Route _slideRoute(Widget page) => PageRouteBuilder(
  pageBuilder: (_, __, ___) => page,
  transitionsBuilder: (_, a, __, child) => SlideTransition(
    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
    child: child,
  ),
  transitionDuration: const Duration(milliseconds: 300),
);

// pages
class VideoPlayerPage extends StatefulWidget {
  final String title;
  final String youtubeUrl;
  const VideoPlayerPage({super.key, required this.title, required this.youtubeUrl});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final id = YoutubePlayer.convertUrlToId(widget.youtubeUrl) ?? '';
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: T.blue,
        progressColors: const ProgressBarColors(
          playedColor: T.blue,
          handleColor: T.blueDark,
        ),
        onReady: () => _controller.play(),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: T.pageBg,
          appBar: _appBar(widget.title),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              player,
              Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: T.card(),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(widget.title, style: ts(16, FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text('Tap the video to play or pause.',
                        style: ts(12, FontWeight.w400, T.inkMid)),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChapterListPage extends StatelessWidget {
  final Subject subject;
  const ChapterListPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: T.pageBg,
      appBar: _appBar(subject.name),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: subject.chapters.length,
        itemBuilder: (_, i) {
          final ch = subject.chapters[i];
          return GestureDetector(
            onTap: () => Navigator.push(context,
                _slideRoute(VideoPlayerPage(
                  title: ch.videoTitle,
                  youtubeUrl: ch.youtubeUrl,
                ))),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: T.card(),
              child: Row(children: [
                Container(
                  width: 44, height: 44,
                  decoration: BoxDecoration(
                    color: subject.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(T.r14),
                  ),
                  child: Center(
                    child: Text('${i + 1}',
                        style: ts(16, FontWeight.w700, subject.color)),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(ch.chapterTitle, style: ts(14, FontWeight.w600)),
                  const SizedBox(height: 3),
                  Text(ch.videoTitle, style: ts(12, FontWeight.w400, T.inkMid)),
                ])),
                Container(
                  width: 32, height: 32,
                  decoration: BoxDecoration(
                    color: subject.color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.play_arrow_rounded, color: subject.color, size: 18),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}

class SubjectListPage extends StatelessWidget {
  const SubjectListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: T.pageBg,
      appBar: _appBar('Select Subject'),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        itemCount: kSubjects.length,
        itemBuilder: (_, i) {
          final sub = kSubjects[i];
          return GestureDetector(
            onTap: () => Navigator.push(context,
                _slideRoute(ChapterListPage(subject: sub))),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: T.card(),
              child: Row(children: [
                Container(
                  width: 48, height: 48,
                  decoration: BoxDecoration(
                    color: sub.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(T.r14),
                  ),
                  child: Icon(sub.icon, color: sub.color, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(sub.name, style: ts(15, FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text('${sub.chapters.length} chapters',
                      style: ts(12, FontWeight.w400, T.inkMid)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: sub.color.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.play_circle_outline_rounded, color: sub.color, size: 14),
                    const SizedBox(width: 4),
                    Text('Watch', style: ts(11, FontWeight.w600, sub.color)),
                  ]),
                ),
              ]),
            ),
          );
        },
      ),
    );
  }
}