import 'package:flutter/material.dart';

class Question {
  final String questionText;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctIndex,
  });
}

class QuestionPage extends StatefulWidget {
  final String subject;
  final Map<String, dynamic> chapter;

  const QuestionPage({super.key, required this.subject, required this.chapter});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  int currentQuestion = 0;
  late List<int?> selectedAnswers;
  late List<Question> questions;

  @override
  void initState() {
    super.initState();
    if (widget.subject == 'English' && widget.chapter['name'] == 'Life') {
      questions = [
        Question(
          questionText: 'What is the synonym of "Happy"?',
          options: ['Sad', 'Joyful', 'Angry', 'Tired'],
          correctIndex: 1,
        ),
        Question(
          questionText: 'Choose the correct sentence:',
          options: [
            'He go to school.',
            'He goes to school.',
            'He gone school.',
            'He going school.',
          ],
          correctIndex: 1,
        ),
        Question(
          questionText: 'What is the antonym of "Big"?',
          options: ['Large', 'Huge', 'Small', 'Tall'],
          correctIndex: 2,
        ),
        Question(
          questionText: 'Fill in the blank: She ___ a book.',
          options: ['reads', 'read', 'reading', 'readed'],
          correctIndex: 0,
        ),
        Question(
          questionText: 'Select the correct plural form of "Child":',
          options: ['Childs', 'Childes', 'Children', 'Child'],
          correctIndex: 2,
        ),
      ];
    } else {
      questions = [];
    }
    selectedAnswers = List<int?>.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    String titleName = widget.chapter['name'] ?? "Quiz";
    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            titleName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        backgroundColor: Color(0xFFF7FAFF),
        body: const Center(
          child: Text('No questions available for this chapter'),
        ),
      );
    }

    Question q = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Color(0xFFF7FAFF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Q${currentQuestion + 1}. ${q.questionText}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate(q.options.length, (index) {
              return ListTile(
                title: Text(
                  q.options[index],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                leading: Radio<int>(
                  value: index,
                  groupValue: selectedAnswers[currentQuestion],
                  onChanged: (value) {
                    setState(() {
                      selectedAnswers[currentQuestion] = value;
                    });
                  },
                ),
              );
            }),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentQuestion > 0)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade700,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 5, // Shadow
                    ),
                    onPressed: () {
                      setState(() {
                        currentQuestion--;
                      });
                    },
                    child: const Text('Previous'),
                  ),
                const Spacer(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent.shade700,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5, // Shadow
                  ),
                  onPressed: () {
                    if (currentQuestion < questions.length - 1) {
                      setState(() {
                        currentQuestion++;
                      });
                    } else {
                      int score = 0;
                      for (int i = 0; i < questions.length; i++) {
                        if (selectedAnswers[i] == questions[i].correctIndex) {
                          score++;
                        }
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultPage(score: score, total: questions.length),
                        ),
                      );
                    }
                  },
                  child: Text(
                    currentQuestion == questions.length - 1 ? 'Submit' : 'Next',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int score;
  final int total;
  const ResultPage({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    double percentage = (score / total) * 100;
    String feedback;
    IconData icon;

    if (percentage >= 80) {
      feedback = "🎉 Excellent!";
      icon = Icons.emoji_events;
    } else if (percentage >= 50) {
      feedback = "🙂 Good!";
      icon = Icons.thumb_up;
    } else {
      feedback = "😔 Try Again!";
      icon = Icons.thumb_down;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 80, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              'Your Score',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              '$score / $total',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: score / total,
              minHeight: 10,
              backgroundColor: Colors.grey.shade300,
              color: Colors.blue,
            ),
            const SizedBox(height: 20),
            Text(
              feedback,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry Quiz'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.menu_book),
                    label: const Text('Back to Chapters'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
