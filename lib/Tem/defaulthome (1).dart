// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  DESIGN SYSTEM — single source of truth for every colour, radius, shadow
// // ══════════════════════════════════════════════════════════════════════════════
// class DS {
//   DS._();
//
//   // Backgrounds
//   static const bg      = Color(0xFF0D0F14); // page background
//   static const surface = Color(0xFF161921); // card surface
//   static const card    = Color(0xFF1E2230); // elevated card
//   static const border  = Color(0xFF2A2F42); // subtle divider
//
//   // Accent — ONE blue used everywhere
//   static const accent  = Color(0xFF4F7EFF);
//   static const accentD = Color(0xFF2D5CE8); // darker variant
//
//   // Semantic (tinted, never garish)
//   static const green  = Color(0xFF34D399);
//   static const amber  = Color(0xFFFBBF24);
//   static const red    = Color(0xFFF87171);
//   static const purple = Color(0xFFA78BFA);
//   static const cyan   = Color(0xFF22D3EE);
//
//   // Text
//   static const textPrimary   = Color(0xFFEDF2FF);
//   static const textSecondary = Color(0xFF6B7280);
//   static const textMuted     = Color(0xFF374151);
//
//   // Radii
//   static const r8  = 8.0;
//   static const r12 = 12.0;
//   static const r16 = 16.0;
//   static const r20 = 20.0;
//   static const r24 = 24.0;
//
//   // Subject palette — all in the same dark-tinted family
//   static const subjectColors = [
//     Color(0xFF4F7EFF), // Science   – blue
//     Color(0xFF34D399), // Maths     – green
//     Color(0xFFA78BFA), // English   – purple
//     Color(0xFFFBBF24), // Hindi     – amber
//     Color(0xFF22D3EE), // Marathi   – cyan
//     Color(0xFFF87171), // Soc. Sci. – red
//   ];
//
//   // Shared card decoration
//   static BoxDecoration cardDecor({double radius = r20, Color? color}) => BoxDecoration(
//         color: color ?? card,
//         borderRadius: BorderRadius.circular(radius),
//         border: Border.all(color: border, width: 1),
//       );
//
//   // Subtle glow shadow
//   static List<BoxShadow> glow(Color c, {double blur = 20, double spread = 0}) =>
//       [BoxShadow(color: c.withOpacity(0.18), blurRadius: blur, spreadRadius: spread)];
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  DATA MODELS
// // ══════════════════════════════════════════════════════════════════════════════
// class VideoItem {
//   final String title, description, youtubeUrl;
//   final IconData icon;
//   const VideoItem({required this.title, required this.description, required this.youtubeUrl, required this.icon});
// }
//
// class SubjectProgress {
//   final String name;
//   final int completedChapters, totalChapters;
//   final Color color;
//   final IconData icon;
//   const SubjectProgress({required this.name, required this.completedChapters, required this.totalChapters, required this.color, required this.icon});
//   double get pct => completedChapters / totalChapters;
// }
//
// class TodayTask {
//   final String title;
//   bool done;
//   TodayTask(this.title, {this.done = false});
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  VIDEO PAGES
// // ══════════════════════════════════════════════════════════════════════════════
// class VideoListPage extends StatelessWidget {
//   const VideoListPage({super.key});
//   static const _videos = [
//     VideoItem(title: 'Introduction to Flutter',   description: 'Learn the basics of Flutter development.',   youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4', icon: Icons.play_lesson),
//     VideoItem(title: 'Dart Programming Basics',   description: 'Understand Dart language fundamentals.',      youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o', icon: Icons.code),
//     VideoItem(title: 'State Management',          description: 'Learn how to manage state in Flutter apps.',  youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc',  icon: Icons.developer_mode),
//     VideoItem(title: 'UI/UX Design Principles',   description: 'Design beautiful and intuitive interfaces.',  youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI',  icon: Icons.design_services),
//   ];
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: DS.bg,
//         appBar: _appBar('Video Lessons'),
//         body: ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: _videos.length,
//           itemBuilder: (_, i) {
//             final v = _videos[i];
//             return GestureDetector(
//               onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoPlayerPage(video: v))),
//               child: Container(
//                 margin: const EdgeInsets.only(bottom: 12),
//                 padding: const EdgeInsets.all(16),
//                 decoration: DS.cardDecor(),
//                 child: Row(children: [
//                   Container(width: 46, height: 46, decoration: BoxDecoration(color: DS.accent.withOpacity(0.12), borderRadius: BorderRadius.circular(DS.r12)), child: Icon(v.icon, color: DS.accent, size: 22)),
//                   const SizedBox(width: 14),
//                   Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     Text(v.title,       style: _ts(15, FontWeight.w600)),
//                     const SizedBox(height: 3),
//                     Text(v.description, style: _ts(12, FontWeight.w400, DS.textSecondary)),
//                   ])),
//                   const Icon(Icons.chevron_right, color: DS.textSecondary, size: 20),
//                 ]),
//               ),
//             );
//           },
//         ),
//       );
// }
//
// class VideoPlayerPage extends StatefulWidget {
//   final VideoItem video;
//   const VideoPlayerPage({super.key, required this.video});
//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }
// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late YoutubePlayerController _c;
//   @override
//   void initState() {
//     super.initState();
//     _c = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.video.youtubeUrl) ?? '',
//       flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
//     );
//   }
//   @override
//   void dispose() { _c.dispose(); super.dispose(); }
//   @override
//   Widget build(BuildContext context) => YoutubePlayerBuilder(
//     player: YoutubePlayer(controller: _c, showVideoProgressIndicator: true, progressIndicatorColor: DS.accent, onReady: () => _c.play()),
//     builder: (_, player) => Scaffold(
//       backgroundColor: DS.bg,
//       appBar: _appBar(widget.video.title),
//       body: Column(children: [
//         player,
//         Padding(
//           padding: const EdgeInsets.all(16),
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: DS.cardDecor(),
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(widget.video.title,       style: _ts(16, FontWeight.w600)),
//               const SizedBox(height: 6),
//               Text(widget.video.description, style: _ts(13, FontWeight.w400, DS.textSecondary)),
//             ]),
//           ),
//         ),
//       ]),
//     ),
//   );
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  SHARED HELPERS
// // ══════════════════════════════════════════════════════════════════════════════
// AppBar _appBar(String title) => AppBar(
//       title: Text(title, style: _ts(18, FontWeight.w600)),
//       backgroundColor: DS.surface,
//       foregroundColor: DS.textPrimary,
//       elevation: 0,
//       systemOverlayStyle: SystemUiOverlayStyle.light,
//       bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(color: DS.border, height: 1)),
//     );
//
// TextStyle _ts(double size, FontWeight w, [Color c = DS.textPrimary]) =>
//     TextStyle(color: c, fontSize: size, fontWeight: w, letterSpacing: -0.2);
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  CIRCULAR PROGRESS PAINTER
// // ══════════════════════════════════════════════════════════════════════════════
// class _RingPainter extends CustomPainter {
//   final double progress;
//   final Color color;
//   final double stroke;
//   _RingPainter({required this.progress, required this.color, this.stroke = 6});
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final c = Offset(size.width / 2, size.height / 2);
//     final r = (size.width - stroke) / 2;
//     canvas.drawCircle(c, r, Paint()..color = color.withOpacity(0.12)..strokeWidth = stroke..style = PaintingStyle.stroke..strokeCap = StrokeCap.round);
//     if (progress > 0) {
//       canvas.drawArc(
//         Rect.fromCircle(center: c, radius: r), -pi / 2, 2 * pi * progress.clamp(0.0, 1.0), false,
//         Paint()..color = color..strokeWidth = stroke..style = PaintingStyle.stroke..strokeCap = StrokeCap.round,
//       );
//     }
//   }
//
//   @override
//   bool shouldRepaint(_RingPainter o) => o.progress != progress;
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  FLOAT ANIMATION WRAPPER
// // ══════════════════════════════════════════════════════════════════════════════
// class _Float extends StatefulWidget {
//   final Widget child;
//   final double amplitude;
//   final Duration duration;
//   final Duration delay;
//   const _Float({required this.child, this.amplitude = 5, this.duration = const Duration(milliseconds: 2400), this.delay = Duration.zero});
//   @override
//   State<_Float> createState() => _FloatState();
// }
// class _FloatState extends State<_Float> with SingleTickerProviderStateMixin {
//   late final AnimationController _c;
//   late final Animation<double> _a;
//   @override
//   void initState() {
//     super.initState();
//     _c = AnimationController(vsync: this, duration: widget.duration);
//     _a = CurvedAnimation(parent: _c, curve: Curves.easeInOut);
//     Future.delayed(widget.delay, () { if (mounted) _c.repeat(reverse: true); });
//   }
//   @override
//   void dispose() { _c.dispose(); super.dispose(); }
//   @override
//   Widget build(BuildContext context) => AnimatedBuilder(
//     animation: _a,
//     builder: (_, child) => Transform.translate(offset: Offset(0, -widget.amplitude * _a.value), child: child),
//     child: widget.child,
//   );
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  PULSE DOT
// // ══════════════════════════════════════════════════════════════════════════════
// class _PulseDot extends StatefulWidget {
//   final Color color;
//   const _PulseDot({required this.color});
//   @override
//   State<_PulseDot> createState() => _PulseDotState();
// }
// class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
//   late final AnimationController _c;
//   @override
//   void initState() { super.initState(); _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900)); _c.repeat(reverse: true); }
//   @override
//   void dispose() { _c.dispose(); super.dispose(); }
//   @override
//   Widget build(BuildContext context) => AnimatedBuilder(
//     animation: _c,
//     builder: (_, __) => Container(
//       width: 8, height: 8,
//       decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color.withOpacity(0.4 + 0.6 * _c.value),
//         boxShadow: [BoxShadow(color: widget.color.withOpacity(0.5 * _c.value), blurRadius: 6)]),
//     ),
//   );
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  SECTION LABEL
// // ══════════════════════════════════════════════════════════════════════════════
// class _SectionLabel extends StatelessWidget {
//   final String title;
//   final String? action;
//   final VoidCallback? onAction;
//   const _SectionLabel(this.title, {this.action, this.onAction});
//   @override
//   Widget build(BuildContext context) => Padding(
//     padding: const EdgeInsets.only(bottom: 12),
//     child: Row(children: [
//       Text(title, style: _ts(15, FontWeight.w600)),
//       const Spacer(),
//       if (action != null)
//         GestureDetector(
//           onTap: onAction,
//           child: Text(action!, style: _ts(12, FontWeight.w500, DS.accent)),
//         ),
//     ]),
//   );
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  WELCOME CARD
// // ══════════════════════════════════════════════════════════════════════════════
// class _WelcomeCard extends StatelessWidget {
//   final String name, firstLetter;
//   final int streakDays;
//   const _WelcomeCard({required this.name, required this.firstLetter, required this.streakDays});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: DS.card,
//         borderRadius: BorderRadius.circular(DS.r24),
//         border: Border.all(color: DS.accent.withOpacity(0.25), width: 1),
//         boxShadow: DS.glow(DS.accent, blur: 30),
//       ),
//       child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Expanded(
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('Good ${_greeting()} 👋', style: _ts(12, FontWeight.w500, DS.textSecondary)),
//             const SizedBox(height: 4),
//             Text(name, style: _ts(22, FontWeight.w700)),
//             const SizedBox(height: 14),
//             Row(children: [
//               _chip('🔥  $streakDays-day streak'),
//               const SizedBox(width: 8),
//               _chip('⭐  Level 5'),
//             ]),
//           ]),
//         ),
//         const SizedBox(width: 16),
//         _Float(
//           child: Container(
//             width: 58, height: 58,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: DS.accent.withOpacity(0.15),
//               border: Border.all(color: DS.accent.withOpacity(0.3), width: 1.5),
//             ),
//             child: Center(child: Text(firstLetter, style: _ts(24, FontWeight.w700, DS.accent))),
//           ),
//         ),
//       ]),
//     );
//   }
//
//   Widget _chip(String label) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//     decoration: BoxDecoration(
//       color: DS.surface,
//       borderRadius: BorderRadius.circular(20),
//       border: Border.all(color: DS.border),
//     ),
//     child: Text(label, style: _ts(11, FontWeight.w500, DS.textSecondary)),
//   );
//
//   String _greeting() {
//     final h = DateTime.now().hour;
//     if (h < 12) return 'morning';
//     if (h < 17) return 'afternoon';
//     return 'evening';
//   }
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  MOTIVATIONAL BANNER
// // ══════════════════════════════════════════════════════════════════════════════
// class _MotivationalBanner extends StatefulWidget {
//   const _MotivationalBanner();
//   @override
//   State<_MotivationalBanner> createState() => _MotivationalBannerState();
// }
// class _MotivationalBannerState extends State<_MotivationalBanner> with TickerProviderStateMixin {
//   int _idx = 0;
//   late final AnimationController _fade;
//   late final AnimationController _float;
//
//   static const _quotes = [
//     ['Education is the most powerful weapon to change the world.',        'Nelson Mandela'],
//     ['The beautiful thing about learning is nobody can take it from you.','B.B. King'],
//     ['An investment in knowledge pays the best interest.',                 'Benjamin Franklin'],
//     ['Success is hard work, perseverance and learning from failure.',      'Pelé'],
//     ["Don't watch the clock — do what it does. Keep going.",               'Sam Levenson'],
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _fade  = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
//     _float = AnimationController(vsync: this, duration: const Duration(milliseconds: 3200));
//     _fade.forward();
//     _float.repeat(reverse: true);
//     Timer.periodic(const Duration(seconds: 9), (_) {
//       if (!mounted) return;
//       _fade.reverse().then((_) {
//         if (!mounted) return;
//         setState(() => _idx = (_idx + 1) % _quotes.length);
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
//       builder: (_, child) => Transform.translate(offset: Offset(0, -4 * CurvedAnimation(parent: _float, curve: Curves.easeInOut).value), child: child),
//       child: FadeTransition(
//         opacity: CurvedAnimation(parent: _fade, curve: Curves.easeIn),
//         child: Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
//           decoration: BoxDecoration(
//             color: DS.card,
//             borderRadius: BorderRadius.circular(DS.r24),
//             border: Border.all(color: DS.border),
//             boxShadow: DS.glow(DS.accent, blur: 24),
//           ),
//           child: Column(children: [
//             // Decorative top bar
//             Container(width: 36, height: 3, decoration: BoxDecoration(color: DS.accent, borderRadius: BorderRadius.circular(2))),
//             const SizedBox(height: 20),
//             Text(
//               '"${_quotes[_idx][0]}"',
//               textAlign: TextAlign.center,
//               style: _ts(17, FontWeight.w600).copyWith(height: 1.6),
//             ),
//             const SizedBox(height: 14),
//             Text('— ${_quotes[_idx][1]}', style: _ts(12, FontWeight.w500, DS.textSecondary)),
//             const SizedBox(height: 18),
//             // Dot indicators
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(_quotes.length, (i) => AnimatedContainer(
//                 duration: const Duration(milliseconds: 300),
//                 margin: const EdgeInsets.symmetric(horizontal: 3),
//                 width: i == _idx ? 16 : 5,
//                 height: 5,
//                 decoration: BoxDecoration(
//                   color: i == _idx ? DS.accent : DS.border,
//                   borderRadius: BorderRadius.circular(3),
//                 ),
//               )),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  STUDY HOURS BAR
// // ══════════════════════════════════════════════════════════════════════════════
// class _StudyBar extends StatelessWidget {
//   final double studied, target;
//   const _StudyBar({required this.studied, required this.target});
//
//   @override
//   Widget build(BuildContext context) {
//     final progress = (studied / target).clamp(0.0, 1.0);
//     final pct = (progress * 100).toInt();
//     final remaining = (target - studied).clamp(0.0, target);
//     final barColor = progress < 0.4 ? DS.red : progress < 0.75 ? DS.amber : DS.green;
//     final label    = progress < 0.4 ? 'Keep going' : progress < 0.75 ? 'Good pace' : 'Almost there!';
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: DS.cardDecor(),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(children: [
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text('Daily Study Goal', style: _ts(14, FontWeight.w600)),
//             const SizedBox(height: 2),
//             Text(label, style: _ts(11, FontWeight.w400, DS.textSecondary)),
//           ])),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//             decoration: BoxDecoration(color: barColor.withOpacity(0.12), borderRadius: BorderRadius.circular(20), border: Border.all(color: barColor.withOpacity(0.3))),
//             child: Text('$pct%', style: _ts(13, FontWeight.w700, barColor)),
//           ),
//         ]),
//         const SizedBox(height: 16),
//         // Track
//         ClipRRect(
//           borderRadius: BorderRadius.circular(6),
//           child: Stack(children: [
//             Container(height: 8, color: DS.border),
//             FractionallySizedBox(
//               widthFactor: progress,
//               child: Container(height: 8, decoration: BoxDecoration(
//                 gradient: LinearGradient(colors: [barColor.withOpacity(0.7), barColor]),
//                 borderRadius: BorderRadius.circular(6),
//                 boxShadow: [BoxShadow(color: barColor.withOpacity(0.4), blurRadius: 6)],
//               )),
//             ),
//           ]),
//         ),
//         const SizedBox(height: 12),
//         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//           Text('${studied.toStringAsFixed(1)} h done', style: _ts(11, FontWeight.w400, DS.textSecondary)),
//           Text(remaining > 0 ? '${remaining.toStringAsFixed(1)} h left' : '✓ Goal hit!', style: _ts(11, FontWeight.w600, remaining > 0 ? DS.textSecondary : DS.green)),
//           Text('${target.toStringAsFixed(0)} h total', style: _ts(11, FontWeight.w400, DS.textSecondary)),
//         ]),
//       ]),
//     );
//   }
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  EXAM COUNTDOWN
// // ══════════════════════════════════════════════════════════════════════════════
// class _ExamCountdown extends StatefulWidget {
//   final String name;
//   final DateTime date;
//   const _ExamCountdown({required this.name, required this.date});
//   @override
//   State<_ExamCountdown> createState() => _ExamCountdownState();
// }
// class _ExamCountdownState extends State<_ExamCountdown> with SingleTickerProviderStateMixin {
//   late final AnimationController _c;
//
//   Duration get _rem {
//     final d = widget.date.difference(DateTime.now());
//     return d.isNegative ? Duration.zero : d;
//   }
//
//   static const _months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
//
//   @override
//   void initState() { super.initState(); _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 800)); _c.forward(); }
//   @override
//   void dispose() { _c.dispose(); super.dispose(); }
//
//   @override
//   Widget build(BuildContext context) {
//     final rem   = _rem;
//     final days  = rem.inDays;
//     final hours = rem.inHours % 24;
//     final months = days ~/ 30;
//     final rDays  = days % 30;
//
//     final urgencyColor = days > 60 ? DS.green : days > 30 ? DS.amber : DS.red;
//     final urgencyText  = days > 60 ? 'Stay consistent' : days > 30 ? 'Pick up pace' : 'Final sprint!';
//
//     return ScaleTransition(
//       scale: CurvedAnimation(parent: _c, curve: Curves.elasticOut),
//       child: Container(
//         padding: const EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: DS.card,
//           borderRadius: BorderRadius.circular(DS.r24),
//           border: Border.all(color: urgencyColor.withOpacity(0.25), width: 1),
//           boxShadow: DS.glow(urgencyColor, blur: 28),
//         ),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           // Header
//           Row(children: [
//             _PulseDot(color: urgencyColor),
//             const SizedBox(width: 8),
//             Text('Exam Countdown', style: _ts(12, FontWeight.w500, DS.textSecondary)),
//             const Spacer(),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//               decoration: BoxDecoration(color: urgencyColor.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: urgencyColor.withOpacity(0.2))),
//               child: Text(urgencyText, style: _ts(11, FontWeight.w600, urgencyColor)),
//             ),
//           ]),
//           const SizedBox(height: 14),
//           Text(widget.name, style: _ts(17, FontWeight.w700)),
//           Text('${widget.date.day} ${_months[widget.date.month - 1]} ${widget.date.year}', style: _ts(12, FontWeight.w400, DS.textSecondary)),
//           const SizedBox(height: 20),
//
//           // Time blocks
//           Row(children: [
//             if (months > 0) ...[_timeBlock('$months', 'MO', urgencyColor), _timeSep()],
//             _timeBlock('$rDays', 'DA', urgencyColor),
//             _timeSep(),
//             _timeBlock('$hours', 'HR', urgencyColor),
//           ]),
//
//           const SizedBox(height: 18),
//           Container(height: 1, color: DS.border),
//           const SizedBox(height: 14),
//
//           // Progress bar
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Text('Year progress', style: _ts(11, FontWeight.w400, DS.textSecondary)),
//             Text('${_yearProgress()}%', style: _ts(11, FontWeight.w600, urgencyColor)),
//           ]),
//           const SizedBox(height: 8),
//           ClipRRect(
//             borderRadius: BorderRadius.circular(4),
//             child: Stack(children: [
//               Container(height: 5, color: DS.border),
//               FractionallySizedBox(
//                 widthFactor: _yearProgress() / 100,
//                 child: Container(height: 5, decoration: BoxDecoration(
//                   gradient: LinearGradient(colors: [urgencyColor.withOpacity(0.6), urgencyColor]),
//                   borderRadius: BorderRadius.circular(4),
//                 )),
//               ),
//             ]),
//           ),
//         ]),
//       ),
//     );
//   }
//
//   Widget _timeBlock(String v, String l, Color c) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//     decoration: BoxDecoration(color: c.withOpacity(0.08), borderRadius: BorderRadius.circular(DS.r12), border: Border.all(color: c.withOpacity(0.2))),
//     child: Column(mainAxisSize: MainAxisSize.min, children: [
//       Text(v, style: _ts(26, FontWeight.w700, DS.textPrimary).copyWith(height: 1)),
//       const SizedBox(height: 2),
//       Text(l, style: _ts(9, FontWeight.w600, DS.textSecondary).copyWith(letterSpacing: 1.5)),
//     ]),
//   );
//
//   Widget _timeSep() => Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
//     child: Text(':', style: _ts(22, FontWeight.w300, DS.textMuted)),
//   );
//
//   int _yearProgress() {
//     final now   = DateTime.now();
//     final start = DateTime(now.year, 1, 1);
//     final end   = DateTime(now.year, 12, 31);
//     return ((now.difference(start).inDays / end.difference(start).inDays) * 100).toInt();
//   }
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  STREAK ROW
// // ══════════════════════════════════════════════════════════════════════════════
// class _StreakCard extends StatelessWidget {
//   final int days;
//   const _StreakCard({required this.days});
//   @override
//   Widget build(BuildContext context) => Container(
//     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//     decoration: DS.cardDecor(),
//     child: Row(children: [
//       _Float(child: const Text('🔥', style: TextStyle(fontSize: 28)), amplitude: 4, duration: const Duration(milliseconds: 1800)),
//       const SizedBox(width: 14),
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Text('$days Day Streak', style: _ts(15, FontWeight.w700)),
//         Text("You're on fire — don't stop!", style: _ts(11, FontWeight.w400, DS.textSecondary)),
//       ]),
//       const Spacer(),
//       // 7-dot week tracker
//       Row(
//         children: List.generate(7, (i) {
//           final lit = i < (days % 7 == 0 ? 7 : days % 7);
//           return Container(
//             margin: const EdgeInsets.symmetric(horizontal: 2.5),
//             width: 8, height: 8,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: lit ? DS.amber : DS.border,
//               boxShadow: lit ? [BoxShadow(color: DS.amber.withOpacity(0.5), blurRadius: 4)] : [],
//             ),
//           );
//         }),
//       ),
//     ]),
//   );
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  QUICK ACCESS GRID
// // ══════════════════════════════════════════════════════════════════════════════
// class _QuickGrid extends StatelessWidget {
//   final VoidCallback onVideosTap;
//   const _QuickGrid({required this.onVideosTap});
//
//   static const _items = [
//     [Icons.play_circle_outline_rounded, 'Videos',      DS.accent],
//     [Icons.book_outlined,               'Textbooks',   DS.purple],
//     [Icons.note_alt_outlined,           'Notes',       DS.green],
//     [Icons.quiz_outlined,               'Quiz',        DS.amber],
//     [Icons.calendar_today_outlined,     'Timetable',   DS.cyan],
//     [Icons.leaderboard_outlined,        'Leaders',     DS.red],
//     [Icons.assignment_outlined,         'Assignments', Color(0xFF34D399)],
//     [Icons.timer_outlined,              'Pomodoro',    Color(0xFFF87171)],
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: _items.length,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 0.85,
//       ),
//       itemBuilder: (_, i) {
//         final icon  = _items[i][0] as IconData;
//         final label = _items[i][1] as String;
//         final color = _items[i][2] as Color;
//         return GestureDetector(
//           onTap: label == 'Videos' ? onVideosTap : () {},
//           child: Container(
//             decoration: BoxDecoration(
//               color: DS.card,
//               borderRadius: BorderRadius.circular(DS.r16),
//               border: Border.all(color: DS.border),
//             ),
//             child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Container(
//                 width: 40, height: 40,
//                 decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
//                 child: Icon(icon, color: color, size: 20),
//               ),
//               const SizedBox(height: 6),
//               Text(label, textAlign: TextAlign.center, style: _ts(10, FontWeight.w500)),
//             ]),
//           ),
//         );
//       },
//     );
//   }
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  SUBJECT PROGRESS — avg ring + all subjects
// // ══════════════════════════════════════════════════════════════════════════════
// class _SubjectProgress extends StatelessWidget {
//   final List<SubjectProgress> subjects;
//   const _SubjectProgress({required this.subjects});
//
//   @override
//   Widget build(BuildContext context) {
//     final avg    = subjects.fold(0.0, (s, e) => s + e.pct) / subjects.length;
//     final avgPct = (avg * 100).toInt();
//     final avgColor = avg < 0.35 ? DS.red : avg < 0.65 ? DS.amber : avg < 0.85 ? DS.accent : DS.green;
//     final avgLabel = avg < 0.35 ? 'Just started' : avg < 0.65 ? 'In progress' : avg < 0.85 ? 'Almost there' : 'Excellent!';
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: DS.cardDecor(),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         _SectionLabel('Subject Progress', action: 'View All'),
//         Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           // Avg ring
//           Column(children: [
//             SizedBox(
//               width: 86, height: 86,
//               child: Stack(alignment: Alignment.center, children: [
//                 CustomPaint(painter: _RingPainter(progress: avg, color: avgColor, stroke: 8), size: const Size(86, 86)),
//                 Column(mainAxisSize: MainAxisSize.min, children: [
//                   Text('$avgPct%', style: _ts(19, FontWeight.w700, avgColor)),
//                   Text('avg', style: _ts(10, FontWeight.w400, DS.textSecondary)),
//                 ]),
//               ]),
//             ),
//             const SizedBox(height: 8),
//             Text('Overall', style: _ts(11, FontWeight.w600)),
//             Text(avgLabel, style: _ts(9, FontWeight.w500, avgColor)),
//           ]),
//
//           const SizedBox(width: 16),
//           Container(width: 1, height: 100, color: DS.border),
//           const SizedBox(width: 16),
//
//           // Subject rings
//           Expanded(
//             child: Wrap(spacing: 10, runSpacing: 12, children: subjects.map((s) {
//               final pct = (s.pct * 100).toInt();
//               return Column(mainAxisSize: MainAxisSize.min, children: [
//                 SizedBox(
//                   width: 52, height: 52,
//                   child: Stack(alignment: Alignment.center, children: [
//                     CustomPaint(painter: _RingPainter(progress: s.pct, color: s.color, stroke: 5), size: const Size(52, 52)),
//                     Column(mainAxisSize: MainAxisSize.min, children: [
//                       Icon(s.icon, color: s.color, size: 13),
//                       Text('$pct%', style: _ts(9, FontWeight.w700, s.color)),
//                     ]),
//                   ]),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(s.name, style: _ts(9, FontWeight.w500), textAlign: TextAlign.center),
//                 Text('${s.completedChapters}/${s.totalChapters}', style: _ts(8, FontWeight.w400, DS.textSecondary)),
//               ]);
//             }).toList()),
//           ),
//         ]),
//       ]),
//     );
//   }
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  TODAY'S TASKS
// // ══════════════════════════════════════════════════════════════════════════════
// class _TasksCard extends StatefulWidget {
//   const _TasksCard();
//   @override
//   State<_TasksCard> createState() => _TasksCardState();
// }
// class _TasksCardState extends State<_TasksCard> {
//   final _tasks = [
//     TodayTask('Complete Maths Chapter 5',   done: true),
//     TodayTask('Revise Science Notes'),
//     TodayTask('Practice Hindi Grammar'),
//     TodayTask('Solve 10 Quiz Questions'),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final done = _tasks.where((t) => t.done).length;
//     final progress = done / _tasks.length;
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: DS.cardDecor(),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(children: [
//           Expanded(child: Text("Today's Tasks", style: _ts(14, FontWeight.w600))),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
//             decoration: BoxDecoration(color: DS.green.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: DS.green.withOpacity(0.2))),
//             child: Text('$done / ${_tasks.length}', style: _ts(12, FontWeight.w600, DS.green)),
//           ),
//         ]),
//         const SizedBox(height: 10),
//         ClipRRect(borderRadius: BorderRadius.circular(4), child: Stack(children: [
//           Container(height: 4, color: DS.border),
//           FractionallySizedBox(widthFactor: progress, child: Container(height: 4, color: DS.green)),
//         ])),
//         const SizedBox(height: 14),
//         ..._tasks.map((t) => GestureDetector(
//           onTap: () => setState(() => t.done = !t.done),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 7),
//             child: Row(children: [
//               AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 width: 20, height: 20,
//                 decoration: BoxDecoration(
//                   color: t.done ? DS.accent : Colors.transparent,
//                   border: Border.all(color: t.done ? DS.accent : DS.border, width: 1.5),
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: t.done ? const Icon(Icons.check, size: 13, color: Colors.white) : null,
//               ),
//               const SizedBox(width: 12),
//               Expanded(child: Text(t.title, style: _ts(13, FontWeight.w400, t.done ? DS.textSecondary : DS.textPrimary).copyWith(decoration: t.done ? TextDecoration.lineThrough : null, decorationColor: DS.textSecondary))),
//             ]),
//           ),
//         )),
//       ]),
//     );
//   }
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  WEEKLY ACTIVITY CHART
// // ══════════════════════════════════════════════════════════════════════════════
// class _WeeklyChart extends StatelessWidget {
//   const _WeeklyChart();
//
//   static const _days   = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
//   static const _hours  = [4.5, 6.0, 3.2, 6.0, 5.5, 2.1, 1.0];
//   static const _target = 6.0;
//
//   @override
//   Widget build(BuildContext context) {
//     final today = DateTime.now().weekday - 1;
//
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: DS.cardDecor(),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         _SectionLabel('Weekly Activity'),
//         Text('Daily study hours', style: _ts(11, FontWeight.w400, DS.textSecondary)),
//         const SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: List.generate(7, (i) {
//             final h       = _hours[i];
//             final isGoal  = h >= _target;
//             final isToday = i == today;
//             final barH    = (h / _target) * 72;
//             final color   = isToday ? DS.accent : isGoal ? DS.green : DS.border;
//
//             return Column(mainAxisSize: MainAxisSize.min, children: [
//               Text('${h.toStringAsFixed(1)}', style: _ts(8, FontWeight.w400, isGoal ? DS.textSecondary : DS.textMuted)),
//               const SizedBox(height: 4),
//               Container(
//                 width: 26, height: barH,
//                 decoration: BoxDecoration(
//                   color: color,
//                   borderRadius: BorderRadius.circular(5),
//                   boxShadow: isToday ? DS.glow(DS.accent, blur: 10) : isGoal ? DS.glow(DS.green, blur: 8) : [],
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Text(_days[i], style: _ts(11, isToday ? FontWeight.w700 : FontWeight.w400, isToday ? DS.accent : DS.textSecondary)),
//               if (isToday)
//                 Container(margin: const EdgeInsets.only(top: 3), width: 4, height: 4, decoration: const BoxDecoration(shape: BoxShape.circle, color: DS.accent)),
//             ]);
//           }),
//         ),
//         const SizedBox(height: 16),
//         Container(height: 1, color: DS.border),
//         const SizedBox(height: 14),
//         Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
//           _stat('28.3 h', 'Total',   DS.accent),
//           _stat('4.0 h',  'Avg/Day', DS.amber),
//           _stat('2',      'Goals Hit', DS.green),
//         ]),
//       ]),
//     );
//   }
//
//   Widget _stat(String v, String l, Color c) => Column(children: [
//     Text(v, style: _ts(15, FontWeight.w700, c)),
//     const SizedBox(height: 2),
//     Text(l, style: _ts(10, FontWeight.w400, DS.textSecondary)),
//   ]);
// }
//
// // ══════════════════════════════════════════════════════════════════════════════
// //  DEFAULTHOME
// // ══════════════════════════════════════════════════════════════════════════════
// class Defaulthome extends StatefulWidget {
//   const Defaulthome({super.key});
//   @override
//   State<Defaulthome> createState() => _DefaulthomeState();
// }
//
// class _DefaulthomeState extends State<Defaulthome> with SingleTickerProviderStateMixin {
//
//   // ── User data (replace with real values) ─────────────────────────
//   final String name        = 'Rohan';
//   final String email       = 'rohan@eduvault.app';
//   final String firstLetter = 'R';
//   final int    streakDays  = 12;
//   final double studiedHours = 3.2;
//   final double targetHours  = 6.0;
//
//   // ── Exam (change date & name here) ────────────────────────────────
//   final DateTime examDate = DateTime(2026, 3, 22);
//   final String   examName = 'Final Board Examination 2026';
//
//   // ── Nav ───────────────────────────────────────────────────────────
//   int _navIndex = 2;
//
//   // ── Subjects ──────────────────────────────────────────────────────
//   final List<SubjectProgress> subjects = const [
//     SubjectProgress(name: 'Science',   completedChapters: 4, totalChapters: 10, color: DS.accent,  icon: Icons.science),
//     SubjectProgress(name: 'Maths',     completedChapters: 7, totalChapters: 12, color: DS.green,   icon: Icons.calculate),
//     SubjectProgress(name: 'English',   completedChapters: 5, totalChapters: 8,  color: DS.purple,  icon: Icons.menu_book),
//     SubjectProgress(name: 'Hindi',     completedChapters: 3, totalChapters: 10, color: DS.amber,   icon: Icons.translate),
//     SubjectProgress(name: 'Marathi',   completedChapters: 2, totalChapters: 9,  color: DS.cyan,    icon: Icons.language),
//     SubjectProgress(name: 'Soc. Sci.', completedChapters: 6, totalChapters: 14, color: DS.red,     icon: Icons.public),
//   ];
//
//   // ── Entry animation ────────────────────────────────────────────────
//   late final AnimationController _entry;
//   late final Animation<double> _entryFade;
//   late final Animation<Offset>  _entrySlide;
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor:      Colors.transparent,
//       statusBarIconBrightness: Brightness.light,
//     ));
//     _entry = AnimationController(vsync: this, duration: const Duration(milliseconds: 550));
//     _entryFade  = CurvedAnimation(parent: _entry, curve: Curves.easeOut);
//     _entrySlide = Tween<Offset>(begin: const Offset(0, 0.03), end: Offset.zero)
//         .animate(CurvedAnimation(parent: _entry, curve: Curves.easeOut));
//     _entry.forward();
//   }
//
//   @override
//   void dispose() { _entry.dispose(); super.dispose(); }
//
//   // ── Build ──────────────────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle.light,
//       child: Scaffold(
//         backgroundColor: DS.bg,
//         drawer: _buildDrawer(),
//         appBar: _buildAppBar(),
//         bottomNavigationBar: _buildNav(),
//         body: FadeTransition(
//           opacity: _entryFade,
//           child: SlideTransition(
//             position: _entrySlide,
//             child: SingleChildScrollView(
//               physics: const BouncingScrollPhysics(),
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _WelcomeCard(name: name, firstLetter: firstLetter, streakDays: streakDays),
//                   _gap(),
//                   const _MotivationalBanner(),
//                   _gap(),
//                   _StudyBar(studied: studiedHours, target: targetHours),
//                   _gap(),
//                   _ExamCountdown(name: examName, date: examDate),
//                   _gap(),
//                   _StreakCard(days: streakDays),
//                   _gap(),
//                   _SectionLabel('Quick Access'),
//                   _QuickGrid(onVideosTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoListPage()))),
//                   _gap(),
//                   _SubjectProgress(subjects: subjects),
//                   _gap(),
//                   const _TasksCard(),
//                   _gap(),
//                   const _WeeklyChart(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // ── App bar ────────────────────────────────────────────────────────
//   PreferredSizeWidget _buildAppBar() => AppBar(
//     backgroundColor: DS.surface,
//     foregroundColor: DS.textPrimary,
//     elevation: 0,
//     systemOverlayStyle: SystemUiOverlayStyle.light,
//     bottom: PreferredSize(preferredSize: const Size.fromHeight(1), child: Container(color: DS.border, height: 1)),
//     title: Row(children: [
//       Container(
//         width: 28, height: 28,
//         decoration: BoxDecoration(color: DS.accent.withOpacity(0.15), borderRadius: BorderRadius.circular(8), border: Border.all(color: DS.accent.withOpacity(0.3))),
//         child: const Center(child: Text('E', style: TextStyle(color: DS.accent, fontWeight: FontWeight.w800, fontSize: 15))),
//       ),
//       const SizedBox(width: 10),
//       Text('EduVault', style: _ts(20, FontWeight.w700)),
//     ]),
//     actions: [
//       Stack(children: [
//         IconButton(icon: const Icon(Icons.notifications_outlined, size: 22), onPressed: () {}),
//         Positioned(right: 11, top: 11, child: Container(width: 7, height: 7, decoration: const BoxDecoration(shape: BoxShape.circle, color: DS.red))),
//       ]),
//       const SizedBox(width: 4),
//     ],
//   );
//
//   // ── Drawer ─────────────────────────────────────────────────────────
//   Widget _buildDrawer() => Drawer(
//     width: 270,
//     backgroundColor: DS.surface,
//     child: Column(children: [
//       // Header
//       Container(
//         padding: const EdgeInsets.fromLTRB(20, 52, 20, 24),
//         decoration: const BoxDecoration(
//           color: DS.card,
//           border: Border(bottom: BorderSide(color: DS.border)),
//         ),
//         child: Row(children: [
//           Container(
//             width: 52, height: 52,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: DS.accent.withOpacity(0.15),
//               border: Border.all(color: DS.accent.withOpacity(0.3), width: 1.5),
//             ),
//             child: Center(child: Text(firstLetter, style: _ts(22, FontWeight.w700, DS.accent))),
//           ),
//           const SizedBox(width: 14),
//           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(name,  style: _ts(16, FontWeight.w600)),
//             Text(email, style: _ts(11, FontWeight.w400, DS.textSecondary), overflow: TextOverflow.ellipsis),
//           ])),
//         ]),
//       ),
//       Expanded(
//         child: ListView(padding: const EdgeInsets.symmetric(vertical: 8), children: [
//           _drawerItem(Icons.person_outline,   'Profile'),
//           _drawerItem(Icons.bar_chart,         'Progress Report'),
//           _drawerItem(Icons.share_outlined,    'Share App'),
//           _drawerItem(Icons.settings_outlined, 'Settings'),
//           _drawerItem(Icons.help_outline,      'Help & Support'),
//         ]),
//       ),
//       Container(height: 1, color: DS.border),
//       ListTile(
//         leading: Container(width: 36, height: 36, decoration: BoxDecoration(color: DS.red.withOpacity(0.1), borderRadius: BorderRadius.circular(DS.r8)), child: const Icon(Icons.logout, color: DS.red, size: 18)),
//         title: Text('Logout', style: _ts(14, FontWeight.w500, DS.red)),
//         onTap: () {},
//       ),
//       const SizedBox(height: 16),
//     ]),
//   );
//
//   Widget _drawerItem(IconData icon, String title) => ListTile(
//     leading: Container(
//       width: 36, height: 36,
//       decoration: BoxDecoration(color: DS.accent.withOpacity(0.08), borderRadius: BorderRadius.circular(DS.r8)),
//       child: Icon(icon, color: DS.accent, size: 18),
//     ),
//     title: Text(title, style: _ts(13, FontWeight.w500)),
//     trailing: const Icon(Icons.chevron_right, color: DS.textSecondary, size: 18),
//     onTap: () {},
//   );
//
//   // ── Bottom nav ─────────────────────────────────────────────────────
//   Widget _buildNav() => Container(
//     decoration: BoxDecoration(
//       color: DS.surface,
//       border: const Border(top: BorderSide(color: DS.border, width: 1)),
//     ),
//     child: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _navItem(0, Icons.book_outlined,           'Textbook'),
//             _navItem(1, Icons.note_alt_outlined,       'Notes'),
//             _navItem(2, Icons.home_rounded,            'Home'),
//             _navItem(3, Icons.quiz_outlined,           'Quiz'),
//             _navItem(4, Icons.calendar_today_outlined, 'Schedule'),
//           ],
//         ),
//       ),
//     ),
//   );
//
//   Widget _navItem(int idx, IconData icon, String label) {
//     final active = idx == _navIndex;
//     return GestureDetector(
//       onTap: () => setState(() => _navIndex = idx),
//       behavior: HitTestBehavior.opaque,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//         decoration: BoxDecoration(
//           color: active ? DS.accent.withOpacity(0.12) : Colors.transparent,
//           borderRadius: BorderRadius.circular(DS.r12),
//         ),
//         child: Column(mainAxisSize: MainAxisSize.min, children: [
//           Icon(icon, color: active ? DS.accent : DS.textSecondary, size: 22),
//           const SizedBox(height: 3),
//           Text(label, style: _ts(9, active ? FontWeight.w600 : FontWeight.w400, active ? DS.accent : DS.textSecondary)),
//         ]),
//       ),
//     );
//   }
//
//   Widget _gap() => const SizedBox(height: 14);
// }
