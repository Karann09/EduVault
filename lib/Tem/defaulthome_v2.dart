import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// ══════════════════════════════════════════════════════════════════════
// DATA MODELS
// ══════════════════════════════════════════════════════════════════════

class VideoItem {
  final String title;
  final String description;
  final String youtubeUrl;
  final IconData icon;
  const VideoItem({
    required this.title,
    required this.description,
    required this.youtubeUrl,
    required this.icon,
  });
}

class SubjectProgress {
  final String name;
  final int completedChapters;
  final int totalChapters;
  final Color color;
  final IconData icon;
  const SubjectProgress({
    required this.name,
    required this.completedChapters,
    required this.totalChapters,
    required this.color,
    required this.icon,
  });
  double get percentage => completedChapters / totalChapters;
}

// ══════════════════════════════════════════════════════════════════════
// VIDEO PAGES (unchanged)
// ══════════════════════════════════════════════════════════════════════

class VideoListPage extends StatelessWidget {
  const VideoListPage({super.key});
  static const List<VideoItem> videos = [
    VideoItem(title: 'Introduction to Flutter', description: 'Learn the basics of Flutter development.', youtubeUrl: 'https://www.youtube.com/watch?v=qUgq8BwVqs4', icon: Icons.play_lesson),
    VideoItem(title: 'Dart Programming Basics', description: 'Understand Dart language fundamentals.', youtubeUrl: 'https://www.youtube.com/watch?v=veMhOYRib9o', icon: Icons.code),
    VideoItem(title: 'State Management', description: 'Learn how to manage state in Flutter apps.', youtubeUrl: 'https://www.youtube.com/watch?v=3tm-R7ymwhc', icon: Icons.developer_mode),
    VideoItem(title: 'UI/UX Design Principles', description: 'Design beautiful and intuitive interfaces.', youtubeUrl: 'https://www.youtube.com/watch?v=x0uinJvhNxI', icon: Icons.design_services),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: const Text('Video Lessons', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF4F7EFF),
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.08), blurRadius: 12, spreadRadius: 2, offset: const Offset(0, 4))],
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: Container(width: 52, height: 52, decoration: BoxDecoration(color: const Color(0xFF4F7EFF).withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(video.icon, color: const Color(0xFF4F7EFF), size: 28)),
              title: Text(video.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              subtitle: Padding(padding: const EdgeInsets.only(top: 4), child: Text(video.description, style: TextStyle(color: Colors.grey.shade600, fontSize: 13))),
              trailing: Container(width: 36, height: 36, decoration: const BoxDecoration(color: Color(0xFF4F7EFF), shape: BoxShape.circle), child: const Icon(Icons.play_arrow, color: Colors.white, size: 20)),
              // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => VideoPlayerPage(video: video))),
            ),
          );
        },
      ),
    );
  }
}

// class VideoPlayerPage extends StatefulWidget {
//   final VideoItem video;
//   const VideoPlayerPage({super.key, required this.video});
//   @override
//   State<VideoPlayerPage> createState() => _VideoPlayerPageState();
// }
//
// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late YoutubePlayerController _ytController;
//   @override
//   void initState() {
//     super.initState();
//   //   final videoId = YoutubePlayer.convertUrlToId(widget.video.youtubeUrl) ?? '';
//   //   _ytController = YoutubePlayerController(initialVideoId: videoId, flags: const YoutubePlayerFlags(autoPlay: true, mute: false, enableCaption: true));
//   //
//   }
//   @override
//   void dispose() { _ytController.dispose(); super.dispose(); }
//   @override
//   Widget build(BuildContext context) {
//     return YoutubePlayerBuilder(
//       player: YoutubePlayer(controller: _ytController, showVideoProgressIndicator: true, progressIndicatorColor: const Color(0xFF4F7EFF), progressColors: const ProgressBarColors(playedColor: Color(0xFF4F7EFF), handleColor: Color(0xFF2D5CE8)), onReady: () => _ytController.play()),
//       builder: (context, player) {
//         return Scaffold(
//           backgroundColor: const Color(0xFFF0F4FF),
//           appBar: AppBar(title: Text(widget.video.title, style: const TextStyle(color: Colors.white)), backgroundColor: const Color(0xFF4F7EFF), iconTheme: const IconThemeData(color: Colors.white)),
//           body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             player,
//             Padding(padding: const EdgeInsets.all(16), child: Container(width: double.infinity, padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.08), blurRadius: 8, spreadRadius: 2)]),
//                 child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(widget.video.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 8), Text(widget.video.description, style: TextStyle(fontSize: 14, color: Colors.grey.shade600))]))),
//           ]),
//         );
//       },
//     );
//   }
// }

// ══════════════════════════════════════════════════════════════════════
// PAINTERS
// ══════════════════════════════════════════════════════════════════════

class CircularProgressPainter extends CustomPainter {
  final double progress;
  final Color color;
  final Color trackColor;
  final double strokeWidth;
  CircularProgressPainter({required this.progress, required this.color, this.strokeWidth = 7, Color? trackColor})
      : trackColor = trackColor ?? color.withOpacity(0.13);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final bgPaint = Paint()..color = trackColor..strokeWidth = strokeWidth..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);
    if (progress > 0) {
      final paint = Paint()..color = color..strokeWidth = strokeWidth..style = PaintingStyle.stroke..strokeCap = StrokeCap.round;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, 2 * pi * progress.clamp(0.0, 1.0), false, paint);
    }
  }

  @override
  bool shouldRepaint(CircularProgressPainter old) => old.progress != progress || old.color != color;
}

// ══════════════════════════════════════════════════════════════════════
// ANIMATED FLOATING ICON
// ══════════════════════════════════════════════════════════════════════

class _FloatingIcon extends StatefulWidget {
  final IconData icon;
  final Color color;
  final double size;
  final Duration delay;
  const _FloatingIcon({required this.icon, required this.color, this.size = 22, this.delay = Duration.zero});
  @override
  State<_FloatingIcon> createState() => _FloatingIconState();
}

class _FloatingIconState extends State<_FloatingIcon> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2200));
    _anim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
    Future.delayed(widget.delay, () { if (mounted) _ctrl.repeat(reverse: true); });
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, -6 * _anim.value),
        child: Icon(widget.icon, color: widget.color, size: widget.size),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// PULSE DOT (for countdown)
// ══════════════════════════════════════════════════════════════════════

class _PulseDot extends StatefulWidget {
  final Color color;
  const _PulseDot({required this.color});
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _ctrl.repeat(reverse: true);
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => Container(
        width: 8 + 4 * _ctrl.value,
        height: 8 + 4 * _ctrl.value,
        decoration: BoxDecoration(shape: BoxShape.circle, color: widget.color.withOpacity(0.5 + 0.5 * _ctrl.value)),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// STUDY HOURS BAR
// ══════════════════════════════════════════════════════════════════════

class StudyHoursBar extends StatelessWidget {
  final double studiedHours;
  final double targetHours;
  const StudyHoursBar({super.key, required this.studiedHours, required this.targetHours});

  @override
  Widget build(BuildContext context) {
    final progress = (studiedHours / targetHours).clamp(0.0, 1.0);
    final pct = (progress * 100).toInt();
    final remaining = (targetHours - studiedHours).clamp(0.0, targetHours);
    Color barColor;
    String emoji;
    if (progress < 0.4) { barColor = const Color(0xFFFF6B6B); emoji = '🔥'; }
    else if (progress < 0.75) { barColor = const Color(0xFFFFB545); emoji = '⚡'; }
    else { barColor = const Color(0xFF4ADE80); emoji = '🎯'; }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF1A1F3C), Color(0xFF2D3561)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: const Color(0xFF1A1F3C).withOpacity(0.32), blurRadius: 18, offset: const Offset(0, 6))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text(emoji, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              const Text('Daily Study Goal', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
            ]),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: barColor.withOpacity(0.18), borderRadius: BorderRadius.circular(20), border: Border.all(color: barColor.withOpacity(0.45))),
              child: Text('$pct%', style: TextStyle(color: barColor, fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ]),
          const SizedBox(height: 14),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('${studiedHours.toStringAsFixed(1)}h studied', style: const TextStyle(color: Colors.white60, fontSize: 12)),
            Text('${targetHours.toStringAsFixed(0)}h target', style: const TextStyle(color: Colors.white60, fontSize: 12)),
          ]),
          const SizedBox(height: 8),
          Container(
            height: 11,
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  gradient: LinearGradient(colors: [barColor.withOpacity(0.8), barColor]),
                  boxShadow: [BoxShadow(color: barColor.withOpacity(0.4), blurRadius: 6)],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          remaining > 0
              ? Text('${remaining.toStringAsFixed(1)}h remaining to hit your goal', style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 11))
              : Row(children: [const Icon(Icons.check_circle, color: Color(0xFF4ADE80), size: 14), const SizedBox(width: 6), Text('Goal completed! Great work today!', style: TextStyle(color: const Color(0xFF4ADE80).withOpacity(0.9), fontSize: 11, fontWeight: FontWeight.w600))]),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// SUBJECT PROGRESS SECTION (with avg ring)
// ══════════════════════════════════════════════════════════════════════

class SubjectProgressSection extends StatelessWidget {
  final List<SubjectProgress> subjects;
  const SubjectProgressSection({super.key, required this.subjects});

  @override
  Widget build(BuildContext context) {
    final avg = subjects.fold(0.0, (s, e) => s + e.percentage) / subjects.length;
    final avgPct = (avg * 100).toInt();

    Color avgColor;
    String avgLabel;
    if (avg < 0.35) { avgColor = const Color(0xFFFF6B6B); avgLabel = 'Just Started'; }
    else if (avg < 0.65) { avgColor = const Color(0xFFFFB545); avgLabel = 'In Progress'; }
    else if (avg < 0.85) { avgColor = const Color(0xFF4F7EFF); avgLabel = 'Almost There'; }
    else { avgColor = const Color(0xFF4ADE80); avgLabel = 'Excellent!'; }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.09), blurRadius: 14, spreadRadius: 2, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Subject Progress', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1A1F3C))),
            TextButton(onPressed: () {}, child: const Text('View All', style: TextStyle(color: Color(0xFF4F7EFF), fontSize: 13))),
          ]),
          const SizedBox(height: 14),

          // ── Average + All Subjects in one row ──
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Big average ring
              _buildAvgRing(avg, avgPct, avgColor, avgLabel),
              const SizedBox(width: 14),
              // Subject rings grid
              Expanded(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: subjects.map((s) => _buildSubjectRing(s)).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvgRing(double avg, int avgPct, Color avgColor, String avgLabel) {
    return Column(
      children: [
        SizedBox(
          width: 88,
          height: 88,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: CircularProgressPainter(progress: avg, color: avgColor, strokeWidth: 9, trackColor: avgColor.withOpacity(0.12)),
                size: const Size(88, 88),
              ),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Text('$avgPct%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: avgColor)),
                Text('Avg', style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 6),
        Text('Overall', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Color(0xFF1A1F3C))),
        Text(avgLabel, style: TextStyle(fontSize: 10, color: avgColor, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildSubjectRing(SubjectProgress s) {
    final pct = (s.percentage * 100).toInt();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 54,
          height: 54,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                painter: CircularProgressPainter(progress: s.percentage, color: s.color, strokeWidth: 5.5),
                size: const Size(54, 54),
              ),
              Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(s.icon, color: s.color, size: 15),
                Text('$pct%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: s.color)),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(s.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 9, color: Color(0xFF1A1F3C))),
        Text('${s.completedChapters}/${s.totalChapters}', style: TextStyle(fontSize: 8, color: Colors.grey.shade400)),
      ],
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// EXAM COUNTDOWN WIDGET
// ══════════════════════════════════════════════════════════════════════

class ExamCountdownWidget extends StatefulWidget {
  final String examName;
  final DateTime examDate;
  const ExamCountdownWidget({super.key, required this.examName, required this.examDate});
  @override
  State<ExamCountdownWidget> createState() => _ExamCountdownWidgetState();
}

class _ExamCountdownWidgetState extends State<ExamCountdownWidget> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  Duration get _remaining {
    final now = DateTime.now();
    final diff = widget.examDate.difference(now);
    return diff.isNegative ? Duration.zero : diff;
  }

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _scaleAnim = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
    _ctrl.forward();
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final rem = _remaining;
    final days = rem.inDays;
    final hours = rem.inHours % 24;
    final months = days ~/ 30;
    final remDays = days % 30;

    final total = widget.examDate.difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    final elapsed = DateTime.now().difference(DateTime(DateTime.now().year, 1, 1)).inDays;
    final progress = elapsed / total.clamp(1, 999);

    Color urgencyColor;
    String urgencyMsg;
    String urgencyEmoji;
    if (days > 60) { urgencyColor = const Color(0xFF4ADE80); urgencyMsg = "Plenty of time — stay consistent!"; urgencyEmoji = "✅"; }
    else if (days > 30) { urgencyColor = const Color(0xFFFFB545); urgencyMsg = "Time to pick up the pace!"; urgencyEmoji = "⚠️"; }
    else if (days > 10) { urgencyColor = const Color(0xFFFF9F43); urgencyMsg = "Final sprint — focus hard!"; urgencyEmoji = "⚡"; }
    else { urgencyColor = const Color(0xFFFF6B6B); urgencyMsg = "Exam is near — all in now!"; urgencyEmoji = "🚨"; }

    return ScaleTransition(
      scale: _scaleAnim,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color(0xFF0F0C29), const Color(0xFF302B63), const Color(0xFF24243E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [BoxShadow(color: urgencyColor.withOpacity(0.25), blurRadius: 20, offset: const Offset(0, 6))],
          border: Border.all(color: urgencyColor.withOpacity(0.3), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              _PulseDot(color: urgencyColor),
              const SizedBox(width: 10),
              Text('Exam Countdown', style: TextStyle(color: urgencyColor, fontWeight: FontWeight.bold, fontSize: 14, letterSpacing: 0.5)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: urgencyColor.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                child: Text(urgencyEmoji + ' ' + urgencyMsg.split('—')[0].trim(), style: TextStyle(color: urgencyColor, fontSize: 10, fontWeight: FontWeight.w600)),
              ),
            ]),
            const SizedBox(height: 14),
            Text(widget.examName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
            Text(
              '${widget.examDate.day} ${_monthName(widget.examDate.month)} ${widget.examDate.year}',
              style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 12),
            ),
            const SizedBox(height: 18),

            // ── Time blocks ──
            Row(
              children: [
                if (months > 0) ...[
                  _timeBlock('$months', 'MONTHS', urgencyColor),
                  _timeSep(),
                ],
                _timeBlock('$remDays', 'DAYS', urgencyColor),
                _timeSep(),
                _timeBlock('$hours', 'HOURS', urgencyColor),
              ],
            ),

            const SizedBox(height: 16),

            // ── Year progress bar ──
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('Year progress', style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 11)),
                  Text('${(progress * 100).toInt()}%', style: TextStyle(color: urgencyColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ]),
                const SizedBox(height: 6),
                Container(
                  height: 6,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [urgencyColor.withOpacity(0.7), urgencyColor]),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text(urgencyMsg, style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 11, fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _timeBlock(String value, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(children: [
        Text(value, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24, height: 1)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.w700, letterSpacing: 1)),
      ]),
    );
  }

  Widget _timeSep() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 6),
    child: Text(':', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 22, fontWeight: FontWeight.bold)),
  );

  String _monthName(int m) => ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'][m - 1];
}

// ══════════════════════════════════════════════════════════════════════
// MOTIVATIONAL QUOTE BANNER (big, replacing slider)
// ══════════════════════════════════════════════════════════════════════

class MotivationalBanner extends StatefulWidget {
  const MotivationalBanner({super.key});
  @override
  State<MotivationalBanner> createState() => _MotivationalBannerState();
}

class _MotivationalBannerState extends State<MotivationalBanner> with TickerProviderStateMixin {
  int _idx = 0;
  late AnimationController _fadeCtrl;
  late Animation<double> _fade;
  late AnimationController _floatCtrl;
  late Animation<double> _float;

  final List<Map<String, String>> _quotes = [
    {"q": "Education is the most powerful weapon you can use to change the world.", "a": "Nelson Mandela", "e": "🌍"},
    {"q": "The beautiful thing about learning is that nobody can take it away from you.", "a": "B.B. King", "e": "🎓"},
    {"q": "An investment in knowledge pays the best interest.", "a": "Benjamin Franklin", "e": "💡"},
    {"q": "Success is no accident. It is hard work, perseverance & learning.", "a": "Pelé", "e": "🏆"},
    {"q": "Don't watch the clock; do what it does. Keep going.", "a": "Sam Levenson", "e": "⏰"},
  ];

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fade = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeIn);
    _fadeCtrl.forward();
    _floatCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
    _floatCtrl.repeat(reverse: true);

    Timer.periodic(const Duration(seconds: 8), (_) {
      if (!mounted) return;
      _fadeCtrl.reverse().then((_) {
        if (!mounted) return;
        setState(() => _idx = (_idx + 1) % _quotes.length);
        _fadeCtrl.forward();
      });
    });
  }

  @override
  void dispose() { _fadeCtrl.dispose(); _floatCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final q = _quotes[_idx];
    return AnimatedBuilder(
      animation: _floatCtrl,
      builder: (_, child) => Transform.translate(offset: Offset(0, -3 * _floatCtrl.value), child: child),
      child: FadeTransition(
        opacity: _fade,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 28),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4F7EFF), Color(0xFF7C3AED)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.35), blurRadius: 22, offset: const Offset(0, 8)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(q['e']!, style: const TextStyle(fontSize: 38)),
              const SizedBox(height: 14),
              Text(
                '"${q['q']!}"',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  height: 1.55,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 14),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 30, height: 1.5, color: Colors.white38),
                const SizedBox(width: 10),
                Text('— ${q['a']!}', style: const TextStyle(color: Colors.white70, fontSize: 13, fontStyle: FontStyle.italic)),
                const SizedBox(width: 10),
                Container(width: 30, height: 1.5, color: Colors.white38),
              ]),
              const SizedBox(height: 16),
              // Dot indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_quotes.length, (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: i == _idx ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(color: i == _idx ? Colors.white : Colors.white38, borderRadius: BorderRadius.circular(3)),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// STREAK WIDGET
// ══════════════════════════════════════════════════════════════════════

class StreakWidget extends StatelessWidget {
  final int streakDays;
  const StreakWidget({super.key, required this.streakDays});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFFFF9F43), Color(0xFFFF6B6B)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: const Color(0xFFFF9F43).withOpacity(0.3), blurRadius: 14, offset: const Offset(0, 4))],
      ),
      child: Row(children: [
        const Text('🔥', style: TextStyle(fontSize: 30)),
        const SizedBox(width: 10),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$streakDays Day Streak!', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('You\'re on fire! Keep it up', style: TextStyle(color: Colors.white70, fontSize: 12)),
        ]),
        const Spacer(),
        Row(children: List.generate(7, (i) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          width: 9,
          height: 9,
          decoration: BoxDecoration(shape: BoxShape.circle, color: i < (streakDays % 7 == 0 ? 7 : streakDays % 7) ? Colors.white : Colors.white30),
        ))),
      ]),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// TODAY'S TASKS
// ══════════════════════════════════════════════════════════════════════

class TodayTask { final String title; bool isDone; TodayTask({required this.title, this.isDone = false}); }

class TodayTasksWidget extends StatefulWidget {
  const TodayTasksWidget({super.key});
  @override
  State<TodayTasksWidget> createState() => _TodayTasksWidgetState();
}

class _TodayTasksWidgetState extends State<TodayTasksWidget> {
  final List<TodayTask> tasks = [
    TodayTask(title: 'Complete Maths Chapter 5', isDone: true),
    TodayTask(title: 'Revise Science Notes'),
    TodayTask(title: 'Practice Hindi Grammar'),
    TodayTask(title: 'Solve 10 Quiz Questions'),
  ];

  @override
  Widget build(BuildContext context) {
    final done = tasks.where((t) => t.isDone).length;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.08), blurRadius: 14, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              const _FloatingIcon(icon: Icons.checklist_rounded, color: Color(0xFF4F7EFF), size: 22),
              const SizedBox(width: 8),
              const Text("Today's Tasks", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A1F3C))),
            ]),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF4ADE80).withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
              child: Text('$done/${tasks.length}', style: const TextStyle(color: Color(0xFF16A34A), fontWeight: FontWeight.bold, fontSize: 13)),
            ),
          ]),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: done / tasks.length, backgroundColor: Colors.grey.shade100, valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4ADE80)), minHeight: 5),
          ),
          const SizedBox(height: 12),
          ...tasks.map((task) => GestureDetector(
            onTap: () => setState(() => task.isDone = !task.isDone),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    color: task.isDone ? const Color(0xFF4F7EFF) : Colors.transparent,
                    border: Border.all(color: task.isDone ? const Color(0xFF4F7EFF) : Colors.grey.shade300, width: 2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: task.isDone ? const Icon(Icons.check, size: 14, color: Colors.white) : null,
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(task.title, style: TextStyle(fontSize: 13, color: task.isDone ? Colors.grey.shade400 : const Color(0xFF1A1F3C), decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none))),
              ]),
            ),
          )),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════
// WEEKLY SUMMARY
// ══════════════════════════════════════════════════════════════════════

class WeeklySummaryCard extends StatelessWidget {
  const WeeklySummaryCard({super.key});
  @override
  Widget build(BuildContext context) {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final hours = [4.5, 6.0, 3.2, 6.0, 5.5, 2.1, 1.0];
    const maxH = 6.0;
    final today = DateTime.now().weekday - 1;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.08), blurRadius: 14, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const _FloatingIcon(icon: Icons.bar_chart_rounded, color: Color(0xFF4F7EFF), size: 22, delay: Duration(milliseconds: 300)),
            const SizedBox(width: 8),
            const Text("This Week's Activity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1A1F3C))),
          ]),
          Text("Daily study hours", style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (i) {
              final h = hours[i];
              final isTarget = h >= maxH;
              final isToday = i == today;
              final barH = (h / maxH) * 80;
              return Column(mainAxisSize: MainAxisSize.min, children: [
                Text('${h.toStringAsFixed(1)}h', style: TextStyle(fontSize: 9, color: isTarget ? const Color(0xFF4F7EFF) : Colors.grey.shade400, fontWeight: isTarget ? FontWeight.bold : FontWeight.normal)),
                const SizedBox(height: 4),
                Container(
                  width: 28,
                  height: barH,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    gradient: LinearGradient(
                      colors: isToday
                          ? [const Color(0xFF7C3AED), const Color(0xFF4F7EFF)]
                          : isTarget
                          ? [const Color(0xFF4F7EFF), const Color(0xFF2D5CE8)]
                          : [Colors.grey.shade200, Colors.grey.shade300],
                      begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    ),
                    boxShadow: isToday || isTarget ? [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.3), blurRadius: 6, offset: const Offset(0, 2))] : [],
                  ),
                ),
                const SizedBox(height: 6),
                Text(days[i], style: TextStyle(fontSize: 12, color: isToday ? const Color(0xFF4F7EFF) : Colors.grey.shade500, fontWeight: isToday ? FontWeight.bold : FontWeight.normal)),
                if (isToday) Container(margin: const EdgeInsets.only(top: 2), width: 5, height: 5, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF4F7EFF))),
              ]);
            }),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(14)),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              _statItem('28.3h', 'Total Hours', const Color(0xFF4F7EFF)),
              Container(height: 30, width: 1, color: Colors.grey.shade300),
              _statItem('4.0h', 'Daily Avg', const Color(0xFFFF9F43)),
              Container(height: 30, width: 1, color: Colors.grey.shade300),
              _statItem('2 days', 'Goal Hit', const Color(0xFF4ADE80)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String v, String l, Color c) => Column(children: [
    Text(v, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: c)),
    const SizedBox(height: 2),
    Text(l, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
  ]);
}

// ══════════════════════════════════════════════════════════════════════
// MAIN HOME PAGE
// ══════════════════════════════════════════════════════════════════════

class Defaulthome extends StatefulWidget {
  const Defaulthome({super.key});
  @override
  State<Defaulthome> createState() => _DefaulthomeState();
}

class _DefaulthomeState extends State<Defaulthome> with TickerProviderStateMixin {
  int _selectedNavIndex = 2;

  // Study timer
  double studiedHours = 3.0;
  double targetHours = 6.0;

  // Streak
  int streakDays = 12;

  String name = "Rohan";
  String email = "rohan@email.com";
  String firstLetter = "R";

  // ── CHANGE THIS DATE for your actual exam ──
  final DateTime examDate = DateTime(2026, 3, 22);
  final String examName = "Final Board Examination 2026";

  // Subjects
  final List<SubjectProgress> subjects = const [
    SubjectProgress(name: 'Science',   completedChapters: 4,  totalChapters: 10, color: Color(0xFF4F7EFF), icon: Icons.science),
    SubjectProgress(name: 'Maths',     completedChapters: 7,  totalChapters: 12, color: Color(0xFFFF6B6B), icon: Icons.calculate),
    SubjectProgress(name: 'English',   completedChapters: 5,  totalChapters: 8,  color: Color(0xFF4ADE80), icon: Icons.menu_book),
    SubjectProgress(name: 'Hindi',     completedChapters: 3,  totalChapters: 10, color: Color(0xFFFFB545), icon: Icons.translate),
    SubjectProgress(name: 'Marathi',   completedChapters: 2,  totalChapters: 9,  color: Color(0xFFA855F7), icon: Icons.language),
    SubjectProgress(name: 'Soc. Sci.', completedChapters: 6,  totalChapters: 14, color: Color(0xFF06B6D4), icon: Icons.public),
  ];

  // Entry animation
  late AnimationController _entryCtrl;
  late Animation<double> _entryFade;
  late Animation<Offset> _entrySlide;

  @override
  void initState() {
    super.initState();
    _entryCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _entryFade = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
    _entrySlide = Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero)
        .animate(CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut));
    _entryCtrl.forward();
  }

  @override
  void dispose() { _entryCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F4FF),

        // ── AppBar ──────────────────────────────────────────────────
        appBar: AppBar(
          title: Row(children: [
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: const Center(child: Text('📚', style: TextStyle(fontSize: 16))),
            ),
            const SizedBox(width: 10),
            const Text("EduVault", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1.2)),
          ]),
          backgroundColor: const Color(0xFF4F7EFF),
          iconTheme: const IconThemeData(color: Colors.white),
          elevation: 0,
          actions: [
            Stack(children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
              Positioned(right: 10, top: 10, child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Color(0xFFFF6B6B), shape: BoxShape.circle))),
            ]),
          ],
        ),

        // ── Drawer ──────────────────────────────────────────────────
        drawer: Drawer(
          width: 270,
          backgroundColor: const Color(0xFFF0F4FF),
          child: Column(children: [
            DrawerHeader(
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF4F7EFF), Color(0xFF2D5CE8)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(width: 70, height: 70, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)]), child: Center(child: Text(firstLetter, style: const TextStyle(fontSize: 28, color: Color(0xFF4F7EFF), fontWeight: FontWeight.bold)))),
                const SizedBox(height: 10),
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                Text(email, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ])),
            ),
            Expanded(child: ListView(padding: EdgeInsets.zero, children: [
              _drawerItem(Icons.person_outline, "Profile", () {}),
              _drawerItem(Icons.bar_chart, "Progress Report", () {}),
              _drawerItem(Icons.share, "Share App", () {}),
              _drawerItem(Icons.settings, "Settings", () {}),
              _drawerItem(Icons.help_outline, "Help & Support", () {}),
            ])),
            const Divider(),
            ListTile(leading: const Icon(Icons.logout, color: Colors.red), title: const Text("Logout", style: TextStyle(color: Colors.red)), onTap: () {}),
            const SizedBox(height: 20),
          ]),
        ),

        // ── Body ────────────────────────────────────────────────────
        body: FadeTransition(
          opacity: _entryFade,
          child: SlideTransition(
            position: _entrySlide,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ── Welcome Banner ──────────────────────────────
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF4F7EFF), Color(0xFF2D5CE8)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.38), blurRadius: 18, offset: const Offset(0, 6))],
                      ),
                      child: Row(children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text("Hello, $name! 👋", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                          const SizedBox(height: 4),
                          const Text("Ready to learn something new?", style: TextStyle(color: Colors.white70, fontSize: 13)),
                          const SizedBox(height: 12),
                          Row(children: [
                            _statChip("🔥 $streakDays day streak"),
                            const SizedBox(width: 8),
                            _statChip("⭐ Level 5"),
                          ]),
                        ])),
                        const SizedBox(width: 12),
                        // Animated floating icon cluster
                        Column(mainAxisSize: MainAxisSize.min, children: [
                          Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle), child: Center(child: Text(firstLetter, style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)))),
                          const SizedBox(height: 6),
                          Row(children: const [
                            _FloatingIcon(icon: Icons.star, color: Colors.yellow, size: 14, delay: Duration(milliseconds: 0)),
                            SizedBox(width: 4),
                            _FloatingIcon(icon: Icons.star, color: Colors.yellow, size: 14, delay: Duration(milliseconds: 300)),
                            SizedBox(width: 4),
                            _FloatingIcon(icon: Icons.star, color: Colors.yellow, size: 14, delay: Duration(milliseconds: 600)),
                          ]),
                        ]),
                      ]),
                    ),

                    const SizedBox(height: 18),

                    // ── Motivational Banner (replaces image slider) ──
                    const MotivationalBanner(),

                    const SizedBox(height: 18),

                    // ── Daily Study Goal Bar ────────────────────────
                    StudyHoursBar(studiedHours: studiedHours, targetHours: targetHours),

                    const SizedBox(height: 18),

                    // ── Exam Countdown ──────────────────────────────
                    ExamCountdownWidget(examName: examName, examDate: examDate),

                    const SizedBox(height: 18),

                    // ── Streak ──────────────────────────────────────
                    StreakWidget(streakDays: streakDays),

                    const SizedBox(height: 20),

                    // ── Quick Access ────────────────────────────────
                    Row(children: [
                      const _FloatingIcon(icon: Icons.flash_on, color: Color(0xFF4F7EFF), size: 20, delay: Duration(milliseconds: 200)),
                      const SizedBox(width: 6),
                      const Text("Quick Access", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF1A1F3C))),
                    ]),
                    const SizedBox(height: 12),

                    GridView.count(
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.82,
                      children: [
                        _quickIconCard(icon: Icons.play_circle_fill, label: "Videos",      color: const Color(0xFF4F7EFF), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const VideoListPage()))),
                        _quickIconCard(icon: Icons.book_outlined,       label: "Textbooks", color: const Color(0xFFFF9F43), onTap: () {}),
                        _quickIconCard(icon: Icons.note_alt_outlined,   label: "Notes",     color: const Color(0xFF4ADE80), onTap: () {}),
                        _quickIconCard(icon: Icons.quiz_outlined,        label: "Quiz",      color: const Color(0xFFA855F7), onTap: () {}),
                        _quickIconCard(icon: Icons.calendar_today,       label: "Timetable", color: const Color(0xFF06B6D4), onTap: () {}),
                        _quickIconCard(icon: Icons.leaderboard,          label: "Leaders",   color: const Color(0xFFFF6B6B), onTap: () {}),
                        _quickIconCard(icon: Icons.assignment_outlined,  label: "Tasks",     color: const Color(0xFF10B981), onTap: () {}),
                        _quickIconCard(icon: Icons.timer_outlined,       label: "Pomodoro",  color: const Color(0xFFF43F5E), onTap: () {}),
                      ],
                    ),

                    const SizedBox(height: 22),

                    // ── Subject Progress (with Avg Ring) ───────────
                    SubjectProgressSection(subjects: subjects),

                    const SizedBox(height: 22),

                    // ── Today's Tasks ───────────────────────────────
                    const TodayTasksWidget(),

                    const SizedBox(height: 22),

                    // ── Weekly Activity ─────────────────────────────
                    const WeeklySummaryCard(),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),

        // ── Bottom Navigation Bar ────────────────────────────────────
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            boxShadow: [BoxShadow(color: const Color(0xFF4F7EFF).withOpacity(0.1), blurRadius: 20, spreadRadius: 2)],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(28), topRight: Radius.circular(28)),
            child: BottomNavigationBar(
              currentIndex: _selectedNavIndex,
              onTap: (i) => setState(() => _selectedNavIndex = i),
              elevation: 0,
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: const Color(0xFF4F7EFF),
              unselectedItemColor: Colors.grey.shade400,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              showUnselectedLabels: true,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.book_outlined),              label: 'Textbook'),
                BottomNavigationBarItem(icon: Icon(Icons.note_alt_outlined),          label: 'Notes'),
                BottomNavigationBarItem(icon: Icon(Icons.home_rounded),               label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.quiz_outlined),              label: 'Quiz'),
                BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined),    label: 'Timetable'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Helper: Stat Chip ──────────────────────────────────────────────
  Widget _statChip(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.3))),
    child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600)),
  );

  // ── Helper: Quick Icon Card ────────────────────────────────────────
  Widget _quickIconCard({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 8, spreadRadius: 1)],
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.12), shape: BoxShape.circle), child: Icon(icon, color: color, size: 22)),
          const SizedBox(height: 6),
          Text(label, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
        ]),
      ),
    );
  }

  // ── Helper: Drawer Item ────────────────────────────────────────────
  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) => ListTile(
    leading: Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFF4F7EFF).withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: const Color(0xFF4F7EFF), size: 20)),
    trailing: const Icon(Icons.chevron_right, size: 18),
    title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
    onTap: onTap,
  );
}
