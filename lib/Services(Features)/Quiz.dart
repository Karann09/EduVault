import 'package:eduvault/Services(Features)/QuestionPages.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class QuizPage extends StatefulWidget {
  final int selectedClass;

  QuizPage({required this.selectedClass});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, String>> books9 = [
    {"name": "English", "fileName": "English.pdf", "image": "English.jpg"},
    {"name": "Hindi", "fileName": "Hindi.pdf", "image": "hindi.png"},
    {"name": "Marathi", "fileName": "Marathi.pdf", "image": "marathi.jpeg"},
    {"name": "Science", "fileName": "Science.pdf", "image": "science.png"},
    {"name": "Maths I", "fileName": "Maths_1.pdf", "image": "maths1.jpg"},
    {"name": "Maths II", "fileName": "Maths_2.pdf", "image": "maths2.jpg"},
    {"name": "History", "fileName": "History.pdf", "image": "history.jpeg"},
    {"name": "Geography", "fileName": "Empty.pdf", "image": "geography.jpg"},
  ];

  final List<Map<String, String>> books10 = [
    {"name": "English", "fileName": "English.pdf", "image": "English.jpg"},
    {"name": "Hindi", "fileName": "Hindi.pdf", "image": "hindi.png"},
    {"name": "Marathi", "fileName": "Marathi.pdf", "image": "marathi.jpeg"},
    {"name": "Science I", "fileName": "Science_1.pdf", "image": "science.png"},
    {"name": "Science II", "fileName": "Empty.pdf", "image": "science2.png"},
    {"name": "Maths I", "fileName": "Maths_1.pdf", "image": "maths1.jpg"},
    {"name": "Maths II", "fileName": "Maths_2.pdf", "image": "maths2.jpg"},
    {"name": "History", "fileName": "History.pdf", "image": "history.jpeg"},
    {"name": "Geography", "fileName": "Empty.pdf", "image": "geography.jpg"},
  ];

  Future<void> _navigateToChapters(
    BuildContext context,
    String subjectName,
  ) async {
    try {
      final String response = await rootBundle.loadString('assets/Data.json');
      final data = await json.decode(response);

      var classData = data['classes'].firstWhere(
        (c) => c['class_id'].toString() == widget.selectedClass.toString(),
        orElse: () => null,
      );

      if (classData != null) {
        var subjectData = classData['subjects'].firstWhere((s) {
          String jsonSub = s['subject_name']
              .toString()
              .toLowerCase()
              .replaceAll(' ', '');
          String listSub = subjectName.toLowerCase().replaceAll(' ', '');

          return jsonSub == listSub ||
              jsonSub == listSub.replaceAll('ii', '2').replaceAll('i', '1');
        }, orElse: () => null);

        if (subjectData != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChapterListScreen(
                subjectName: subjectName,
                chapters: List<Map<String, dynamic>>.from(
                  subjectData['chapters'],
                ),
                selectedClass: widget.selectedClass,
              ),
            ),
          );
        } else {
          _showError(context, "Subject '$subjectName' not found in JSON");
        }
      } else {
        _showError(context, "Class ${widget.selectedClass} not found in JSON");
      }
    } catch (e) {
      _showError(context, "Error loading Data.json: $e");
    }
  }

  void _showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentClass = (widget.selectedClass == 9)
        ? books9
        : books10;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GridView.builder(
          itemCount: currentClass.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            final subject = currentClass[index];
            String imagePath = "assets/Ridimages/${subject['image']}";

            return GestureDetector(
              onTap: () => _navigateToChapters(context, subject['name']!),
              child: Card(
                color: Colors.white,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        imagePath,
                        height: 110,
                        width: 120,
                        errorBuilder: (c, e, s) =>
                            const Icon(Icons.book, size: 50),
                      ),
                      const SizedBox(height: 0),
                      Text(
                        subject['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ChapterListScreen extends StatefulWidget {
  final String subjectName;
  final List<Map<String, dynamic>> chapters;
  final int selectedClass;

  ChapterListScreen({
    required this.subjectName,
    required this.chapters,
    required this.selectedClass,
  });

  @override
  _ChapterListScreenState createState() => _ChapterListScreenState();
}

class _ChapterListScreenState extends State<ChapterListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(widget.subjectName),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.chapters.length,
        itemBuilder: (context, index) {
          final chapter = widget.chapters[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuestionPage(
                    subject: widget.subjectName,
                    chapter: widget.chapters[index],
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.blue.shade100,
                    child: Text(
                      chapter['no'].toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      chapter['name'],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
