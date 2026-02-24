import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class Textbooks extends StatelessWidget {
  final int selectedClass;

  Textbooks({required this.selectedClass});

  final List<Map<String, String>> books9 = [
    {"name": "English", "fileName": "English.pdf", "image": "English.jpg"},
    {"name": "Hindi", "fileName": "Hindi.pdf", "image": "Hindi.jpg"},
    {"name": "Marathi", "fileName": "Marathi.pdf", "image": "Marathi.jpg"},
    {"name": "Science", "fileName": "Science.pdf", "image": "Science.jpg"},
    {"name": "Maths I", "fileName": "Maths_1.pdf", "image": "Maths 1.jpg"},
    {"name": "Maths II", "fileName": "Maths_2.pdf", "image": "Maths 2.jpg"},
    {"name": "History", "fileName": "History.pdf", "image": "History.jpg"},
    {"name": "Geography", "fileName": "Empty.pdf", "image": "Geography.jpg"},
  ];

  final List<Map<String, String>> books10 = [
    {"name": "English", "fileName": "English.pdf", "image": "English.jpg"},
    {"name": "Hindi", "fileName": "Hindi.pdf", "image": "Hindi.jpg"},
    {"name": "Marathi", "fileName": "Marathi.pdf", "image": "Marathi.jpg"},
    {
      "name": "Science I",
      "fileName": "Science_1.pdf",
      "image": "Science 1.jpg",
    },
    {"name": "Science II", "fileName": "Empty.pdf", "image": "Science 2.jpg"},
    {"name": "Maths I", "fileName": "Maths_1.pdf", "image": "Maths 1.jpg"},
    {"name": "Maths II", "fileName": "Maths_2.pdf", "image": "Maths 2.jpg"},
    {"name": "History", "fileName": "History.pdf", "image": "History.jpg"},
    {"name": "Geography", "fileName": "Empty.pdf", "image": "Geography.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> currentBooks = (selectedClass == 9)
        ? books9
        : books10;

    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: currentBooks.length,
        itemBuilder: (context, index) {
          final book = currentBooks[index];
          String assetPath = "assets/Class_$selectedClass/${book['fileName']}";
          String imagePath = "assets/Class_$selectedClass/${book['image']}";

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      PDFViewerPage(path: assetPath, title: book['name']!),
                ),
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Image.asset(imagePath, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      book['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
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

// PDF View karne ke liye
class PDFViewerPage extends StatefulWidget {
  final String path;
  final String title;

  const PDFViewerPage({Key? key, required this.path, required this.title})
    : super(key: key);

  @override
  State<PDFViewerPage> createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  late PdfController _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfController(
      document: PdfDocument.openAsset(widget.path),
      viewportFraction: 0.72,
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Center(
            child: PdfPageNumber(
              controller: _pdfController,
              builder: (_, loadingState, page, pagesCount) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  '$page / ${pagesCount ?? 0}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: PdfView(
        controller: _pdfController,
        scrollDirection: Axis.vertical,
        pageSnapping: false,
      ),
    );
  }
}
