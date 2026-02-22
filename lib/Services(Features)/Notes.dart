import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfx/pdfx.dart';

class Notes extends StatelessWidget {
  final int selectedClass;
  Notes({required this.selectedClass});

  final Map<String, String> subjectEmojis = {
    "English": "📖",
    "Hindi": "ॐ",
    "Marathi": "🚩",
    "Maths 1": "➗",
    "Maths 2": "✖️",
    "Science": "🧬",
    "Science 1": "🔬",
    "Science 2": "🦠", //"🧪"
    "History": "⏳", //"📜"
    "Geography": "🌍",
  };

  Future<List<dynamic>> getSubjects() async {
    final String response = await rootBundle.loadString('assets/Data.json');
    final data = json.decode(response);

    final classList = data['classes'] as List;
    final selectedClassData = classList.firstWhere(
      (c) => c['class_id'] == selectedClass.toString(),
      orElse: () => null,
    );

    return selectedClassData != null ? selectedClassData['subjects'] : [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: FutureBuilder<List<dynamic>>(
        future: getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Data not found. Check assets/Data.json"),
            );
          }

          final subjects = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.only(top: 20.0, left: 10, right: 10),
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final sub = subjects[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    maxRadius: 25,
                    backgroundColor: Colors.blue.shade50,
                    child: Text(
                      subjectEmojis[sub['subject_name']] ??
                          sub['subject_name'][0],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  title: Text(
                    sub['subject_name'],
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  // trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChapterListScreen(
                          subjectName: sub['subject_name'],
                          chapters: List<Map<String, dynamic>>.from(
                            sub['chapters'],
                          ),
                          selectedClass: selectedClass,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// --- CHAPTER LIST SCREEN ---
class ChapterListScreen extends StatelessWidget {
  final String subjectName;
  final List<Map<String, dynamic>> chapters;
  final int selectedClass;

  ChapterListScreen({
    required this.subjectName,
    required this.chapters,
    required this.selectedClass,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(subjectName),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          final chapter = chapters[index];
          return GestureDetector(
            onTap: () {
              // Dynamically creates path based on Class folder
              String fullPath =
                  "assets/Class_$selectedClass/${chapter['file']}";
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PDFViewerScreen(path: fullPath, title: chapter['name']),
                ),
              );
            },
            child: _buildChapterCard(chapter['no'].toString(), chapter['name']),
          );
        },
      ),
    );
  }

  Widget _buildChapterCard(String no, String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: const Color(0xFFF0F4F8),
            child: Text(
              no,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          // const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 20),
        ],
      ),
    );
  }
}

// --- PDF VIEWER SCREEN ---
class PDFViewerScreen extends StatefulWidget {
  final String path;
  final String title;

  PDFViewerScreen({required this.path, required this.title});

  @override
  State<PDFViewerScreen> createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  late PdfControllerPinch pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfControllerPinch(
      document: PdfDocument.openAsset(widget.path),
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PdfPageNumber(
            controller: pdfController,
            builder: (_, loadingState, page, pagesCount) => Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '$page / $pagesCount',
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
      body: PdfViewPinch(
        controller: pdfController,
        scrollDirection: Axis.vertical,
      ),
    );
  }
}
